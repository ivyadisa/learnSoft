import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:secondapp/constants/constants.dart';
import 'package:secondapp/views/customs/custombutton.dart';
import 'package:secondapp/views/customs/customtext.dart';
import 'package:secondapp/views/customs/customtextfield.dart';
import 'package:secondapp/views/customs/form.dart'; // Ensure this path is correct
import '../../models/enrollmentmodel.dart'; // Import Enroll class

TextEditingController search = TextEditingController();

class Enrollment extends StatefulWidget {
  const Enrollment({Key? key}) : super(key: key);

  @override
  State<Enrollment> createState() => _EnrollmentState();
}

class _EnrollmentState extends State<Enrollment> {
  final TextEditingController _studentFullNameController =
      TextEditingController();
  final TextEditingController _admissionNumberController =
      TextEditingController();
  final TextEditingController _gradeIdController = TextEditingController();
  final TextEditingController _streamIdController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _dateOfAdmissionController =
      TextEditingController();
  final TextEditingController _modeOfStudyController = TextEditingController();
  final TextEditingController _residenceController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _nemisNumberController = TextEditingController();
  final TextEditingController _assessmentNumberController =
      TextEditingController();
  final TextEditingController _studentMedicalConditionController =
      TextEditingController();
  final TextEditingController _medicalEmergencyContactController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.print_outlined),
                      onPressed: _showExportDialog,
                      color: primarycolor,
                    ),
                    const CustomText(
                      text: "Export",
                      textcolor: primarycolor,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: SizedBox(
                  width: currentWidth * 0.60,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: CustomTextField(
                      controller: search,
                      suffixicon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
              child: MyForm(
                studentFullNameController: _studentFullNameController,
                admissionNumberController: _admissionNumberController,
                gradeIdController: _gradeIdController,
                streamIdController: _streamIdController,
                genderController: _genderController,
                dateOfBirthController: _dateOfBirthController,
                dateOfAdmissionController: _dateOfAdmissionController,
                modeOfStudyController: _modeOfStudyController,
                residenceController: _residenceController,
                statusController: _statusController,
                nemisNumberController: _nemisNumberController,
                assessmentNumberController: _assessmentNumberController,
                studentMedicalConditionController:
                    _studentMedicalConditionController,
                medicalEmergencyContactController:
                    _medicalEmergencyContactController,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: AppButton(
            label: "Save",
            color: primarycolor,
            size: currentWidth * 0.9,
            action: _saveEnrollment,
          ),
        ),
      ],
    );
  }

  void _showExportDialog() {
    String selectedFileType = "file Type";

    final List<String> fileTypes = ['file Type', 'CSV', 'Excel'];

    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Export'),
          children: [
            SimpleDialogOption(
              child: const Text('Date Range'),
              onPressed: () {},
            ),
            SimpleDialogOption(
              child: StatefulBuilder(
                builder: (context, setState) {
                  return DropdownButton<String>(
                    value: selectedFileType,
                    items: fileTypes.map((String file) {
                      return DropdownMenuItem<String>(
                        value: file,
                        child: CustomText(
                          text: file,
                          textcolor: primarycolor,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedFileType = value!;
                      });
                    },
                  );
                },
              ),
            ),
            SimpleDialogOption(
              child: const AppButton(
                label: 'Export',
                size: 100,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _saveEnrollment() {
    if (_validateForm()) {
      final enrollment = Enroll(
        studentFullName: _studentFullNameController.text,
        admissionNumber: _admissionNumberController.text,
        gradeId: int.tryParse(_gradeIdController.text) ?? 0,
        streamId: int.tryParse(_streamIdController.text) ?? 0,
        gender: _genderController.text,
        dateOfBirth: _dateOfBirthController.text,
        dateOfAdmission: _dateOfAdmissionController.text,
        modeOfStudy: _modeOfStudyController.text,
        residence: _residenceController.text,
        status: _statusController.text,
        nemisNumber: _nemisNumberController.text,
        assessmentNumber: _assessmentNumberController.text,
        studentMedicalCondition: _studentMedicalConditionController.text,
        medicalEmergencyContact: _medicalEmergencyContactController.text,
      );

      postEnrollment(enrollment).then((response) {
        if (response != null) {
          _showDialog('Success', 'Admission record created successfully', () {
            _clearForm();
            Navigator.pop(context);
          });
        }
      }).catchError((error) {
        if (error.toString().contains('duplicate')) {
          _showDialog('Error', 'Admission cannot be duplicate', () {
            Navigator.pop(context);
          });
        } else {
          _showDialog('Error', 'Failed to save enrollment', () {
            Navigator.pop(context);
          });
        }
      });
    } else {
      _showDialog('Error', 'Please fill all the required fields', () {
        Navigator.pop(context);
      });
    }
  }

  bool _validateForm() {
    return _studentFullNameController.text.isNotEmpty &&
        _admissionNumberController.text.isNotEmpty &&
        _gradeIdController.text.isNotEmpty &&
        _streamIdController.text.isNotEmpty &&
        _genderController.text.isNotEmpty &&
        _dateOfBirthController.text.isNotEmpty &&
        _dateOfAdmissionController.text.isNotEmpty &&
        _modeOfStudyController.text.isNotEmpty &&
        _residenceController.text.isNotEmpty &&
        _statusController.text.isNotEmpty &&
        _nemisNumberController.text.isNotEmpty &&
        _assessmentNumberController.text.isNotEmpty &&
        _studentMedicalConditionController.text.isNotEmpty &&
        _medicalEmergencyContactController.text.isNotEmpty;
  }

  void _showDialog(String title, String content, VoidCallback onPressed) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _clearForm() {
    _studentFullNameController.clear();
    _admissionNumberController.clear();
    _gradeIdController.clear();
    _streamIdController.clear();
    _genderController.clear();
    _dateOfBirthController.clear();
    _dateOfAdmissionController.clear();
    _modeOfStudyController.clear();
    _residenceController.clear();
    _statusController.clear();
    _nemisNumberController.clear();
    _assessmentNumberController.clear();
    _studentMedicalConditionController.clear();
    _medicalEmergencyContactController.clear();
  }

  Future<EnrollmentResponse?> postEnrollment(Enroll enrollment) async {
    final url = Uri.parse('https://demo.learnsoftschoolerp.co.ke/api/save-admissions-details');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(enrollment.toJson()),
    );

   // print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      return EnrollmentResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 409) {
      throw Exception('Admission number cannot be duplicate');
    } else {
      throw Exception('Failed to create enrollment');
    }
  }
}

