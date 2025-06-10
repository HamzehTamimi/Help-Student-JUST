class Course {
  final String code;
  final String name;
  final int year;
  final dynamic semester; // Can be int or String (for "Summer")
  final int credits;
  final List<String> prerequisites;
  final String department;
  final bool isElective;

  Course({
    required this.code,
    required this.name,
    required this.year,
    required this.semester,
    required this.credits,
    this.prerequisites = const [],
    required this.department,
    this.isElective = false,
  });

  factory Course.fromMap(
    String code,
    Map<String, dynamic> data,
    String department,
  ) {
    return Course(
      code: code,
      name: data['name'] ?? '',
      year: data['year'] ?? 1,
      semester: data['semester'] ?? 1, // Can be int or "Summer"
      credits: data['credits'] ?? 3,
      prerequisites: List<String>.from(data['prerequisites'] ?? []),
      department: department,
      isElective: _isElectiveCourse(code, data),
    );
  }

  static bool _isElectiveCourse(String code, Map<String, dynamic> data) {
    // Define elective patterns based on your curriculum
    final electivePatterns = ['CIS471', 'BT401', 'CY261'];
    return electivePatterns.contains(code);
  }

  bool hasPrerequisites() => prerequisites.isNotEmpty;

  bool isAvailableForYear(int currentYear) => year <= currentYear;

  bool isAvailableForSemester(int currentYear, int currentSemester) {
    if (semester == "Summer") {
      return true; // Summer courses can be taken anytime
    }
    if (year < currentYear) return true;
    if (year == currentYear && (semester as int) <= currentSemester) {
      return true;
    }
    return false;
  }

  bool isSummerCourse() => semester == "Summer";

  int getSemesterNumber() {
    if (semester == "Summer") return 3;
    return semester as int;
  }

  String getSemesterDisplay() {
    if (semester == "Summer") return "Summer";
    return "Semester $semester";
  }
}
