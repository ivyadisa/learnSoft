import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secondapp/constants/constants.dart';
import 'package:secondapp/views/customs/customtextbutton.dart';
import 'package:secondapp/views/customs/customtextfield.dart';

class MyForm extends StatefulWidget {
  final TextEditingController studentFullNameController;
  final TextEditingController admissionNumberController;
  final TextEditingController gradeIdController;
  final TextEditingController streamIdController;
  final TextEditingController genderController;
  final TextEditingController dateOfBirthController;
  final TextEditingController dateOfAdmissionController;
  final TextEditingController modeOfStudyController;
  final TextEditingController residenceController;
  final TextEditingController statusController;
  final TextEditingController nemisNumberController;
  final TextEditingController assessmentNumberController;
  final TextEditingController studentMedicalConditionController;
  final TextEditingController medicalEmergencyContactController;

  const MyForm({
    Key? key,
    required this.studentFullNameController,
    required this.admissionNumberController,
    required this.gradeIdController,
    required this.streamIdController,
    required this.genderController,
    required this.dateOfBirthController,
    required this.dateOfAdmissionController,
    required this.modeOfStudyController,
    required this.residenceController,
    required this.statusController,
    required this.nemisNumberController,
    required this.assessmentNumberController,
    required this.studentMedicalConditionController,
    required this.medicalEmergencyContactController,
  }) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        _image = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: widget.studentFullNameController,
            hint: 'Student Full Name',
          ),
          SizedBox(height: 12),
          CustomTextField(
            controller: widget.admissionNumberController,
            hint: 'Admission Number',
          ),
          SizedBox(height: 12),
          CustomTextField(
            controller: widget.gradeIdController,
            hint: 'Grade ID',
          ),
          SizedBox(height: 12),
          CustomTextField(
            controller: widget.streamIdController,
            hint: 'Stream ID',
          ),
          SizedBox(height: 12),
          CustomTextField(
            controller: widget.genderController,
            hint: 'Gender',
          ),
          SizedBox(height: 12),
          CustomTextField(
            controller: widget.dateOfBirthController,
            hint: 'Date of Birth',
          ),
          SizedBox(height: 12),
          CustomTextField(
            controller: widget.dateOfAdmissionController,
            hint: 'Date of Admission',
          ),
          SizedBox(height: 12),
          CustomTextField(
            controller: widget.modeOfStudyController,
            hint: 'Mode of Study',
          ),
          SizedBox(height: 12),
          CustomTextField(
            controller: widget.residenceController,
            hint: 'Residence',
          ),
          SizedBox(height: 12),
          CustomTextField(
            controller: widget.statusController,
            hint: 'Status',
          ),
          SizedBox(height: 12),
          CustomTextField(
            controller: widget.nemisNumberController,
            hint: 'NEMIS Number',
          ),
          SizedBox(height: 12),
          CustomTextField(
            controller: widget.assessmentNumberController,
            hint: 'Assessment Number',
          ),
          SizedBox(height: 12),
          CustomTextField(
            controller: widget.studentMedicalConditionController,
            hint: 'Student Medical Condition',
          ),
          SizedBox(height: 12),
          CustomTextField(
            controller: widget.medicalEmergencyContactController,
            hint: 'Medical Emergency Contact',
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10, // adjust the elevation value
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: 200,
                    height: 230,
                    decoration: BoxDecoration(
                      color: backgroundcolor.withOpacity(0.7),
                      image: DecorationImage(
                        image: _image != null
                            ? FileImage(_image!)
                            : AssetImage('assets/images/upload.png')
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextbutton(
                  color: primarycolor.withOpacity(0.5),
                  label: "Upload a photo",
                  action: _getImageFromGallery,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
