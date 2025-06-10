import 'package:flutter/material.dart';
import '../models/course.dart';
import '../models/student_profile.dart';
import '../services/recommendation_service.dart';
import '../services/prerequisite_checker.dart';

class RecommendationsDisplay extends StatelessWidget {
  final List<Course> recommendedCourses;
  final StudentProfile? profile;
  final List<Course> allCourses;
  final bool isLoading;

  const RecommendationsDisplay({
    super.key,
    required this.recommendedCourses,
    required this.profile,
    required this.allCourses,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (recommendedCourses.isEmpty) {
      return const Center(
        child: Text(
          'Generate a study plan to see recommendations',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      );
    }

    final summary =
        profile != null
            ? RecommendationService.generateRecommendationSummary(
              recommendedCourses,
              profile!,
              allCourses,
            )
            : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary Card
        if (summary != null) _buildSummaryCard(summary),

        const SizedBox(height: 8),

        // Course List Header
        _buildCourseListHeader(),

        // Course List (making the table height larger)
        Expanded(
          // Keep Expanded to allow it to take available space
          child: ConstrainedBox(
            // Use ConstrainedBox to ensure a minimum height
            constraints: const BoxConstraints(
              minHeight:
                  300, // Adjust this value to your desired minimum height
            ),
            child: ListView.builder(
              itemCount: recommendedCourses.length,
              itemBuilder: (context, index) {
                final course = recommendedCourses[index];
                return _buildCourseCard(course, context);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(Map<String, dynamic> summary) {
    final isHeavyLoad = summary['totalCourses'] >= 7;

    return Card(
      color: isHeavyLoad ? Colors.orange[50] : Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recommended Plan',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${summary['utilizationPercentage']}% Load',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _getLoadColor(summary['utilizationPercentage']),
                  ),
                ),
              ],
            ),
            if (isHeavyLoad) ...[
              const SizedBox(height: 4),
              const Text(
                '⚠️ Heavy course load - ensure you can manage the workload',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem('Courses', '${summary['totalCourses']}'),
                _buildSummaryItem('Credits', '${summary['totalCredits']}'),
                if (summary['incompleteCoursesCount'] > 0)
                  _buildSummaryItem(
                    'Retakes',
                    '${summary['incompleteCoursesCount']}',
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Color _getLoadColor(int percentage) {
    if (percentage >= 95) return Colors.red;
    if (percentage >= 85) return Colors.orange;
    if (percentage >= 70) return Colors.green;
    return Colors.blue;
  }

  Widget _buildCourseListHeader() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 2,
            child: Text('Code', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 4,
            child: Text(
              'Course Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'Credits',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Period',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(Course course, BuildContext context) {
    final isIncomplete =
        profile?.incompleteCourses.contains(course.code) ?? false;
    final isGradRequirement = [
      'CIS391',
      'CIS491',
      'CIS492',
      'CS391',
      'CS491',
      'CS492',
    ].contains(course.code);

    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      color: _getCourseCardColor(course, isIncomplete, isGradRequirement),
      child: InkWell(
        onTap: () => _showCourseDetails(context, course),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      course.code,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      course.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      '${course.credits}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Y${course.year} ${course.getSemesterDisplay()}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              if (course.hasPrerequisites()) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.link, size: 12, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Prerequisites: ${course.prerequisites.join(", ")}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              if (isIncomplete || isGradRequirement || course.isElective) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (isIncomplete) _buildTag('RETAKE', Colors.orange),
                    if (isGradRequirement)
                      _buildTag('GRADUATION', Colors.purple),
                    if (course.isElective) _buildTag('ELECTIVE', Colors.blue),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color? _getCourseCardColor(
    Course course,
    bool isIncomplete,
    bool isGradRequirement,
  ) {
    if (isIncomplete) return Colors.orange[50];
    if (isGradRequirement) return Colors.purple[50];
    if (course.isElective) return Colors.blue[50];
    return null;
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  void _showCourseDetails(BuildContext context, Course course) {
    final missingPrereqs =
        profile != null
            ? PrerequisiteChecker.getMissingPrerequisites(
              course,
              profile!,
              allCourses,
            )
            : <String>[];

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(course.code),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Credits: ${course.credits}'),
                Text('Year: ${course.year}'),
                Text('Semester: ${course.getSemesterDisplay()}'),
                Text('Department: ${course.department.toUpperCase()}'),
                if (course.hasPrerequisites()) ...[
                  const SizedBox(height: 8),
                  const Text(
                    'Prerequisites:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...course.prerequisites.map((prereq) => Text('• $prereq')),
                ],
                if (missingPrereqs.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  const Text(
                    'Missing Prerequisites:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  ...missingPrereqs.map(
                    (prereq) => Text(
                      '• $prereq',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
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
