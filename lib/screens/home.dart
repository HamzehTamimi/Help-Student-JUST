import 'package:flutter/material.dart';
import 'package:helpstudent/cards/cards.dart';
import 'package:helpstudent/screens/settings.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

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
