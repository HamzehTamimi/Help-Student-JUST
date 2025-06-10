import 'package:flutter/material.dart';
import 'package:helpstudent/cards/cards.dart';
import 'package:helpstudent/screens/settings.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String _userName = 'Student'; // Default name if not found
  User? _currentUser; // Holds the current authenticated user

  @override
  void initState() {
    super.initState();
    _loadUserInfo(); // Call function to load user info when the widget initializes
  }

  // Asynchronously loads the current user's display name
  Future<void> _loadUserInfo() async {
    _currentUser =
        FirebaseAuth.instance.currentUser; // Get the current authenticated user
    if (_currentUser != null) {
      setState(() {
        // Update the userName state with the user's display name, or default to 'Student'
        _userName = _currentUser!.displayName ?? 'Student';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
          );
        },
        foregroundColor: Color.fromRGBO(187, 222, 251, 1),
        backgroundColor: Color.fromRGBO(1, 87, 155, 1),
        tooltip: "Settings",
        child: Icon(Icons.settings),
      ),
      appBar: AppBar(
        title: const Text('Help Student'),
        backgroundColor: Color.fromRGBO(187, 222, 251, 1),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: GridView.count(
        crossAxisCount: 1,
        childAspectRatio: (1 / .7),
        children: <Widget>[
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
    return const CustomCard(Icons.location_on, "Maps", MyMapPage());
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
    return const CustomCard(Icons.person, "CV", CVFormScreen());
  }
}

class GuidanceCard extends StatelessWidget {
  const GuidanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomCard(Icons.school, "Guidance", GuidanceScreen());
  }
}
