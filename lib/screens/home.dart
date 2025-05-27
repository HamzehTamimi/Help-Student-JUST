import 'package:flutter/material.dart';
import 'package:helpstudent/cards/cards.dart';
import 'package:helpstudent/screens/settings.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            // Added const to MaterialPageRoute and SettingsPage() for performance optimization
            MaterialPageRoute(builder: (context) => const SettingsPage()),
          );
        },
        foregroundColor: const Color.fromRGBO(187, 222, 251, 1), // Added const
        backgroundColor: const Color.fromRGBO(1, 87, 155, 1), // Added const
        tooltip: "Settings",
        child: const Icon(Icons.settings), // Added const
      ),
      appBar: AppBar(
        title: const Text('Help Student'), // Reverted title to just text
        backgroundColor: const Color.fromRGBO(187, 222, 251, 1), // Added const
        centerTitle: true, // Center the title
        automaticallyImplyLeading: false,
        toolbarHeight: kToolbarHeight, // Revert to original AppBar height
      ),
      body: SingleChildScrollView( // Make the entire body scrollable
        child: Column( // Column to stack elements vertically
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0), // Padding for the logo and text
              child: Column(
                children: [
                  Image.asset(
                    'images/uni_logo.png', // Your university logo
                    height: 100, // Adjust size as needed
                  ),
                  const SizedBox(height: 10), // Space between logo and text
                  const Text(
                    'Empowering Your Student Journey!', // Updated welcome text
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(1, 87, 155, 1), // A thematic color
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5), // Small space below the welcome text
                  const Text(
                    'We\'re here to help you succeed in your academic and university life.', // Updated subtitle
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0), // Add padding around the entire GridView
              child: GridView.count(
                crossAxisCount: 1,
                childAspectRatio: (1 / 0.7),
                mainAxisSpacing: 8.0, // Add vertical spacing between cards
                crossAxisSpacing: 8.0, // Add horizontal spacing between cards
                shrinkWrap: true, // Make GridView take only necessary space
                physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                children: <Widget>[
                  GuidanceCard(),
                  ITSpecialtyCard(),
                  GPACard(),
                  MapCard(),
                  CVCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
