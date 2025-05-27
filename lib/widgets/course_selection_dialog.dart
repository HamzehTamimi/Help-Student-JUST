import 'package:flutter/material.dart';
import '../models/course.dart';

class CourseSelectionDialog extends StatefulWidget {
  final List<Course> availableCourses;
  final List<String> selectedCourses;
  final String title;

  const CourseSelectionDialog({
    Key? key,
    required this.availableCourses,
    required this.selectedCourses,
    required this.title,
  }) : super(key: key);

  @override
  State<CourseSelectionDialog> createState() => _CourseSelectionDialogState();
}

class _CourseSelectionDialogState extends State<CourseSelectionDialog> {
  late List<String> _tempSelected;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tempSelected = List.from(widget.selectedCourses);
  }

  List<Course> get _filteredCourses {
    if (_searchQuery.isEmpty) return widget.availableCourses;
    
    return widget.availableCourses.where((course) {
      return course.code.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             course.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: double.maxFinite,
        height: 400,
        child: Column(
          children: [
            // Search field
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search courses...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 16),
            
            // Course list
            Expanded(
              child: ListView.builder(
                itemCount: _filteredCourses.length,
                itemBuilder: (context, index) {
                  final course = _filteredCourses[index];
                  return Card(
                    child: CheckboxListTile(
                      title: Text('${course.code}: ${course.name}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Year ${course.year}, Semester ${course.semester}'),
                          Text('${course.credits} Credit Hours'),
                          if (course.prerequisites.isNotEmpty)
                            Text(
                              'Prerequisites: ${course.prerequisites.join(", ")}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                        ],
                      ),
                      value: _tempSelected.contains(course.code),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _tempSelected.add(course.code);
                          } else {
                            _tempSelected.remove(course.code);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _tempSelected),
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}