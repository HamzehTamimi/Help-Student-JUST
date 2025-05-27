import 'package:flutter/material.dart';
import 'package:helpstudent/screens/guidance.dart';
import 'package:helpstudent/screens/cv.dart';
import 'package:helpstudent/screens/comingsoon.dart';
import 'package:helpstudent/screens/gpa.dart';
import 'package:helpstudent/screens/map.dart';
// ignore: unused_import
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Helper'),
        backgroundColor: const Color.fromRGBO(1, 87, 155, 1),
      ),
      body: ListView(
        children: const [
          GuidanceCard(),
          ITSpecialtyCard(),
          GPACard(),

          MapCard(),
          CVCard(),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget targetPage;

  const CustomCard(this.icon, this.title, this.targetPage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(100, 181, 246, 1),
          width: 2,
        ),
        color: const Color.fromRGBO(187, 222, 251, 1),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: const Color.fromRGBO(1, 87, 155, 1)),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(1, 87, 155, 1),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromRGBO(1, 87, 155, 1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
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
    return CustomCard(Icons.location_on, "Maps", MyMapPage());
  }
}

class GPACard extends StatelessWidget {
  const GPACard({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomCard(
      Icons.calculate,
      "Calculate GPA",
      GPACalculatorApp(),
    );
  }
}

class ITSpecialtyCard extends StatelessWidget {
  const ITSpecialtyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomCard(Icons.computer, "IT Specialties", ComingSoon());
  }
}

class CVCard extends StatelessWidget {
  const CVCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomCard(Icons.person, "CV", CV());
  }
}

class GuidanceCard extends StatelessWidget {
  const GuidanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomCard(Icons.school, "Guidance", GuidanceScreen());
  }
}
