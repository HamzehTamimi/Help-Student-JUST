import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:open_file/open_file.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student CV Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color.fromRGBO(1, 87, 155, 1)),
        brightness: Brightness.light,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(1, 87, 155, 1),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color.fromRGBO(1, 87, 155, 1),
            side: BorderSide(color: const Color.fromRGBO(1, 87, 155, 1)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const CVFormScreen(),
    );
  }

  // Helper method to convert Color to MaterialColor
  static MaterialColor createMaterialColor(Color color) {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red;
    final int g = color.green;
    final int b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double opacity = strength == .05 ? .1 : strength;
      swatch[(strength * 10).round()] = color.withOpacity(opacity);
    });
    return MaterialColor(color.value, swatch);
  }
}

class CVFormScreen extends StatefulWidget {
  const CVFormScreen({Key? key}) : super(key: key);

  @override
  CVFormScreenState createState() => CVFormScreenState();
}

class CVFormScreenState extends State<CVFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();

  List<StudentEducation> educationList = [StudentEducation()];
  List<Project> projects = [Project()];
  List<String> certifications = [''];
  List<String> skills = [''];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student CV Generator'),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Color.fromRGBO(187, 222, 251, 1), // New accent color
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Personal Details'),
                    _buildTextField(_nameController, 'Full Name', Icons.person),
                    _buildTextField(_emailController, 'Email', Icons.email),
                    _buildTextField(_phoneController, 'Phone', Icons.phone),
                    _buildTextField(_addressController, 'Address', Icons.home),
                    _buildTextField(_summaryController, 'Objective / Summary',
                        Icons.description,
                        maxLines: 3),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Education'),
                    ...educationList.asMap().entries.map((entry) {
                      final index = entry.key;
                      return _buildEducationFields(index);
                    }).toList(),
                    _buildActionButton(
                      icon: Icons.add,
                      onPressed: () {
                        setState(() {
                          educationList.add(StudentEducation());
                        });
                      },
                      label: 'Add Education',
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Projects'),
                    ...projects.asMap().entries.map((entry) {
                      final index = entry.key;
                      return _buildProjectFields(index);
                    }).toList(),
                    _buildActionButton(
                      icon: Icons.add,
                      onPressed: () {
                        setState(() {
                          projects.add(Project());
                        });
                      },
                      label: 'Add Project',
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Certifications / Achievements'),
                    ...certifications.asMap().entries.map((e) {
                      int index = e.key;
                      return _buildCertificationField(index);
                    }).toList(),
                    _buildActionButton(
                      icon: Icons.add,
                      onPressed: () {
                        setState(() {
                          certifications.add('');
                        });
                      },
                      label: 'Add Certification',
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Skills'),
                    ...skills.asMap().entries.map((e) {
                      int index = e.key;
                      return _buildSkillField(index);
                    }).toList(),
                    _buildActionButton(
                      icon: Icons.add,
                      onPressed: () {
                        setState(() {
                          skills.add('');
                        });
                      },
                      label: 'Add Skill',
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _generateAndSaveCV();
                          }
                        },
                        icon: Icon(Icons.description),
                        label: const Text('Generate CV'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(1, 87, 155, 1),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.edit_attributes,
            color: const Color.fromRGBO(1, 87, 155, 1),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
    bool required = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        maxLines: maxLines,
        validator: required
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter $label';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _buildEducationFields(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Education ${index + 1}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                if (index > 0)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        educationList.removeAt(index);
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) => educationList[index].degree = value,
              decoration: const InputDecoration(labelText: 'Degree / Program', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) => educationList[index].institution = value,
              decoration: const InputDecoration(labelText: 'School / University', border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (value) => educationList[index].startYear = value,
                    decoration: const InputDecoration(labelText: 'Start Year', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    onChanged: (value) => educationList[index].endYear = value,
                    decoration: const InputDecoration(labelText: 'End Year', hintText: 'Present', border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (value) => educationList[index].gpa = value,
              decoration: const InputDecoration(labelText: 'GPA / Grade', border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectFields(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Project ${index + 1}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                if (index > 0)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        projects.removeAt(index);
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Project Title', border: OutlineInputBorder()),
              onChanged: (value) => projects[index].title = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
              maxLines: 3,
              onChanged: (value) => projects[index].description = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificationField(int index) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: certifications[index],
            decoration: InputDecoration(labelText: 'Certification ${index + 1}', border: const OutlineInputBorder()),
            onChanged: (value) {
              certifications[index] = value;
            },
          ),
        ),
        if (index > 0)
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              setState(() {
                certifications.removeAt(index);
              });
            },
          ),
      ],
    );
  }

  Widget _buildSkillField(int index) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: skills[index],
            decoration: InputDecoration(labelText: 'Skill ${index + 1}', border: const OutlineInputBorder()),
            onChanged: (value) {
              skills[index] = value;
            },
          ),
        ),
        if (index > 0)
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              setState(() {
                skills.removeAt(index);
              });
            },
          ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color.fromRGBO(1, 87, 155, 1),
          side: BorderSide(color: const Color.fromRGBO(1, 87, 155, 1)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }

  Future<void> _generateAndSaveCV() async {
    setState(() {
      isLoading = true;
    });
    try {
      final pdf = pw.Document();
      
      // Define colors
      final primaryColor = PdfColor.fromHex('#01579B');
      final lightGray = PdfColor.fromHex('#F5F5F5');
      final darkGray = PdfColor.fromHex('#424242');
      
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(30),
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header Section with colored background
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(20),
                  decoration: pw.BoxDecoration(
                    color: primaryColor,
                    borderRadius: pw.BorderRadius.circular(8),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        _nameController.text.toUpperCase(),
                        style: pw.TextStyle(
                          fontSize: 28,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.white,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Row(
                        children: [
                          if (_emailController.text.isNotEmpty)
                            pw.Text(
                              _emailController.text,
                              style: pw.TextStyle(
                                fontSize: 12,
                                color: PdfColors.white,
                              ),
                            ),
                          if (_emailController.text.isNotEmpty && _phoneController.text.isNotEmpty)
                            pw.Container(
                              margin: const pw.EdgeInsets.symmetric(horizontal: 8),
                              child: pw.Text(' • ', style: pw.TextStyle(color: PdfColors.white)),
                            ),
                          if (_phoneController.text.isNotEmpty)
                            pw.Text(
                              _phoneController.text,
                              style: pw.TextStyle(
                                fontSize: 12,
                                color: PdfColors.white,
                              ),
                            ),
                        ],
                      ),
                      if (_addressController.text.isNotEmpty)
                        pw.Container(
                          margin: const pw.EdgeInsets.only(top: 4),
                          child: pw.Text(
                            _addressController.text,
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 25),
                
                // Summary Section
                if (_summaryController.text.isNotEmpty) ...[
                  _buildSectionHeader('PROFESSIONAL SUMMARY', primaryColor),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    decoration: pw.BoxDecoration(
                      color: lightGray,
                      borderRadius: pw.BorderRadius.circular(5),
                    ),
                    child: pw.Text(
                      _summaryController.text,
                      style: pw.TextStyle(
                        fontSize: 11,
                        lineSpacing: 1.4,
                        color: darkGray,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 20),
                ],
                
                // Education Section
                if (educationList.isNotEmpty && educationList[0].degree.isNotEmpty) ...[
                  _buildSectionHeader('EDUCATION', primaryColor),
                  ...educationList.where((edu) => edu.degree.isNotEmpty).map((edu) {
                    return pw.Container(
                      margin: const pw.EdgeInsets.only(bottom: 12),
                      padding: const pw.EdgeInsets.all(12),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColor.fromHex('#E0E0E0')),
                        borderRadius: pw.BorderRadius.circular(5),
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Expanded(
                                child: pw.Text(
                                  edu.degree,
                                  style: pw.TextStyle(
                                    fontSize: 13,
                                    fontWeight: pw.FontWeight.bold,
                                    color: darkGray,
                                  ),
                                ),
                              ),
                              pw.Container(
                                padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: pw.BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: pw.BorderRadius.circular(3),
                                ),
                                child: pw.Text(
                                  '${edu.startYear} - ${edu.endYear.isEmpty ? 'Present' : edu.endYear}',
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    color: PdfColors.white,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          pw.SizedBox(height: 4),
                          pw.Text(
                            edu.institution,
                            style: pw.TextStyle(
                              fontSize: 11,
                              color: darkGray,
                              fontStyle: pw.FontStyle.italic,
                            ),
                          ),
                          if (edu.gpa.isNotEmpty)
                            pw.Container(
                              margin: const pw.EdgeInsets.only(top: 4),
                              child: pw.Text(
                                'GPA/Grade: ${edu.gpa}',
                                style: pw.TextStyle(
                                  fontSize: 10,
                                  color: primaryColor,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                  pw.SizedBox(height: 15),
                ],
                
                // Projects Section
                if (projects.isNotEmpty && projects[0].title.isNotEmpty) ...[
                  _buildSectionHeader('PROJECTS', primaryColor),
                  ...projects.where((project) => project.title.isNotEmpty).map((project) {
                    return pw.Container(
                      margin: const pw.EdgeInsets.only(bottom: 12),
                      padding: const pw.EdgeInsets.all(12),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColor.fromHex('#E0E0E0')),
                        borderRadius: pw.BorderRadius.circular(5),
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            project.title,
                            style: pw.TextStyle(
                              fontSize: 13,
                              fontWeight: pw.FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          pw.SizedBox(height: 6),
                          pw.Text(
                            project.description,
                            style: pw.TextStyle(
                              fontSize: 11,
                              lineSpacing: 1.3,
                              color: darkGray,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  pw.SizedBox(height: 15),
                ],
                
                // Skills and Certifications in two columns
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Skills Column
                    if (skills.isNotEmpty && skills[0].isNotEmpty)
                      pw.Expanded(
                        flex: 1,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader('TECHNICAL SKILLS', primaryColor),
                            pw.Container(
                              padding: const pw.EdgeInsets.all(12),
                              decoration: pw.BoxDecoration(
                                color: lightGray,
                                borderRadius: pw.BorderRadius.circular(5),
                              ),
                              child: pw.Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: skills
                                    .where((s) => s.isNotEmpty)
                                    .map((s) => pw.Container(
                                          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: pw.BoxDecoration(
                                            color: primaryColor,
                                            borderRadius: pw.BorderRadius.circular(12),
                                          ),
                                          child: pw.Text(
                                            s,
                                            style: pw.TextStyle(
                                              fontSize: 9,
                                              color: PdfColors.white,
                                              fontWeight: pw.FontWeight.bold,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    if (skills.isNotEmpty && skills[0].isNotEmpty && certifications.isNotEmpty && certifications[0].isNotEmpty)
                      pw.SizedBox(width: 20),
                    
                    // Certifications Column
                    if (certifications.isNotEmpty && certifications[0].isNotEmpty)
                      pw.Expanded(
                        flex: 1,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader('CERTIFICATIONS', primaryColor),
                            pw.Container(
                              padding: const pw.EdgeInsets.all(12),
                              decoration: pw.BoxDecoration(
                                color: lightGray,
                                borderRadius: pw.BorderRadius.circular(5),
                              ),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: certifications
                                    .where((c) => c.isNotEmpty)
                                    .map((c) => pw.Container(
                                          margin: const pw.EdgeInsets.only(bottom: 6),
                                          child: pw.Row(
                                            children: [
                                              pw.Container(
                                                width: 4,
                                                height: 4,
                                                decoration: pw.BoxDecoration(
                                                  color: primaryColor,
                                                  shape: pw.BoxShape.circle,
                                                ),
                                              ),
                                              pw.SizedBox(width: 8),
                                              pw.Expanded(
                                                child: pw.Text(
                                                  c,
                                                  style: pw.TextStyle(
                                                    fontSize: 10,
                                                    color: darkGray,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      );

      final output = await getApplicationDocumentsDirectory();
      final file = File('${output.path}/enhanced_student_cv_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(await pdf.save());
      
      setState(() {
        isLoading = false;
      });
      
      if (!mounted) return;
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Enhanced CV saved successfully!'),
          action: SnackBarAction(
            label: 'Open',
            onPressed: () => OpenFile.open(file.path),
          ),
        ),
      );
      
      // Show dialog with file path
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Enhanced CV Generated'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Your professional CV has been successfully created with enhanced styling!'),
              const SizedBox(height: 10),
              Text('Saved to: ${file.path}', style: const TextStyle(fontSize: 12)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () => OpenFile.open(file.path),
              child: const Text('Open CV'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(1, 87, 155, 1),
              ),
            )
          ],
        ),
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  // Helper method to build section headers
  pw.Widget _buildSectionHeader(String title, PdfColor color) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 12),
      child: pw.Row(
        children: [
          pw.Container(
            width: 4,
            height: 20,
            decoration: pw.BoxDecoration(
              color: color,
              borderRadius: pw.BorderRadius.circular(2),
            ),
          ),
          pw.SizedBox(width: 12),
          pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              color: color,
            ),
          ),
          pw.Expanded(
            child: pw.Container(
              height: 1,
              margin: const pw.EdgeInsets.only(left: 12),
              decoration: pw.BoxDecoration(
                color: color.shade(0.3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Data Classes
class StudentEducation {
  String degree = '';
  String institution = '';
  String startYear = '';
  String endYear = '';
  String gpa = '';
}

class Project {
  String title = '';
  String description = '';
}