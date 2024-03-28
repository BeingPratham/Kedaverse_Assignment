import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Form',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const JobFormPage(),
    );
  }
}

class JobFormPage extends StatefulWidget {
  const JobFormPage({Key? key}) : super(key: key);

  @override
  _JobFormPageState createState() => _JobFormPageState();
}

class _JobFormPageState extends State<JobFormPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final List<String> _requiredSkills = [];
  final List<String> _preferredSkills = [];
  String _employmentType = '';
  bool _showInternshipFields = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Job Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildTextField('Job Title', 'jobTitle', [
                  FormBuilderValidators.required(),
                ]),
                const SizedBox(height: 10),
                _buildTextField('Company Overview', 'companyOverview', [
                  FormBuilderValidators.required(),
                ]),
                const SizedBox(height: 10),
                _buildTextField('Role Summary', 'roleSummary', [
                  FormBuilderValidators.required(),
                ]),
                const SizedBox(height: 10),
                _buildTextField('Key Responsibilities', 'keyResponsibilities', [
                  FormBuilderValidators.required(),
                ]),
                const SizedBox(height: 10),
                _buildChipsInput(
                    'Required Skills and Qualifications', _requiredSkills),
                const SizedBox(height: 10),
                _buildChipsInput(
                    'Preferred Skills and Qualifications', _preferredSkills),
                const SizedBox(height: 10),
                _buildTextField(
                    'Salary Range and Benefits', 'salaryAndBenefits', [
                  FormBuilderValidators.required(),
                ]),
                const SizedBox(height: 10),
                _buildDropdownField(
                    'Employment Type',
                    ['Full-time', 'Internship', 'Both'],
                    'employmentType',
                    [
                      FormBuilderValidators.required(),
                    ]),
                const SizedBox(height: 10),
                Visibility(
                  visible: _showInternshipFields,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField('Duration of Internship (Months)',
                          'durationOfInternship', [
                        FormBuilderValidators.required(),
                      ]),
                      const SizedBox(height: 10),
                      _buildTextField(
                          'Stipend of Internship', 'stipendOfInternship', [
                        FormBuilderValidators.required(),
                      ]),
                    ],
                  ),
                ),
                Visibility(
                  visible: !_showInternshipFields,
                  child:
                      _buildTextField('CTC for Full Time', 'ctcForFullTime', [
                    FormBuilderValidators.required(),
                  ]),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate()) {
                      print("Hello");
                      generateAndDisplayPdf(context);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> generateAndDisplayPdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          final employmentType =
              _formKey.currentState!.fields['employmentType']?.value ?? '';
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Job Title: ${_formKey.currentState!.fields['jobTitle']!.value ?? ''}',
                style: pw.TextStyle(fontSize: 18, color: PdfColors.black),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Company Overview: ${_formKey.currentState!.fields['companyOverview']!.value ?? ''}',
                style: pw.TextStyle(fontSize: 18, color: PdfColors.black),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Role Summary: ${_formKey.currentState!.fields['roleSummary']!.value ?? ''}',
                style: pw.TextStyle(fontSize: 18, color: PdfColors.black),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Key Responsibilities: ${_formKey.currentState!.fields['keyResponsibilities']!.value ?? ''}',
                style: pw.TextStyle(fontSize: 18, color: PdfColors.black),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Required Skills and Qualifications: ${_requiredSkills.join(', ')}',
                style: pw.TextStyle(fontSize: 18, color: PdfColors.black),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Preferred Skills and Qualifications: ${_preferredSkills.join(', ')}',
                style: pw.TextStyle(fontSize: 18, color: PdfColors.black),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Salary Range and Benefits: ${_formKey.currentState!.fields['salaryAndBenefits']!.value ?? ''}',
                style: pw.TextStyle(fontSize: 18, color: PdfColors.black),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Employment Type: ${_formKey.currentState!.fields['employmentType']!.value ?? ''}',
                style: pw.TextStyle(fontSize: 18, color: PdfColors.black),
              ),
              if (employmentType == 'Internship')
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(height: 10),
                    pw.Text(
                      'Duration of Internship (Months): ${_formKey.currentState!.fields['durationOfInternship']!.value ?? ''}',
                      style: pw.TextStyle(fontSize: 18, color: PdfColors.black),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      'Stipend of Internship: ${_formKey.currentState!.fields['stipendOfInternship']!.value ?? ''}',
                      style: pw.TextStyle(fontSize: 18, color: PdfColors.black),
                    ),
                  ],
                ),
              if (employmentType != 'Internship') pw.SizedBox(height: 10),
              pw.Text(
                'CTC for Full Time: ${_formKey.currentState!.fields['ctcForFullTime']!.value ?? ''}',
                style: pw.TextStyle(fontSize: 18, color: PdfColors.black),
              ),
            ],
          );
        },
      ),
    );

    final pdfBytes = pdf.save();

    await Printing.layoutPdf(
      onLayout: (format) => pdfBytes,
    );
  }

  Widget _buildTextField(
      String label, String name, List<FormFieldValidator<String>> validators) {
    return FormBuilderTextField(
      name: name,
      decoration: InputDecoration(labelText: label),
      validator: FormBuilderValidators.compose(validators),
    );
  }

  Widget _buildDropdownField(String label, List<String> options, String name,
      List<FormFieldValidator<String>> validators) {
    return FormBuilderDropdown(
      name: name,
      decoration: InputDecoration(labelText: label),
      onChanged: (value) {
        setState(() {
          _employmentType = value.toString();
          if (_employmentType == 'Internship') {
            _showInternshipFields = true;
          } else {
            _showInternshipFields = false;
          }
        });
      },
      items: options
          .map((option) => DropdownMenuItem(
                value: option,
                child: Text(option),
              ))
          .toList(),
      validator: FormBuilderValidators.compose(validators),
    );
  }

  Widget _buildChipsInput(String label, List<String> chipsList) {
    TextEditingController _textEditingController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: chipsList.map((chip) => _buildChip(chip)).toList(),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextFormField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  labelText: 'Add new',
                  border: OutlineInputBorder(),
                ),
                onFieldSubmitted: (value) {
                  setState(() {
                    if (value.isNotEmpty) {
                      chipsList.add(value);
                      _textEditingController.clear(); // Clear the input field
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      label: Text(label),
      onDeleted: () {
        setState(() {
          _requiredSkills.remove(label);
          _preferredSkills.remove(label);
        });
      },
    );
  }
}
