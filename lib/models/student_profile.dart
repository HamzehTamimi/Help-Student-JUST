class StudentProfile {
  final double gpa;
  final int currentYear;
  final int currentSemester;
  final String specialty;
  final List<String> completedCourses;
  final List<String> incompleteCourses;
  final List<String> currentlyEnrolledCourses;
  final int completedCreditHours;
  final int maxCreditHours;

  StudentProfile({
    required this.gpa,
    required this.currentYear,
    required this.currentSemester,
    required this.specialty,
    this.completedCourses = const [],
    this.incompleteCourses = const [],
    this.currentlyEnrolledCourses = const [],
    int? completedCreditHours,
    int? maxCreditHours,
  }) : completedCreditHours = completedCreditHours ?? _calculateCompletedCredits(completedCourses),
       maxCreditHours = maxCreditHours ?? _calculateMaxCreditHours(gpa);

  static int _calculateCompletedCredits(List<String> completedCourses) {
    // This would ideally calculate based on actual course credits
    // For now, assume average of 3 credits per course
    return completedCourses.length * 3;
  }

  static int _calculateMaxCreditHours(double gpa) {
    if (gpa >= 3.5) return 18;
    if (gpa >= 3.0) return 15;
    if (gpa >= 2.5) return 12;
    return 9;
  }

  bool canTakeAdvancedCourses() => gpa >= 3.0;
  
  bool shouldTakeReducedLoad() => gpa < 2.5;
  
  int getRecommendedCourseCount() {
    if (gpa >= 3.5) return 6;
    if (gpa >= 3.0) return 5;
    if (gpa >= 2.5) return 4;
    return 3;
  }

  bool canTakeSummerCourses() => gpa >= 2.5;

  bool isEligibleForPracticalTraining() => completedCreditHours >= 90;

  bool isEligibleForGraduationProject() => completedCreditHours >= 90;

  StudentProfile copyWith({
    double? gpa,
    int? currentYear,
    int? currentSemester,
    String? specialty,
    List<String>? completedCourses,
    List<String>? incompleteCourses,
    List<String>? currentlyEnrolledCourses,
    int? completedCreditHours,
    int? maxCreditHours,
  }) {
    return StudentProfile(
      gpa: gpa ?? this.gpa,
      currentYear: currentYear ?? this.currentYear,
      currentSemester: currentSemester ?? this.currentSemester,
      specialty: specialty ?? this.specialty,
      completedCourses: completedCourses ?? this.completedCourses,
      incompleteCourses: incompleteCourses ?? this.incompleteCourses,
      currentlyEnrolledCourses: currentlyEnrolledCourses ?? this.currentlyEnrolledCourses,
      completedCreditHours: completedCreditHours ?? this.completedCreditHours,
      maxCreditHours: maxCreditHours ?? this.maxCreditHours,
    );
  }
}