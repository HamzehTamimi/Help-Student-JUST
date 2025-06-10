import 'package:flutter/material.dart';
import '../models/course.dart';
import '../models/student_profile.dart';
import '../services/firebase_service.dart';
import '../services/recommendation_service.dart';
import '../widgets/student_info_form.dart';
import '../widgets/course_selection_dialog.dart';
import '../widgets/recommendations_display.dart';

class GuidanceScreen extends StatefulWidget {
  const GuidanceScreen({super.key});

  @override
  State<GuidanceScreen> createState() => _GuidanceScreenState();
}

class _GuidanceScreenState extends State<GuidanceScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  StudentProfile? _currentProfile;
  Map<String, List<Course>> _departmentCourses = {};
  List<String> _completedCourses = [];
  List<String> _incompleteCourses = [];
  List<Course> _recommendedCourses = [];

  bool _isLoadingData = true;
  bool _isGeneratingPlan = false;

  final Map<String, String> _specialtyToDepartment = {
    'Computer Information Systems': 'cis',
    'Computer Science': 'cs',
  };

  @override
  void initState() {
    super.initState();
    _loadCoursesData();
  }

  Future<void> _loadCoursesData() async {
    try {
      final courses = await _firebaseService.fetchAllDepartmentCourses();
      if (mounted) {
        setState(() {
          _departmentCourses = courses;
          _isLoadingData = false;
        });
        print('Loaded departments: ${_departmentCourses.keys.join(", ")}');
        _departmentCourses.forEach((dept, courseList) {
          print('$dept: ${courseList.length} courses');
        });
      }
    } catch (e) {
      if (mounted) {
        _showError('Failed to load courses data: $e');
        setState(() {
          _isLoadingData = false;
        });
      }
    }
  }

  void _onProfileChanged(StudentProfile profile) {
    setState(() {
      _currentProfile = profile;
      // Clear previous recommendations when profile changes
      _recommendedCourses = [];
    });
  }

  Future<void> _selectCompletedCourses() async {
    if (_currentProfile == null) {
      _showError('Please fill in your profile information first');
      return;
    }

    final availableCourses = _getCoursesForCurrentSpecialty();
    if (availableCourses.isEmpty) {
      _showError('No courses available for selected specialty');
      return;
    }

    final result = await showDialog<List<String>>(
      context: context,
      builder:
          (context) => CourseSelectionDialog(
            availableCourses: availableCourses,
            selectedCourses: _completedCourses,
            title: 'Select Completed Courses',
          ),
    );

    if (result != null) {
      setState(() {
        _completedCourses = result;
        // Remove completed courses from incomplete list
        _incompleteCourses.removeWhere(
          (course) => _completedCourses.contains(course),
        );
        // Clear recommendations to force regeneration
        _recommendedCourses = [];
      });
    }
  }

  Future<void> _selectIncompleteCourses() async {
    if (_currentProfile == null) {
      _showError('Please fill in your profile information first');
      return;
    }

    final availableCourses =
        _getCoursesForCurrentSpecialty()
            .where((course) => !_completedCourses.contains(course.code))
            .toList();

    if (availableCourses.isEmpty) {
      _showError('No incomplete courses available');
      return;
    }

    final result = await showDialog<List<String>>(
      context: context,
      builder:
          (context) => CourseSelectionDialog(
            availableCourses: availableCourses,
            selectedCourses: _incompleteCourses,
            title: 'Select Incomplete/Failed Courses',
          ),
    );

    if (result != null) {
      setState(() {
        _incompleteCourses = result;
        // Clear recommendations to force regeneration
        _recommendedCourses = [];
      });
    }
  }

  List<Course> _getCoursesForCurrentSpecialty() {
    if (_currentProfile == null) return [];

    final departmentKey = _specialtyToDepartment[_currentProfile!.specialty];
    if (departmentKey == null ||
        !_departmentCourses.containsKey(departmentKey)) {
      return [];
    }

    return _departmentCourses[departmentKey]!;
  }

  List<Course> _getAllCourses() {
    final allCourses = <Course>[];
    for (var courses in _departmentCourses.values) {
      allCourses.addAll(courses);
    }
    return allCourses;
  }

  void _generateStudyPlan() {
    if (_currentProfile == null) {
      _showError('Please fill in your profile information first');
      return;
    }

    setState(() {
      _isGeneratingPlan = true;
    });

    try {
      final availableCourses = _getCoursesForCurrentSpecialty();
      final allCourses =
          _getAllCourses(); // Not strictly needed for recommendation, but good for display

      if (availableCourses.isEmpty) {
        throw Exception("No courses available for selected specialty");
      }

      // Fallback if the mapped department doesn't exist
      if (!departmentsData.containsKey(selectedDepartment)) {
        selectedDepartment = departmentsData.keys.first;
      }

      // Get courses for the selected department
      final courses = Map<String, dynamic>.from(
        departmentsData[selectedDepartment]['study_plan']['courses'] as Map,
      );

      // Filter eligible courses based on year and semester
      final List<Map<String, dynamic>> eligibleCourses = [];

      courses.forEach((courseCode, courseData) {
        final courseInfo = Map<String, dynamic>.from(courseData as Map);
        courseInfo['code'] = courseCode;

        // Check if course is for current or future years/semesters
        final courseYear = courseInfo['year'] is int ? courseInfo['year'] : 1;
        final courseSemester =
            courseInfo['semester'] is int ? courseInfo['semester'] : 1;

        bool isEligible = false;

        // Current year courses in current semester
        if (courseYear == yearValue && courseSemester == semesterValue) {
          isEligible = true;
        }
        // Previous years' courses that might be incomplete
        else if (courseYear < yearValue) {
          isEligible = true;
        }
        // Next semester courses if GPA is high
        else if (courseYear == yearValue &&
            courseSemester > semesterValue &&
            gpa >= 3.0) {
          isEligible = true;
        }

        // Check prerequisites
        if (isEligible && courseInfo.containsKey('prerequisites')) {
          final prerequisites = List<String>.from(
            courseInfo['prerequisites'] as List,
          );
          // Simple check - in a real app, you'd verify if prerequisites are completed
          if (prerequisites.any((prereq) => prereq.contains('Completion'))) {
            if (yearValue < 3)
              isEligible =
                  false; // Require at least 3rd year for courses with completion prerequisites
          }
        }

        if (isEligible && !incompleteCourses.contains(courseCode)) {
          eligibleCourses.add(courseInfo);
        }
      });

      // Sort courses by difficulty (year and prerequisites count)
      eligibleCourses.sort((a, b) {
        // Primary sort by year
        final yearComparison = (a['year'] as int).compareTo(b['year'] as int);
        if (yearComparison != 0) return yearComparison;

        // Secondary sort by prerequisites count
        final aPrereqCount =
            a.containsKey('prerequisites')
                ? (a['prerequisites'] as List).length
                : 0;
        final bPrereqCount =
            b.containsKey('prerequisites')
                ? (b['prerequisites'] as List).length
                : 0;
        return aPrereqCount.compareTo(bPrereqCount);
      });

      // Adjust number of courses based on GPA
      int coursesToTake = 5; // Default
      if (gpa >= 3.5) {
        coursesToTake = 6; // More courses for high GPA
      } else if (gpa < 2.5) {
        coursesToTake = 4; // Fewer courses for low GPA
      }

      // Get final recommended courses
      final recommendedList = eligibleCourses.take(coursesToTake).toList();

      setState(() {
        _currentProfile = updatedProfile;
        _recommendedCourses = recommendations;
        _isGeneratingPlan = false;
      });

      if (recommendations.isEmpty) {
        _showInfo(
          'No courses to recommend based on your current profile. You may have completed all available courses or need to check prerequisites.',
        );
      } else {
        final totalCredits = recommendations.fold<int>(
          0,
          (sum, course) => sum + course.credits,
        );
        _showInfo(
          'Generated plan with ${recommendations.length} courses ($totalCredits credits)',
        );
      }
    } catch (e) {
      _showError('Error generating study plan: $e');
      setState(() {
        _isGeneratingPlan = false;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2), // Make error messages shorter
      ),
    );
  }

  void _showInfo(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2), // Make info messages shorter
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Guidance'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(187, 222, 251, 1),
        actions: [
          if (_departmentCourses.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () => _showDataInfo(),
              tooltip:
                  'View loaded course data info', // Add tooltip for better UX
            ),
        ],
      ),
      body:
          _isLoadingData
              ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading course data...'),
                  ],
                ),
              )
              : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8.0,
                ), // Reduced overall padding
                child: Column(
                  children: [
                    // Student Information Form and related sections
                    Expanded(
                      flex:
                          1, // This will make it take 50% of the available space
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          StudentInfoForm(
                            onProfileChanged: _onProfileChanged,
                            initialProfile: _currentProfile,
                          ),
                          const SizedBox(height: 12),
                          _buildActionButtons(),
                          if (_completedCourses.isNotEmpty ||
                              _incompleteCourses.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            _buildCourseStatusDisplay(),
                          ],
                          // Small gap before recommendations if the status display is shown
                          if (_completedCourses.isNotEmpty ||
                              _incompleteCourses.isNotEmpty)
                            const SizedBox(height: 12),
                        ],
                      ),
                    ),

                    // Recommendations Display
                    Expanded(
                      flex:
                          1, // This will also make it take 50% of the available space
                      child: RecommendationsDisplay(
                        recommendedCourses: _recommendedCourses,
                        profile: _currentProfile,
                        allCourses: _getAllCourses(),
                        isLoading: _isGeneratingPlan,
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildActionButtons() {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _selectCompletedCourses,
                icon: const Icon(Icons.check_circle, size: 18),
                label: Text(
                  'Completed Courses (${_completedCourses.length})',
                  style: const TextStyle(fontSize: 14),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[100],
                  foregroundColor: Colors.green[800],
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _selectIncompleteCourses,
                icon: const Icon(Icons.pending, size: 18),
                label: Text(
                  'Incomplete Courses (${_incompleteCourses.length})',
                  style: const TextStyle(fontSize: 14),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[100],
                  foregroundColor: Colors.orange[800],
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _generateStudyPlan,
                icon: const Icon(Icons.auto_awesome, size: 18),
                label: const Text(
                  'Generate Study Plan',
                  style: TextStyle(fontSize: 14),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(1, 87, 155, 1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseStatusDisplay() {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_completedCourses.isNotEmpty) ...[
              Text(
                'Completed Courses (${_completedCourses.length}):',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 3,
                runSpacing: 3,
                children:
                    _completedCourses
                        .map(
                          (code) => Chip(
                            label: Text(
                              code,
                              style: const TextStyle(fontSize: 11),
                            ),
                            backgroundColor: Colors.green[100],
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        )
                        .toList(),
              ),
              if (_incompleteCourses.isNotEmpty) const SizedBox(height: 8),
            ],
            if (_incompleteCourses.isNotEmpty) ...[
              Text(
                'Incomplete Courses (${_incompleteCourses.length}):',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 3,
                runSpacing: 3,
                children:
                    _incompleteCourses
                        .map(
                          (code) => Chip(
                            label: Text(
                              code,
                              style: const TextStyle(fontSize: 11),
                            ),
                            backgroundColor: Colors.orange[100],
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        )
                        .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showDataInfo() {
    final totalCourses = _departmentCourses.values.fold<int>(
      0,
      (sum, courses) => sum + courses.length,
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Course Data Information'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Departments: ${_departmentCourses.length}'),
                Text('Total Courses: $totalCourses'),
                const SizedBox(height: 8),
                ..._departmentCourses.entries.map(
                  (entry) => Text(
                    '${entry.key.toUpperCase()}: ${entry.value.length} courses',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }
}
