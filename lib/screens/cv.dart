import 'dart:io';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import "package:pdf/widgets.dart" as pw;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student CV Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: createMaterialColor(const Color.fromRGBO(1, 87, 155, 1)),
        brightness: Brightness.light,
      ),
      home: const CVFormScreen(),
    );
  }

  static MaterialColor createMaterialColor(Color color) {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    final r = color.red, g = color.green, b = color.blue;
    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

class CVFormScreen extends StatefulWidget {
  const CVFormScreen({super.key});
  @override
  State<CVFormScreen> createState() => _CVFormScreenState();
}

class _CVFormScreenState extends State<CVFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final summaryController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generate CV')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      _buildTextField(nameController, 'Full Name'),
                      _buildTextField(emailController, 'Email'),
                      _buildTextField(phoneController, 'Phone'),
                      _buildTextField(addressController, 'Address'),
                      _buildTextField(
                        summaryController,
                        'Summary',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _generatePDF();
                          }
                        },
                        child: const Text('Generate CV'),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Future<void> _generatePDF() async {
    setState(() => isLoading = true);
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build:
            (pw.Context context) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  nameController.text,
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 10),
                if (emailController.text.isNotEmpty)
                  pw.Text('Email: ${emailController.text}'),
                if (phoneController.text.isNotEmpty)
                  pw.Text('Phone: ${phoneController.text}'),
                if (addressController.text.isNotEmpty)
                  pw.Text('Address: ${addressController.text}'),
                pw.SizedBox(height: 10),
                if (summaryController.text.isNotEmpty) ...[
                  pw.Text(
                    'Summary:',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(summaryController.text),
                ],
              ],
            ),
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File(
      "${dir.path}/cv_${DateTime.now().millisecondsSinceEpoch}.pdf",
    );
    await file.writeAsBytes(await pdf.save());
    setState(() => isLoading = false);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('CV saved: ${file.path}')));
    await OpenFile.open(file.path);
  }
}

class OpenFile {
  static Future<void> open(String path) async {}
}
