import 'package:flutter/material.dart';
import 'package:helpstudent/cards/cards.dart';
import 'package:helpstudent/screens/about.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

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
            MaterialPageRoute(builder: (context) => const AboutPage()),
          );
        },
        foregroundColor: const Color.fromRGBO(187, 222, 251, 1),
        backgroundColor: const Color.fromRGBO(1, 87, 155, 1),
        tooltip: "About",
        child: const Icon(Icons.info),
      ),
      appBar: AppBar(
        title: const Text(
          'Help Student',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: const Color.fromRGBO(187, 222, 251, 1),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section with logo and dynamic name
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Center(
                child: Column(
                  children: [
                    // Replaced Icon with Image.asset for uni_logo.png
                    Image.asset(
                      'images/uni_logo.png', // Path to your logo image
                      width: 120, // Adjust size as needed
                      height: 120, // Adjust size as needed
                      // You might want to add a color filter if the logo isn't white
                      // color: Color.fromRGBO(1, 87, 155, 1),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome, $_userName!', // Dynamic welcome message using the user's name
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(
                          1,
                          87,
                          155,
                          1,
                        ), // Primary blue color for the text
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'How can we help you today?', // A friendly follow-up message
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            // Cards section
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const <Widget>[
                GuidanceCard(),
                ITSpecialtyCard(),
                GPACard(),
                MapCard(),
                CVCard(),
              ],
            ),
            // Footer spacing
            const SizedBox(
              height: 80,
            ), // Extra space for floating action button
          ],
        ),
      ),
    );
  }
}
