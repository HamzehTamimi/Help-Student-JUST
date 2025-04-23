import 'package:flutter/material.dart';
import 'package:helpstudent/screens/home.dart';

void main() {
  runApp(const GPACalculatorApp());
}

class GPACalculatorApp extends StatelessWidget {
  const GPACalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GPA Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GPACalculatorScreen(),
    );
  }
}

class GPACalculatorScreen extends StatefulWidget {
  const GPACalculatorScreen({super.key});

  @override
  _GPACalculatorScreenState createState() => _GPACalculatorScreenState();
}

class _GPACalculatorScreenState extends State<GPACalculatorScreen> {
  final List<TextEditingController> _creditControllers =
      List.generate(5, (_) => TextEditingController());
  final List<String?> _selectedGrades = [null, null, null, null, null];
  String _output = '';

  final Map<String, double> _gradePoints = {
    'A+': 4.2,
    'A': 4.0,
    'A-': 3.75,
    'B+': 3.5,
    'B': 3.25,
    'B-': 3,
    'C+': 2.75,
    'C': 2.5,
    'C-': 2.25,
    'D+': 2,
    'D': 1.75,
    'D-': 1.5,
    'F': 0.5,
  };

  void _calculateGPA() {
    double totalPoints = 0.0;
    double totalCredits = 0.0;

    for (int i = 0; i < 5; i++) {
      final grade = _selectedGrades[i];
      final credits = double.tryParse(_creditControllers[i].text) ?? 0.0;

      if (grade != null && credits > 0) {
        totalPoints += (_gradePoints[grade]! * credits);
        totalCredits += credits;
      }
    }

    setState(() {
      _output = totalCredits > 0
          ? 'GPA: ${(totalPoints / totalCredits).toStringAsFixed(2)}'
          : 'Invalid Input';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GPA Calculator'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(187, 222, 251, 1),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Homescreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeaderRow(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Grade Dropdown
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: DropdownButtonFormField<String>(
                            value: _selectedGrades[index],
                            items: _gradePoints.keys
                                .map((grade) => DropdownMenuItem(
                                      value: grade,
                                      child: Text(grade),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedGrades[index] = value;
                              });
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Grade',
                            ),
                          ),
                        ),
                      ),
                      // Credits Field
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextField(
                            controller: _creditControllers[index],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Credits',
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateGPA,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: const Color.fromRGBO(1, 87, 155, 1),
                foregroundColor: Colors.white,
              ),
              child: const Text('Calculate', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            OutputField(output: _output),
          ],
        ),
      ),
    );
  }
}

class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Expanded(
          child: Text(
            'Grade',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            'Credits / Hours',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class OutputField extends StatelessWidget {
  final String output;

  const OutputField({required this.output, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        output,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
