import 'package:flutter/material.dart';

class Subject {
  TextEditingController creditController;
  String? selectedGrade;

  Subject() : creditController = TextEditingController();

  void dispose() {
    creditController.dispose();
  }
}

class GPACalculatorScreen extends StatefulWidget {
  const GPACalculatorScreen({super.key});

  @override
  _GPACalculatorScreenState createState() => _GPACalculatorScreenState();
}

class _GPACalculatorScreenState extends State<GPACalculatorScreen> {
  final List<Subject> _subjects = [Subject()]; // Start with one subject
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

  @override
  void dispose() {
    for (var subject in _subjects) {
      subject.dispose();
    }
    _cumulativeGpaController.dispose();
    _totalCreditsController.dispose();
    super.dispose();
  }

  void _addSubject() {
    setState(() {
      _subjects.add(Subject());
    });
  }

  void _removeSubject(int index) {
    if (_subjects.length > 1) {
      setState(() {
        _subjects[index].dispose();
        _subjects.removeAt(index);
      });
    }
  }

  void _calculateGpa() {
    double totalPointsThisSemester = 0.0;
    double totalCreditsThisSemester = 0.0;

    for (var subject in _subjects) {
      final grade = subject.selectedGrade;
      final creditsText = subject.creditController.text;
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
      if (totalCreditsCombined <= 0) {
        _output = 'Invalid Input';
      } else {
        final gpaThisSemester =
            totalCreditsThisSemester > 0
                ? totalPointsThisSemester / totalCreditsThisSemester
                : 0.0;

        final cumulativeGPA = totalPointsCombined / totalCreditsCombined;

        _output =
            'This Semester GPA: ${gpaThisSemester.toStringAsFixed(2)}\n'
            'New Cumulative GPA: ${cumulativeGPA.toStringAsFixed(2)}';
      }
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Subjects',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: _addSubject,
                      icon: const Icon(Icons.add_circle, color: Colors.green),
                      tooltip: 'Add Subject',
                    ),
                    Text('${_subjects.length} subjects'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const HeaderRow(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _subjects.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              value: _subjects[index].selectedGrade,
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
                                  _subjects[index].selectedGrade = value;
                                });
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Grade',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: _subjects[index].creditController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Credits',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed:
                                _subjects.length > 1
                                    ? () => _removeSubject(index)
                                    : null,
                            icon: Icon(
                              Icons.remove_circle,
                              color:
                                  _subjects.length > 1
                                      ? Colors.red
                                      : Colors.grey,
                            ),
                            tooltip: 'Remove Subject',
                          ),
                        ],
                      ),
                    ),
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
      children: const [
        Expanded(
          flex: 2,
          child: Text(
            'Grade',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(
            'Credits / Hours',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 48), // Space for remove button
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
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        output.isEmpty
            ? 'Enter grades and credits, then tap Calculate'
            : output,
        style: TextStyle(
          fontSize: 16,
          color: output.isEmpty ? Colors.grey[600] : Colors.black,
        ),
      ),
    );
  }
}
