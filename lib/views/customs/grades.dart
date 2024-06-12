import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secondapp/constants/constants.dart';
import 'package:secondapp/models/gradesmodel.dart';
import 'package:secondapp/services/api.dart';
import 'package:secondapp/views/customs/custombutton.dart';
import 'package:secondapp/views/customs/customtext.dart';
import 'package:secondapp/views/customs/customtextfield.dart';

class GradesPage extends StatefulWidget {
  @override
  _GradesPageState createState() => _GradesPageState();
}

class _GradesPageState extends State<GradesPage> {
  final ApiService _apiService = ApiService();
  TextEditingController searchController = TextEditingController();
  List<Grade> _grades = [];
  List<Grade> _filteredGrades = [];

  @override
  void initState() {
    super.initState();
    _fetchGrades();
    searchController.addListener(_filterGrades);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterGrades);
    searchController.dispose();
    super.dispose();
  }

  void _fetchGrades() async {
    try {
      List<Grade> grades = await _apiService.fetchGrades();
      setState(() {
        _grades = grades;
        _filteredGrades = grades;
      });
    } catch (e) {
      print('Error fetching grades: $e');
    }
  }

  void _filterGrades() {
    String searchQuery = searchController.text.toLowerCase();
    setState(() {
      _filteredGrades = _grades.where((grade) {
        return grade.grade.toLowerCase().contains(searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: _buildGradesList(),
    );
  }

  Widget _buildGradesList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Icon(Icons.print_outlined),
                  CustomText(
                    text: "Export",
                    textcolor: primarycolor,
                  ),
                ],
              ),
              AppButton(
                label: "Add New",
                color: primarycolor,
                size: 120,
                //onPressed: _showAddGradeDialog,
              )
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 200,
              height: 38,
              child: CustomTextField(
                controller: searchController,
                hint: "Search grades",
                prefixicon: const Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                const Row(
                  children: [
                    Expanded(child: HeaderCell(text: 'Grade')),
                    Expanded(child: HeaderCell(text: 'Created By')),
                    Expanded(child: HeaderCell(text: 'Actions')),
                  ],
                ),
                const Divider(color: primarycolor, thickness: 1),
                ..._filteredGrades.map((grade) {
                  return _buildTableRow(grade.grade, grade.createdBy.toString(),
                      _filteredGrades.indexOf(grade));
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(String grade, String createdBy, int index) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        children: [
          Expanded(child: Center(child: Text(grade))),
          Expanded(child: Center(child: Text(createdBy))),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_red_eye),
                    onPressed: () {
                      // View action
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _showEditGradeDialog(grade, createdBy, index);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Delete action
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddGradeDialog() {
    final TextEditingController gradeController = TextEditingController();
    final TextEditingController createdByController = TextEditingController();

    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Grade'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: gradeController,
                decoration: const InputDecoration(labelText: 'Grade'),
              ),
              TextField(
                controller: createdByController,
                decoration: const InputDecoration(labelText: 'Created By'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Add grade action
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditGradeDialog(String grade, String createdBy, int index) {
    final TextEditingController gradeController =
        TextEditingController(text: grade);
    final TextEditingController createdByController =
        TextEditingController(text: createdBy);

    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Grade'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: gradeController,
                decoration: const InputDecoration(labelText: 'Grade'),
              ),
              TextField(
                controller: createdByController,
                decoration: const InputDecoration(labelText: 'Created By'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Edit grade action
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class HeaderCell extends StatelessWidget {
  final String text;
  const HeaderCell({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
      ),
      child: Center(
        child: CustomText(
          text: text,
          textcolor: primarycolor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
