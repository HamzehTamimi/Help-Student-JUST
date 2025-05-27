import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class GuidanceScreen extends StatefulWidget {
  const GuidanceScreen({super.key});

  @override
  State<GuidanceScreen> createState() => _GuidanceScreenState();
}

class _GuidanceScreenState extends State<GuidanceScreen> {
  final TextEditingController _gpaController = TextEditingController();
  String selectedAcademicYear = 'First Year';
  String selectedSemester = 'First Semester';
  String selectedSpecialty = 'Computer Information Systems'; // Added specialty
  String? selectedGPA;
  bool isLoading = true;
  bool isGeneratingPlan = false;

  // Store courses data
  Map<String, dynamic> departmentsData = {};
  List<String> incompleteCourses = [];
  List<Map<String, dynamic>> recommendedCourses = [];

  // List of specialties
  final List<String> specialties = [
    'Computer Information Systems',
    'Computer Science',
  ];

  @override
  void initState() {
    super.initState();
    // Delay Firebase fetch slightly to ensure widget is mounted
    Future.delayed(Duration.zero, () {
      _fetchCoursesData();
    });
  }

  @override
  void dispose() {
    _gpaController.dispose();
    super.dispose();
  }

  // Fetch courses data from Firebase
  Future<void> _fetchCoursesData() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      print('Attempting to fetch data from Firebase...');
      final ref = FirebaseDatabase.instance.ref();
      final departmentsSnapshot = await ref.child('departments').get();

      if (!mounted) return;

      if (departmentsSnapshot.exists) {
        print('Data retrieved successfully');
        final data = departmentsSnapshot.value;
        setState(() {
          departmentsData = Map<String, dynamic>.from(data as Map);
          isLoading = false;
        });
        print('Departments found: ${departmentsData.keys.join(', ')}');
      } else {
        print('No data found at departments path');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'No departments data available. Check your database path.',
              ),
            ),
          );
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error fetching data: $e')));
        setState(() {
          isLoading = false;
          departmentsData =
              {}; // Initialize with empty data to prevent further errors
        });
      }
    }
  }

  // Convert academic year string to numeric value
  int _getYearValue(String year) {
    switch (year) {
      case 'First Year':
        return 1;
      case 'Second Year':
        return 2;
      case 'Third Year':
        return 3;
      case 'Fourth Year':
        return 4;
      default:
        return 1;
    }
  }

  // Convert semester string to numeric value
  int _getSemesterValue(String semester) {
    return semester == 'First Semester' ? 1 : 2;
  }

  // Generate study plan based on user inputs
  void _generateStudyPlan() {
    if (_gpaController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter your GPA')));
      return;
    }

    setState(() {
      isGeneratingPlan = true;
      selectedGPA = _gpaController.text;
    });

    try {
      final double gpa = double.parse(_gpaController.text);
      final int yearValue = _getYearValue(selectedAcademicYear);
      final int semesterValue = _getSemesterValue(selectedSemester);

      if (departmentsData.isEmpty) {
        throw Exception("No course data available");
      }

      // Map specialty to department key
      String selectedDepartment = 'cis'; // Default

      // In a real app, you would map the user-friendly specialty name to the database key
      if (selectedSpecialty == 'Computer Science') {
        selectedDepartment = 'cs';
      } else if (selectedSpecialty == 'Software Engineering') {
        selectedDepartment = 'se';
      } else if (selectedSpecialty == 'Data Science') {
        selectedDepartment = 'ds';
      } else if (selectedSpecialty == 'Cybersecurity') {
        selectedDepartment = 'cyber';
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
            if (yearValue < 3) {
              isEligible =
                  false; // Require at least 3rd year for courses with completion prerequisites
            }
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
        recommendedCourses = recommendedList;
        isGeneratingPlan = false;
      });
    } catch (e) {
      print('Error generating plan: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error generating plan: $e')));
      setState(() {
        isGeneratingPlan = false;
      });
    }
  }

  // Show dialog to select incomplete courses
  void _showIncompleteCoursesDialog() {
    if (departmentsData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please wait for courses data to load')),
      );
      return;
    }

    // Map specialty to department key
    String selectedDepartment = 'cis'; // Default

    // In a real app, you would map the user-friendly specialty name to the database key
    if (selectedSpecialty == 'Computer Science') {
      selectedDepartment = 'cs';
    } else if (selectedSpecialty == 'Software Engineering') {
      selectedDepartment = 'se';
    } else if (selectedSpecialty == 'Data Science') {
      selectedDepartment = 'ds';
    } else if (selectedSpecialty == 'Cybersecurity') {
      selectedDepartment = 'cyber';
    }

    // Fallback if the mapped department doesn't exist
    if (!departmentsData.containsKey(selectedDepartment)) {
      selectedDepartment = departmentsData.keys.first;
    }

    final courses = Map<String, dynamic>.from(
      departmentsData[selectedDepartment]['study_plan']['courses'] as Map,
    );

    // Create a temporary list to track selections
    final List<String> tempSelected = List.from(incompleteCourses);

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Select Incomplete Courses'),
            content: SizedBox(
              width: double.maxFinite,
              height: 300,
              child: StatefulBuilder(
                builder: (context, setDialogState) {
                  return ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final courseCode = courses.keys.elementAt(index);
                      final courseData =
                          courses[courseCode] as Map<dynamic, dynamic>;

                      return CheckboxListTile(
                        title: Text('$courseCode: ${courseData['name']}'),
                        subtitle: Text(
                          'Year ${courseData['year']}, Semester ${courseData['semester']}',
                        ),
                        value: tempSelected.contains(courseCode),
                        onChanged: (bool? value) {
                          setDialogState(() {
                            if (value == true) {
                              tempSelected.add(courseCode);
                            } else {
                              tempSelected.remove(courseCode);
                            }
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    incompleteCourses = tempSelected;
                  });
                  Navigator.pop(context);
                },
                child: const Text('Confirm'),
              ),
            ],
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
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Top Form Fields
                    Expanded(
                      flex: 3,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Specialty dropdown (added)
                            const Text(
                              'Select your specialty',
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 5.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: selectedSpecialty,
                                items:
                                    specialties.map<DropdownMenuItem<String>>((
                                      String value,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedSpecialty = newValue!;
                                  });
                                },
                                underline: Container(),
                              ),
                            ),
                            const SizedBox(height: 15),

                            // GPA field
                            const Text(
                              'Enter your last semester GPA',
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _gpaController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintText: 'e.g. 3.5',
                              ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              onChanged: (value) {
                                selectedGPA = value;
                              },
                            ),
                            const SizedBox(height: 15),

                            // Academic year dropdown
                            const Text(
                              'Select your academic year',
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 5.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: selectedAcademicYear,
                                items:
                                    <String>[
                                      'First Year',
                                      'Second Year',
                                      'Third Year',
                                      'Fourth Year',
                                    ].map<DropdownMenuItem<String>>((
                                      String value,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedAcademicYear = newValue!;
                                  });
                                },
                                underline: Container(),
                              ),
                            ),
                            const SizedBox(height: 15),

                            // Semester dropdown
                            const Text(
                              'Select your semester',
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 5.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: selectedSemester,
                                items:
                                    <String>[
                                      'First Semester',
                                      'Second Semester',
                                    ].map<DropdownMenuItem<String>>((
                                      String value,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedSemester = newValue!;
                                  });
                                },
                                underline: Container(),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Action buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: _showIncompleteCoursesDialog,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[100],
                                  ),
                                  child: const Text(
                                    'Select Incomplete Courses',
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: _generateStudyPlan,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Generate Study Plan'),
                                ),
                              ],
                            ),

                            // Incomplete courses display
                            if (incompleteCourses.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  'Incomplete courses: ${incompleteCourses.join(", ")}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Study Plan Display
                    Expanded(
                      flex: 2,
                      child:
                          isGeneratingPlan
                              ? const Center(child: CircularProgressIndicator())
                              : recommendedCourses.isEmpty
                              ? const Center(
                                child: Text(
                                  'Generate a study plan to see recommendations',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              )
                              : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Course Code",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Course Name",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: recommendedCourses.length,
                                      itemBuilder: (context, index) {
                                        final course =
                                            recommendedCourses[index];
                                        return Container(
                                          margin: const EdgeInsets.only(top: 8),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(course['code'] as String),
                                              Flexible(
                                                child: Text(
                                                  course['name'] as String,
                                                  textAlign: TextAlign.end,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                    ),
                  ],
                ),
              ),
    );
  }
}
