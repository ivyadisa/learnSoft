import 'package:flutter/material.dart';
import 'package:secondapp/constants/constants.dart';
import 'package:secondapp/views/customs/custombutton.dart';
import 'package:secondapp/views/customs/customtext.dart';
import 'package:secondapp/views/customs/customtextfield.dart';
import 'package:secondapp/views/customs/profilecard.dart';
import 'package:secondapp/services/api.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/studentmodel.dart'; // Import your Student and Parent models

TextEditingController search = TextEditingController();

class Studentprofile extends StatefulWidget {
  const Studentprofile({Key? key}) : super(key: key);

  @override
  State<Studentprofile> createState() => _StudentprofileState();
}


class Profilecard extends StatelessWidget {
  final String label;
  final Widget? icon;
  final Widget? trailing;

  const Profilecard({super.key, required this.label, this.icon, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: icon,
        title: Text(label),
        trailing: trailing,
      ),
    );
  }
}


class _StudentprofileState extends State<Studentprofile> {
  String option = "All Views";
  final List<String> options = [
    "All Views",
    "Background Information",
    "Medical Details",
    "Parent Details",
    "Finance",
    "Transport",
    "Assessment"
  ];

  final ApiService _apiService = ApiService();
  List<Student> _students = [];
  Student? _selectedStudent;
  List<Student> _suggestions = [];
  List<Parent> _selectedStudentParents = []; // Store selected student's parents

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                children: [
                  IconButton(
                    onPressed: _showExportDialog,
                    icon: const Icon(Icons.print_outlined),
                  ),
                  const CustomText(
                    text: "Export",
                    textcolor: primarycolor,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: currentWidth * 0.6,
              child: TextField(
                controller: search,
                onChanged: _searchStudents,
                decoration: InputDecoration(
                  hintText: 'Search for a student...',
                  suffixIcon: IconButton(
                    onPressed: () {
                      search.clear();
                      setState(() {
                        _suggestions = [];
                      });
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStudentPhoto(),
              DropdownButton<String>(
                value: option,
                items: options.map((String view) {
                  return DropdownMenuItem<String>(
                    value: view,
                    child: Text(view),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    option = newValue!;
                    if (option == 'Parent Details' &&
                        _selectedStudent != null) {
                      _loadParentDetails(_selectedStudent!);
                    }
                  });
                },
              ),
            ],
          ),
        ),
        _buildSuggestions(),
        SizedBox(
          height: 10,
        ),
        _selectedStudent != null
            ? _buildStudentDetails(_selectedStudent!)
            : const SizedBox.shrink(),
      ]),
    );
  }

  Widget _buildSuggestions() {
    return Column(
      children: _suggestions.map((student) {
        return ListTile(
          title: Text(student.studentFullName),
          onTap: () {
            setState(() {
              _selectedStudent = student;
              _suggestions = [];
              search.clear();
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildStudentPhoto() {
    final imageUrl = _selectedStudent?.studentPhoto;
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: backgroundcolor.withOpacity(0.6),
        //border: Border.all(width: 0.5),
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: imageUrl != null
              ? NetworkImage(imageUrl)
              : AssetImage("/images/student.png") as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildStudentDetails(Student student) {
    switch (option) {
      case 'All Views':
        return _buildAllViews(student);
      case 'Background Information':
        return _buildBackgroundInformation(student);
      case 'Medical Details':
        return _buildMedicalDetails(student);
      case 'Parent Details':
        return _buildParentDetails(student);
      // case 'Finance':
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildAllViews(Student student) {
    return Column(
      children: [
        Profilecard(label: 'Full Name: ${student.studentFullName}'),
        Profilecard(label: 'Gender: ${student.gender}'),
        Profilecard(label: 'Grade: ${student.gradeId}'),
        Profilecard(label: 'Admission Number: ${student.admissionNumber}'),
        Profilecard(label: 'Date of Birth: ${student.dateOfBirth}'),
        Profilecard(label: 'Mode of Study: ${student.modeOfStudy}'),
        Profilecard(label: 'Residence: ${student.residence ?? "N/A"}'),
        Profilecard(label: 'Status: ${student.status ?? "N/A"}'),
      ],
    );
  }

  Widget _buildBackgroundInformation(Student student) {
    return Column(
      children: [
        Profilecard(label: 'Full Name: ${student.studentFullName}'),
        Profilecard(label: 'Gender: ${student.gender}'),
        Profilecard(label: 'Grade: ${student.gradeId}'),
        Profilecard(label: 'Admission Number: ${student.admissionNumber}'),
        Profilecard(label: 'Date of Birth: ${student.dateOfBirth}'),
        Profilecard(label: 'Mode of Study: ${student.modeOfStudy}'),
        Profilecard(label: 'Residence: ${student.residence ?? "N/A"}'),
        Profilecard(label: 'Status: ${student.status ?? "N/A"}'),
      ],
    );
  }

  Widget _buildMedicalDetails(Student student) {
    return Column(
      children: [
        Profilecard(label: 'Residence: ${student.residence ?? "N/A"}'),
        Profilecard(
            label:
                'Emergency Contact: ${student.medicalEmergencyContact ?? "N/A"}'),
        Profilecard(
            label:
                'Medical Condition: ${student.studentMedicalCondition ?? "N/A"}'),
      ],
    );
  }

  Widget _buildParentDetails(Student student) {
    if (_selectedStudentParents.isNotEmpty) {
      return Column(
        children: _selectedStudentParents.map((parent) {
          return Column(
            children: [
              Profilecard(
                label: 'Full Names: ${parent.firstName} ${parent.surname}',
              ),
              Profilecard(
                label: 'Phone Number: ${parent.phoneNumber}',
                trailing: IconButton(
                  icon: Icon(Icons.phone, color: Colors.green),
                  onPressed: () {
                    if (parent.phoneNumber != null) {
                      _launchPhoneCall(parent.phoneNumber!);
                    }
                  },
                ),
              ),
              Profilecard(label: 'Email: ${parent.email}'),
              Profilecard(label: 'Residence: ${parent.residence}')
            ],
          );
        }).toList(),
      );
    } else {
      return const CircularProgressIndicator(); // Show loading indicator while fetching parent details
    }
  }

  void _searchStudents(String searchText) async {
    try {
      List<Student> students = await _apiService.fetchStudents(searchText);
      setState(() {
        _suggestions = students.where((student) {
          return student.studentFullName
              .toLowerCase()
              .contains(searchText.toLowerCase());
        }).toList();
      });
    } catch (e) {
      print('Error fetching students: $e');
    }
  }

  Future<void> _loadParentDetails(Student student) async {
    try {
      final List<Parent> parents =
          await _apiService.fetchParentDetails(student.studentId);
      setState(() {
        _selectedStudent = student;
        _suggestions = [];
        search.clear();
        _selectedStudentParents = parents;
      });
    } catch (e) {
      print('Error fetching parent details: $e');
    }
  }

  Future<void> _launchPhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
              child: DropdownButton<String>(
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
}
