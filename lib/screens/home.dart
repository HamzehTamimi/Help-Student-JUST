import 'package:flutter/material.dart';
import 'package:helpstudent/cards/cards.dart';
import 'package:helpstudent/screens/about.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

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
            // Welcome section
            const Padding(padding: EdgeInsets.symmetric(vertical: 16.0)),
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
