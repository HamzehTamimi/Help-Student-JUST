import 'package:flutter/material.dart';
import '../models/student_profile.dart';

class StudentInfoForm extends StatefulWidget {
  final Function(StudentProfile) onProfileChanged;
  final StudentProfile? initialProfile;

  const StudentInfoForm({
    Key? key,
    required this.onProfileChanged,
    this.initialProfile,
  }) : super(key: key);

  @override
  State<StudentInfoForm> createState() => _StudentInfoFormState();
}

class _StudentInfoFormState extends State<StudentInfoForm> {
  final _gpaController = TextEditingController();
  String _selectedSpecialty = 'Computer Information Systems';
  String _selectedYear = 'First Year';
  String _selectedSemester = 'First Semester';

  final List<String> _specialties = [
    'Computer Information Systems',
    'Computer Science',
    'Software Engineering',
    'Data Science',
    'Cybersecurity',
  ];

  final List<String> _years = [
    'First Year',
    'Second Year', 
    'Third Year',
    'Fourth Year',
  ];

  final List<String> _semesters = [
    'First Semester',
    'Second Semester',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialProfile != null) {
      _gpaController.text = widget.initialProfile!.gpa.toString();
      _selectedSpecialty = widget.initialProfile!.specialty;
      _selectedYear = _getYearString(widget.initialProfile!.currentYear);
      _selectedSemester = _getSemesterString(widget.initialProfile!.currentSemester);
    }
  }

  @override
  void dispose() {
    _gpaController.dispose();
    super.dispose();
  }

  String _getYearString(int year) {
    switch (year) {
      case 1: return 'First Year';
      case 2: return 'Second Year';
      case 3: return 'Third Year';
      case 4: return 'Fourth Year';
      default: return 'First Year';
    }
  }

  String _getSemesterString(int semester) {
    return semester == 1 ? 'First Semester' : 'Second Semester';
  }

  int _getYearValue(String year) {
    switch (year) {
      case 'First Year': return 1;
      case 'Second Year': return 2;
      case 'Third Year': return 3;
      case 'Fourth Year': return 4;
      default: return 1;
    }
  }

  int _getSemesterValue(String semester) {
    return semester == 'First Semester' ? 1 : 2;
  }

  void _updateProfile() {
    final gpaText = _gpaController.text.trim();
    if (gpaText.isEmpty) return;

    try {
      final gpa = double.parse(gpaText);
      if (gpa < 0 || gpa > 4.0) {
        _showError('GPA must be between 0.0 and 4.0');
        return;
      }

      final profile = StudentProfile(
        gpa: gpa,
        currentYear: _getYearValue(_selectedYear),
        currentSemester: _getSemesterValue(_selectedSemester),
        specialty: _selectedSpecialty,
      );

      widget.onProfileChanged(profile);
    } catch (e) {
      _showError('Please enter a valid GPA');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdown(
              label: 'Select your specialty',
              value: _selectedSpecialty,
              items: _specialties,
              onChanged: (value) {
                setState(() {
                  _selectedSpecialty = value!;
                });
                _updateProfile();
              },
            ),
            const SizedBox(height: 16),
            
            _buildTextField(
              label: 'Enter your last semester GPA',
              controller: _gpaController,
              hintText: 'e.g. 3.5',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) => _updateProfile(),
            ),
            const SizedBox(height: 16),
            
            _buildDropdown(
              label: 'Select your academic year',
              value: _selectedYear,
              items: _years,
              onChanged: (value) {
                setState(() {
                  _selectedYear = value!;
                });
                _updateProfile();
              },
            ),
            const SizedBox(height: 16),
            
            _buildDropdown(
              label: 'Select your semester',
              value: _selectedSemester,
              items: _semesters,
              onChanged: (value) {
                setState(() {
                  _selectedSemester = value!;
                });
                _updateProfile();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            value: value,
            items: items.map((item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            )).toList(),
            onChanged: onChanged,
            underline: Container(),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: hintText,
          ),
          keyboardType: keyboardType,
          onChanged: onChanged,
        ),
      ],
    );
  }
}