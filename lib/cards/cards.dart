import 'package:flutter/material.dart';
import 'package:helpstudent/screens/guidance.dart';
import 'package:helpstudent/screens/itspeciality.dart';
import 'package:helpstudent/screens/map.dart';
import 'package:helpstudent/screens/cv.dart';
import 'package:helpstudent/screens/gpa.dart';

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Widget targetPage;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;

  const CustomCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.targetPage,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        color: backgroundColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Icon(icon, size: 125, color: iconColor),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: textColor.withOpacity(0.8)),
          ),
          const SizedBox(height: 15),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: iconColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text('Go To Page'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => targetPage),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MapCard extends StatelessWidget {
  const MapCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      icon: Icons.location_on,
      title: "Maps",
      description:
          "Navigate and find locations within your university campus including classrooms, labs, and facilities",
      targetPage: Map(),
      backgroundColor: const Color.fromRGBO(255, 235, 238, 1), // Light red/pink
      borderColor: const Color.fromRGBO(244, 67, 54, 1), // Red
      iconColor: const Color.fromRGBO(183, 28, 28, 1), // Dark red
      textColor: const Color.fromRGBO(183, 28, 28, 1),
    );
  }
}

class GPACard extends StatelessWidget {
  const GPACard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      icon: Icons.calculate,
      title: "Calculate GPA",
      description:
          "Calculate your Grade Point Average and track your academic performance easily",
      targetPage: GPACalculatorScreen(),
      backgroundColor: const Color.fromRGBO(232, 245, 233, 1), // Light green
      borderColor: const Color.fromRGBO(76, 175, 80, 1), // Green
      iconColor: const Color.fromRGBO(27, 94, 32, 1), // Dark green
      textColor: const Color.fromRGBO(27, 94, 32, 1),
    );
  }
}

class ITSpecialtyCard extends StatelessWidget {
  const ITSpecialtyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      icon: Icons.computer,
      title: "IT Specialties",
      description:
          "Explore different IT career paths and specializations to find your perfect tech field",
      targetPage: ITSpecialtiesScreen(),
      backgroundColor: const Color.fromRGBO(227, 242, 253, 1), // Light blue
      borderColor: const Color.fromRGBO(33, 150, 243, 1), // Blue
      iconColor: const Color.fromRGBO(13, 71, 161, 1), // Dark blue
      textColor: const Color.fromRGBO(13, 71, 161, 1),
    );
  }
}

class CVCard extends StatelessWidget {
  const CVCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      icon: Icons.person,
      title: "CV Builder",
      description:
          "Create and customize your professional resume to stand out to potential employers",
      targetPage: CVFormScreen(),
      backgroundColor: const Color.fromRGBO(248, 231, 28, 0.1), // Light yellow
      borderColor: const Color.fromRGBO(255, 193, 7, 1), // Amber
      iconColor: const Color.fromRGBO(255, 143, 0, 1), // Orange
      textColor: const Color.fromRGBO(230, 81, 0, 1), // Dark orange
    );
  }
}

class GuidanceCard extends StatelessWidget {
  const GuidanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      icon: Icons.school,
      title: "Guidance",
      description:
          "Create personalized study plans and get academic guidance to organize your learning schedule",
      targetPage: GuidanceScreen(),
      backgroundColor: const Color.fromRGBO(243, 229, 245, 1), // Light purple
      borderColor: const Color.fromRGBO(156, 39, 176, 1), // Purple
      iconColor: const Color.fromRGBO(74, 20, 140, 1), // Dark purple
      textColor: const Color.fromRGBO(74, 20, 140, 1),
    );
  }
}
