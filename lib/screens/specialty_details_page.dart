import 'package:flutter/material.dart';

class SpecialtyDetailsPage extends StatefulWidget {
  final String name;

  const SpecialtyDetailsPage({Key? key, required this.name}) : super(key: key);

  @override
  _SpecialtyDetailsPageState createState() => _SpecialtyDetailsPageState();
}

class _SpecialtyDetailsPageState extends State<SpecialtyDetailsPage> {
  late String description;
  late Map<String, dynamic> studyPlan;

  final Map<String, dynamic> localSpecialtiesData = {
    "InternetOfThings": {
      "description":
          "Focuses on connecting everyday devices to the internet for smarter automation.",
      "study_plan": {
        "Year 1": {
          "Semester 1": ["Introduction to IoT", "Programming Basics", "Networking Fundamentals"],
          "Semester 2": ["Embedded Systems", "Sensors and Actuators", "IoT Protocols"]
        },
        "Year 2": {
          "Semester 1": ["Cloud Computing", "Wireless Communication", "IoT Security"],
          "Semester 2": ["IoT Project Design", "Big Data Analytics", "Capstone Project"]
        }
      }
    },
    "Cybersecurity": {
      "description": "Protects systems and networks from digital attacks.",
      "study_plan": {
        "Year 1": {
          "Semester 1": ["Intro to Cybersecurity", "Network Basics", "Operating Systems"],
          "Semester 2": ["Ethical Hacking", "Cryptography", "Digital Forensics"]
        },
        "Year 2": {
          "Semester 1": ["Penetration Testing", "Malware Analysis", "Security Policies"],
          "Semester 2": [
            "Advanced Network Security",
            "Capstone Project",
            "Internship"
          ]
        }
      }
    },
  };

  @override
  void initState() {
    super.initState();
    _loadLocalSpecialtyDetails();
  }

  void _loadLocalSpecialtyDetails() {
    final key = widget.name.replaceAll(" ", "");
    final specialtyData = localSpecialtiesData[key] ?? {};

    setState(() {
      description = specialtyData['description'] ?? "No description found.";
      studyPlan = (specialtyData['study_plan'] ?? {}) as Map<String, dynamic>;
    });
  }

  Widget buildStudyPlan() {
    if (studyPlan.isEmpty) {
      return Text(
        "No study plan available.",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      );
    }

    List<Widget> yearWidgets = [];

    studyPlan.forEach((year, semesters) {
      List<Widget> semesterWidgets = [];

      (semesters as Map).forEach((semester, subjects) {
        semesterWidgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(bottom: 8),
              color: Color.fromRGBO(1, 87, 155, 0.1), // Light blue tint
              child: ExpansionTile(
                title: Text(
                  semester,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                leading: Icon(Icons.school, color: Colors.blue.shade900),
                children: (subjects as List)
                    .map(
                      (subject) => ListTile(
                        leading: Icon(Icons.book, size: 18, color: Colors.indigo),
                        title: Text(subject.toString()),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        );
      });

      yearWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Color.fromRGBO(1, 87, 155, 0.1), // Blue-tinted card
            child: ExpansionTile(
              iconColor: Colors.blue.shade900,
              title: Text(
                year,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
              children: semesterWidgets,
            ),
          ),
        ),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: yearWidgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Color.fromRGBO(187, 222, 251, 1), // Light blue background
        centerTitle: true,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            // Description with no background
            Text(
              "Description:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(1, 87, 155, 1),
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "Study Plan:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(1, 87, 155, 1),
              ),
            ),
            SizedBox(height: 10),
            buildStudyPlan(),
          ],
        ),
      ),
    );
  }
}