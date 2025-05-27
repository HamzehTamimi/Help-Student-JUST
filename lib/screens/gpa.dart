import 'package:flutter/material.dart';

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
      theme: ThemeData(primarySwatch: Colors.blue),
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
  final List<TextEditingController> _creditControllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<String?> _selectedGrades = [null, null, null, null, null];
  String _output = '';

  // Controllers for cumulative GPA input
  final TextEditingController _cumulativeGpaController =
      TextEditingController();
  final TextEditingController _totalCreditsController = TextEditingController();

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

  void _calculateGpa() {
    double totalPointsThisSemester = 0.0;
    double totalCreditsThisSemester = 0.0;

    for (int i = 0; i < 5; i++) {
      final grade = _selectedGrades[i];
      final creditsText = _creditControllers[i].text;
      final credits = double.tryParse(creditsText) ?? 0.0;

      if (grade != null && credits > 0) {
        totalPointsThisSemester += (_gradePoints[grade]! * credits);
        totalCreditsThisSemester += credits;
      }
    }

    final cumulativeGpaText = _cumulativeGpaController.text;
    final totalCreditsSoFarText = _totalCreditsController.text;

    final cumulativeGpa = double.tryParse(cumulativeGpaText) ?? 0.0;
    final totalCreditsSoFar = double.tryParse(totalCreditsSoFarText) ?? 0.0;

    final totalPointsSoFar = cumulativeGpa * totalCreditsSoFar;
    final totalPointsCombined = totalPointsThisSemester + totalPointsSoFar;
    final totalCreditsCombined = totalCreditsThisSemester + totalCreditsSoFar;

    setState(() {
      _output =
          totalCredits > 0
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
        backgroundColor: Color.fromRGBO(187, 222, 251, 1),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextField(
                      controller: _cumulativeGpaController,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Current Cumulative GPA',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextField(
                      controller: _totalCreditsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Total Credit Hours So Far',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const HeaderRow(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: DropdownButtonFormField<String>(
                            value: _selectedGrades[index],
                            items:
                                _gradePoints.keys
                                    .map(
                                      (grade) => DropdownMenuItem(
                                        value: grade,
                                        child: Text(grade),
                                      ),
                                    )
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
                      const SizedBox(width: 8),
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
              onPressed: _calculateGpa,
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
      child: Text(output, style: const TextStyle(fontSize: 16)),
    );
  }
}
