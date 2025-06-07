import 'package:flutter/material.dart';

class ITSpecialtiesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> specialties = [
    {
      'id': 1,
      'title': 'Internet Of Things',
      'description':
          'Internet of Things (IoT) focuses on connecting everyday devices to the internet, enabling them to collect and exchange data to create smart, automated systems.',
      'courses': [
        'IOT 101 - Introduction to IoT Systems',
        'CS 102 - Programming for IoT',
        'EE 201 - Electronics and Sensors',
        'NET 150 - Wireless Communication',
        'DATA 101 - Data Collection and Analysis',
      ],
    },
    {
      'id': 2,
      'title': 'Cybersecurity',
      'description':
          'Cybersecurity specializes in protecting digital systems, networks, and data from cyber threats through security protocols, risk assessment, and incident response.',
      'courses': [
        'SEC 101 - Introduction to Cybersecurity',
        'NET 201 - Network Security',
        'CRYPT 150 - Cryptography Fundamentals',
        'ETHIC 101 - Ethical Hacking',
        'RISK 200 - Risk Management',
      ],
    },
    {
      'id': 3,
      'title': 'Artificial Intelligence',
      'description':
          'Artificial Intelligence focuses on creating intelligent systems that can perform tasks typically requiring human intelligence, including machine learning and neural networks.',
      'courses': [
        'AI 101 - Introduction to Artificial Intelligence',
        'ML 201 - Machine Learning Fundamentals',
        'STAT 150 - Statistics for AI',
        'PYTHON 101 - Python Programming',
        'NN 250 - Neural Networks',
      ],
    },
    {
      'id': 4,
      'title': 'Computer Games Design And Development',
      'description':
          'Game Development combines creative design with technical programming skills to create interactive entertainment experiences across various platforms.',
      'courses': [
        'GAME 101 - Game Design Fundamentals',
        'PROG 201 - Game Programming',
        'ART 150 - 3D Graphics and Animation',
        'UNITY 101 - Unity Game Engine',
        'DESIGN 200 - User Experience Design',
      ],
    },
    {
      'id': 5,
      'title': 'Data Science',
      'description':
          'Data Science combines statistics, programming, and domain expertise to extract meaningful insights from large datasets and support data-driven decision making.',
      'courses': [
        'DATA 101 - Introduction to Data Science',
        'STAT 201 - Statistical Analysis',
        'PYTHON 150 - Python for Data Science',
        'DB 101 - Database Management',
        'VIZ 200 - Data Visualization',
      ],
    },
    {
      'id': 6,
      'title': 'Robotics Science',
      'description':
          'Robotics Science integrates mechanical engineering, electronics, and computer science to design and build autonomous robotic systems.',
      'courses': [
        'ROB 101 - Introduction to Robotics',
        'MECH 201 - Mechanical Systems',
        'CTRL 150 - Control Systems',
        'SENS 101 - Sensors and Actuators',
        'AI 200 - Robotics AI',
      ],
    },
    {
      'id': 7,
      'title': 'Computer Science',
      'description':
          'Computer Science provides a comprehensive foundation in programming, algorithms, and computational theory for solving complex technological problems.',
      'courses': [
        'CS 101 - Introduction to Programming',
        'ALG 201 - Algorithms and Data Structures',
        'MATH 150 - Discrete Mathematics',
        'OS 200 - Operating Systems',
        'SE 250 - Software Engineering',
      ],
    },
    {
      'id': 8,
      'title': 'Computer Information Systems',
      'description':
          'Computer Information Systems (CIS) is a field that focuses on using technology to design, implement, and manage information systems that solve business problems and enhance organizational efficiency.',
      'semester1_courses': [
        'HSS110 - Leader and Social Responsibility',
        'CS 101 - Introduction to programming',
        'CS 101 - Introduction to programming Lab',
        'SE 103 - Introduction to Information Technology',
        'MATH 140 - Elements Of Linear Algebra',
        'LG 101 - Communication Skills in English',
        'MATH 101 - Calculus I',
      ],
      'semester2_courses': [
        'CIS 131 - Fundamentals of Information Systems',
        'SE 112 - Introduction to Object-Oriented programming',
        'SE 112 - Introduction to Object-Oriented programming Lab',
        'HSS 119 - Entrepreneurship And Innovation',
        'MATH 102 - Calculus 2',
        'MATH 241 - Discrete Mathematics',
        'LG 103 - Life Skills',
      ],
    },
    {
      'id': 9,
      'title': 'Health Information Systems',
      'description':
          'Health Information Systems focuses on managing healthcare data and technology systems to improve patient care and healthcare delivery efficiency.',
      'courses': [
        'HIS 101 - Healthcare Information Systems',
        'MED 150 - Medical Terminology',
        'DATA 201 - Healthcare Data Management',
        'HIPAA 101 - Healthcare Privacy and Security',
        'SYS 200 - Hospital Management Systems',
      ],
    },
    {
      'id': 10,
      'title': 'Software Engineering',
      'description':
          'Software Engineering applies engineering principles to software development, focusing on systematic approaches to design, development, and maintenance of large-scale software systems.',
      'courses': [
        'SE 101 - Software Engineering Fundamentals',
        'PROG 201 - Advanced Programming',
        'DESIGN 150 - Software Design Patterns',
        'TEST 101 - Software Testing',
        'PROJ 200 - Project Management',
      ],
    },
    {
      'id': 11,
      'title': 'Computer Engineering',
      'description':
          'Computer Engineering combines electrical engineering and computer science to design and develop computer hardware and embedded systems.',
      'courses': [
        'CE 101 - Introduction to Computer Engineering',
        'EE 201 - Digital Logic Design',
        'ARCH 150 - Computer Architecture',
        'EMB 101 - Embedded Systems',
        'VLSI 200 - VLSI Design',
      ],
    },
    {
      'id': 12,
      'title': 'Network Engineering And Security',
      'description':
          'Network Engineering and Security focuses on designing, implementing, and securing computer networks and communication systems.',
      'courses': [
        'NET 101 - Network Fundamentals',
        'SEC 201 - Network Security',
        'PROT 150 - Network Protocols',
        'ADMIN 101 - Network Administration',
        'WIRE 200 - Wireless Networks',
      ],
    },
  ];

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
    // Check if this is Computer Information Systems with specific semester data
    bool isCIS = specialty['id'] == 8;

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

            // First Year - First Semester
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: Color.fromRGBO(1, 87, 155, 1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                'First Year - First Semester',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 16),

            // First semester courses
            if (isCIS && specialty['semester1_courses'] != null)
              ...specialty['semester1_courses']
                  .map<Widget>(
                    (course) => Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(1, 87, 155, 1).withOpacity(0.1),
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
                    ),
                  )
                  .toList()
            else
              ...specialty['courses']
                  .map<Widget>(
                    (course) => Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(1, 87, 155, 1).withOpacity(0.1),
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
                    ),
                  )
                  .toList(),

            SizedBox(height: 24),

            // First Year - Second Semester
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: Color.fromRGBO(1, 87, 155, 1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                'First Year - Second Semester',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 16),

            // Second semester courses
            if (isCIS && specialty['semester2_courses'] != null)
              ...specialty['semester2_courses']
                  .map<Widget>(
                    (course) => Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(1, 87, 155, 1).withOpacity(0.1),
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
                    ),
                  )
                  .toList()
            else
              // Generic second semester courses for other specialties
              ...List.generate(
                5,
                (index) => Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(1, 87, 155, 1).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Course ${index + 1} - Advanced ${specialty['title']} Topics',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ).toList(),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ComputerInformationSystemsScreen extends StatelessWidget {
  final List<String> firstSemesterCourses = [
    'HSS110 - Leader and Social Responsibility',
    'CS 101 - Introduction to programming',
    'CS 101 - Introduction to programming Lab',
    'SE 103 - Introduction to Information Technology',
    'MATH 140 - Elements Of Linear Algebra',
    'LG 101 - Communication Skills in English',
    'MATH 101 - Calculus I',
  ];

  final List<String> secondSemesterCourses = [
    'CIS 131 - Fundamentals of Information Systems',
    'SE 112 - Introduction to Object-Oriented programming',
    'SE 112 - Introduction to Object-Oriented programming Lab',
    'HSS 119 - Entrepreneurship And Innovation',
    'MATH 102 - Calculus 2',
    'MATH 241 - Discrete Mathematics',
    'LG 103 - Life Skills',
  ];

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
          'Computer Information Systems',
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
                'Computer Information Systems (CIS) is a field that focuses on using technology to design, implement, and manage information systems that solve business problems and enhance organizational efficiency.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 24),

            // First Year - First Semester
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: Color.fromRGBO(1, 87, 155, 1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                'First Year - First Semester',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 16),

            // First semester courses
            ...firstSemesterCourses
                .map(
                  (course) => Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(1, 87, 155, 1).withOpacity(0.1),
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
                  ),
                )
                .toList(),

            SizedBox(height: 24),

            // First Year - Second Semester
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: Color.fromRGBO(1, 87, 155, 1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                'First Year - Second Semester',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 16),

            // Second semester courses
            ...secondSemesterCourses
                .map(
                  (course) => Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(1, 87, 155, 1).withOpacity(0.1),
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
                  ),
                )
                .toList(),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
