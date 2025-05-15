import 'package:flutter/material.dart';
import 'package:helpstudent/screens/guidance.dart';
import 'package:helpstudent/screens/map.dart';
import 'package:helpstudent/screens/cv.dart';
import 'package:helpstudent/screens/comingsoon.dart';
import 'package:helpstudent/screens/gpa.dart';

class Card extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget targetPage;

  const Card(this.icon, this.title, this.targetPage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(100, 181, 246, 1), width: 2),
        color: Color.fromRGBO(187, 222, 251, 1),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Icon(icon, size: 125, color: Color.fromRGBO(1, 87, 155, 1)),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(1, 87, 155, 1),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Color.fromRGBO(1, 87, 155, 1),
              foregroundColor: Colors.white,
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
    return Card(Icons.location_on, "Maps", Map());
  }
}

class GPACard extends StatelessWidget {
  const GPACard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(Icons.calculate, "Calculate GPA", GPACalculatorApp());
  }
}

class ITSpecialtyCard extends StatelessWidget {
  const ITSpecialtyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(Icons.computer, "IT Specialties", ComingSoon());
  }
}

class CVCard extends StatelessWidget {
  const CVCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(Icons.person, "CV", CVFormScreen());
  }
}

class GuidanceCard extends StatelessWidget {
  const GuidanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(Icons.school, "Guidence", GuidanceScreen());
  }
}
