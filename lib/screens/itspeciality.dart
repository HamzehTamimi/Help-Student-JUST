import 'package:flutter/material.dart';

import '../data/specialties_data.dart'; // Adjust this import path!

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IT Specialties App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ITSpecialtiesScreen(),
    );
  }
}

class ITSpecialtiesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> specialties = specialtiesData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(187, 222, 251, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'IT Specialties',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: specialties.length,
        itemBuilder: (context, index) {
          final specialty = specialties[index];
          return Container(
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              leading: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(1, 87, 155, 1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    '${specialty['id']}',
                    style: TextStyle(
                      color: Color.fromRGBO(1, 87, 155, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              title: Text(
                specialty['title'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              trailing: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              SpecialtyDetailScreen(specialty: specialty),
                    ),
                  );
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[600],
                  size: 16,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            SpecialtyDetailScreen(specialty: specialty),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class SpecialtyDetailScreen extends StatelessWidget {
  final Map<String, dynamic> specialty;

  const SpecialtyDetailScreen({Key? key, required this.specialty})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> academicYears = specialty['academicYears'] ?? [];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(187, 222, 251, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          specialty['title'],
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                specialty['description'],
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 24),

            // Iterate through academic years
            if (academicYears.isNotEmpty)
              ...academicYears.expand((year) {
                return [
                  // Academic Year Title
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(1, 87, 155, 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      year['yearTitle'] ?? 'Academic Year',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Iterate through semesters within the academic year
                  ...(year['semesters'] as List<Map<String, dynamic>>).expand((
                    semester,
                  ) {
                    return [
                      // Semester Title
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(1, 87, 155, 1).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          semester['semesterTitle'] ?? 'Semester',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 12),

                      // Semester Courses
                      ...(semester['courses'] as List<String>).map<Widget>((
                        course,
                      ) {
                        return Container(
                          width:
                              double.infinity, // This line ensures full width
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(
                              1,
                              87,
                              155,
                              1,
                            ).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            course,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                      SizedBox(height: 20), // Spacing between semesters
                    ];
                  }).toList(),
                ];
              }).toList()
            else // Fallback for any specialty that might not have academicYears yet (though all provided now do)
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'No detailed academic year data available for this specialty.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
