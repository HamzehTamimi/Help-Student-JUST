import '../models/course.dart';
import '../models/student_profile.dart';

class PrerequisiteChecker {
  static bool arePrerequisitesMet(
    Course course, 
    StudentProfile profile,
    List<Course> allCourses,
  ) {
    if (!course.hasPrerequisites()) return true;

    for (final prereq in course.prerequisites) {
      if (!_isPrerequisiteMet(prereq, profile, allCourses)) {
        return false;
      }
    }
    return true;
  }

  static bool _isPrerequisiteMet(
    String prerequisite, 
    StudentProfile profile,
    List<Course> allCourses,
  ) {
    // Handle credit hour completion requirements
    if (prerequisite.contains("Completion")) {
      return _checkCreditHourCompletion(prerequisite, profile);
    }

    // Handle "Passing" requirements
    if (prerequisite.startsWith("Passing ")) {
      final courseCode = prerequisite.replaceFirst("Passing ", "");
      return profile.completedCourses.contains(courseCode);
    }

    // Handle concurrent enrollment
    if (prerequisite.contains("Concurrent") || prerequisite.contains("or Concurrent")) {
      final courseCode = prerequisite.split(" ").first;
      return profile.completedCourses.contains(courseCode) || 
             profile.currentlyEnrolledCourses.contains(courseCode);
    }

    // Direct course prerequisite
    return profile.completedCourses.contains(prerequisite);
  }

  static bool _checkCreditHourCompletion(String prerequisite, StudentProfile profile) {
    // Extract credit hours from strings like "Completion of 90 CHs" or "Completion 90 CHs"
    final regex = RegExp(r'(\d+)\s*CHs?');
    final match = regex.firstMatch(prerequisite);
    
    if (match != null) {
      final requiredCredits = int.parse(match.group(1)!);
      return profile.completedCreditHours >= requiredCredits;
    }
    
    return false;
  }

  static List<String> getMissingPrerequisites(
    Course course, 
    StudentProfile profile,
    List<Course> allCourses,
  ) {
    final missing = <String>[];
    
    for (final prereq in course.prerequisites) {
      if (!_isPrerequisiteMet(prereq, profile, allCourses)) {
        missing.add(prereq);
      }
    }
    
    return missing;
  }

  static List<Course> getPrerequisiteCourses(
    Course course,
    List<Course> allCourses,
  ) {
    final prerequisiteCourses = <Course>[];
    
    for (final prereq in course.prerequisites) {
      // Skip non-course prerequisites
      if (prereq.contains("Completion") || 
          prereq.contains("Concurrent") || 
          prereq.startsWith("Passing ")) {
        continue;
      }
      
      final prereqCourse = allCourses.firstWhere(
        (c) => c.code == prereq,
        orElse: () => Course(
          code: prereq,
          name: "Unknown Course",
          year: 1,
          semester: 1,
          credits: 3,
          department: "unknown",
        ),
      );
      
      prerequisiteCourses.add(prereqCourse);
    }
    
    return prerequisiteCourses;
  }
}