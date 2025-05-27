import 'package:firebase_database/firebase_database.dart';
import '../models/course.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Future<Map<String, List<Course>>> fetchAllDepartmentCourses() async {
    try {
      final snapshot = await _database.child('departments').get();
      
      if (!snapshot.exists) {
        throw Exception('No departments data found');
      }

      final data = Map<String, dynamic>.from(snapshot.value as Map);
      final Map<String, List<Course>> departmentCourses = {};

      for (final entry in data.entries) {
        final departmentKey = entry.key;
        final departmentData = Map<String, dynamic>.from(entry.value as Map);
        
        if (departmentData.containsKey('study_plan') && 
            departmentData['study_plan'].containsKey('courses')) {
          final coursesData = Map<String, dynamic>.from(
            departmentData['study_plan']['courses'] as Map
          );
          
          final courses = coursesData.entries.map<Course>((courseEntry) {
            final courseData = Map<String, dynamic>.from(courseEntry.value as Map);
            return Course.fromMap(courseEntry.key, courseData, departmentKey);
          }).toList();
          
          departmentCourses[departmentKey] = courses;
        }
      }

      return departmentCourses;
    } catch (e) {
      throw Exception('Failed to fetch courses: $e');
    }
  }

  Future<List<Course>> fetchCoursesForDepartment(String department) async {
    try {
      final snapshot = await _database
          .child('departments')
          .child(department)
          .child('study_plan')
          .child('courses')
          .get();
      
      if (!snapshot.exists) {
        return [];
      }

      final coursesData = Map<String, dynamic>.from(snapshot.value as Map);
      return coursesData.entries.map<Course>((entry) {
        final courseData = Map<String, dynamic>.from(entry.value as Map);
        return Course.fromMap(entry.key, courseData, department);
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch department courses: $e');
    }
  }
}