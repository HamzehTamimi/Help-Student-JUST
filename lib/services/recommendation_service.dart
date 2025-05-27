import '../models/course.dart';
import '../models/student_profile.dart';
import 'prerequisite_checker.dart';

class RecommendationService {
  static List<Course> generateRecommendations({
    required List<Course> availableCourses,
    required StudentProfile profile,
  }) {
    // Filter eligible courses
    final eligibleCourses = _filterEligibleCourses(availableCourses, profile);
    
    // Sort by priority
    final prioritizedCourses = _prioritizeCourses(eligibleCourses, profile, availableCourses);
    
    // Select optimal course load
    return _selectOptimalCourseLoad(prioritizedCourses, profile);
  }

  static List<Course> _filterEligibleCourses(
    List<Course> courses, 
    StudentProfile profile
  ) {
    return courses.where((course) {
      // Skip completed courses
      if (profile.completedCourses.contains(course.code)) {
        return false;
      }

      // Include incomplete courses (high priority)
      if (profile.incompleteCourses.contains(course.code)) {
        return true;
      }

      // Skip currently enrolled courses
      if (profile.currentlyEnrolledCourses.contains(course.code)) {
        return false;
      }

      // Check if course is available for current academic standing
      if (!_isCourseAvailableForCurrentStanding(course, profile)) {
        return false;
      }

      // Check prerequisites
      return PrerequisiteChecker.arePrerequisitesMet(course, profile, courses);
    }).toList();
  }

  static bool _isCourseAvailableForCurrentStanding(Course course, StudentProfile profile) {
    // Summer courses - check if student can take them
    if (course.isSummerCourse()) {
      return profile.canTakeSummerCourses() && course.year <= profile.currentYear;
    }

    // Regular semester courses
    if (course.year < profile.currentYear) {
      return true; // Previous year courses are available
    }
    
    if (course.year == profile.currentYear) {
      // Current year courses
      if (course.getSemesterNumber() <= profile.currentSemester) {
        return true; // Current or previous semester
      } else if (course.getSemesterNumber() == profile.currentSemester + 1) {
        return profile.canTakeAdvancedCourses(); // Next semester for high GPA students
      }
    }
    
    if (course.year == profile.currentYear + 1 && profile.canTakeAdvancedCourses()) {
      return course.getSemesterNumber() == 1; // Next year first semester for exceptional students
    }

    return false;
  }

  static List<Course> _prioritizeCourses(
    List<Course> courses, 
    StudentProfile profile,
    List<Course> allCourses,
  ) {
    final prioritized = List<Course>.from(courses);
    
    prioritized.sort((a, b) {
      // Priority 1: Incomplete courses first (highest priority)
      final aIncomplete = profile.incompleteCourses.contains(a.code) ? 0 : 1;
      final bIncomplete = profile.incompleteCourses.contains(b.code) ? 0 : 1;
      if (aIncomplete != bIncomplete) return aIncomplete.compareTo(bIncomplete);

      // Priority 2: Core courses before electives
      final aElective = a.isElective ? 1 : 0;
      final bElective = b.isElective ? 1 : 0;
      if (aElective != bElective) return aElective.compareTo(bElective);

      // Priority 3: Courses that unlock other courses (prerequisite chains)
      final aUnlocks = _countCoursesUnlocked(a, allCourses, profile);
      final bUnlocks = _countCoursesUnlocked(b, allCourses, profile);
      if (aUnlocks != bUnlocks) return bUnlocks.compareTo(aUnlocks); // Higher unlock count first

      // Priority 4: Current semester courses
      final aCurrentSemester = (a.year == profile.currentYear && 
                               a.getSemesterNumber() == profile.currentSemester) ? 0 : 1;
      final bCurrentSemester = (b.year == profile.currentYear && 
                               b.getSemesterNumber() == profile.currentSemester) ? 0 : 1;
      if (aCurrentSemester != bCurrentSemester) {
        return aCurrentSemester.compareTo(bCurrentSemester);
      }

      // Priority 5: Graduation requirements (Practical Training, Graduation Project)
      final aGradReq = _isGraduationRequirement(a) ? 0 : 1;
      final bGradReq = _isGraduationRequirement(b) ? 0 : 1;
      if (aGradReq != bGradReq) return aGradReq.compareTo(bGradReq);

      // Priority 6: Year and semester order
      final yearComparison = a.year.compareTo(b.year);
      if (yearComparison != 0) return yearComparison;
      
      return a.getSemesterNumber().compareTo(b.getSemesterNumber());
    });

    return prioritized;
  }

  static int _countCoursesUnlocked(Course course, List<Course> allCourses, StudentProfile profile) {
    return allCourses.where((c) => 
      c.prerequisites.contains(course.code) && 
      !profile.completedCourses.contains(c.code)
    ).length;
  }

  static bool _isGraduationRequirement(Course course) {
    final gradRequirements = ['CIS391', 'CIS491', 'CIS492', 'CS391', 'CS491', 'CS492'];
    return gradRequirements.contains(course.code);
  }

  static List<Course> _selectOptimalCourseLoad(
    List<Course> prioritizedCourses, 
    StudentProfile profile
  ) {
    final selectedCourses = <Course>[];
    int totalCreditHours = 0;
    final maxCourses = profile.getRecommendedCourseCount();

    // First pass: Add high-priority courses (incomplete, graduation requirements)
    for (final course in prioritizedCourses) {
      if (selectedCourses.length >= maxCourses) break;
      
      final isHighPriority = profile.incompleteCourses.contains(course.code) ||
                            _isGraduationRequirement(course);
      
      if (isHighPriority && totalCreditHours + course.credits <= profile.maxCreditHours) {
        selectedCourses.add(course);
        totalCreditHours += course.credits;
      }
    }

    // Second pass: Fill remaining slots with other courses
    for (final course in prioritizedCourses) {
      if (selectedCourses.length >= maxCourses) break;
      if (selectedCourses.contains(course)) continue;
      
      if (totalCreditHours + course.credits <= profile.maxCreditHours) {
        selectedCourses.add(course);
        totalCreditHours += course.credits;
      }
    }

    return selectedCourses;
  }

  static Map<String, dynamic> generateRecommendationSummary(
    List<Course> recommendations,
    StudentProfile profile,
    List<Course> allCourses,
  ) {
    final totalCredits = recommendations.fold<int>(0, (sum, course) => sum + course.credits);
    final coreCoursesCount = recommendations.where((c) => !c.isElective).length;
    final electiveCoursesCount = recommendations.where((c) => c.isElective).length;
    final incompleteCoursesCount = recommendations.where((c) => 
      profile.incompleteCourses.contains(c.code)).length;
    
    final semesterDistribution = <String, int>{};
    for (final course in recommendations) {
      final semesterKey = 'Year ${course.year} - ${course.getSemesterDisplay()}';
      semesterDistribution[semesterKey] = (semesterDistribution[semesterKey] ?? 0) + 1;
    }

    return {
      'totalCourses': recommendations.length,
      'totalCredits': totalCredits,
      'coreCoursesCount': coreCoursesCount,
      'electiveCoursesCount': electiveCoursesCount,
      'incompleteCoursesCount': incompleteCoursesCount,
      'semesterDistribution': semesterDistribution,
      'utilizationPercentage': (totalCredits / profile.maxCreditHours * 100).round(),
    };
  }
}