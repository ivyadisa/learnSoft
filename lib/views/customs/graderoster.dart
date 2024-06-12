import 'package:flutter/material.dart';
import 'package:secondapp/constants/constants.dart';
import 'package:secondapp/views/customs/custombutton.dart';
import 'package:secondapp/views/customs/customtext.dart';
import 'package:secondapp/services/api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../models/graderostermodel.dart';

TextEditingController gradeSearch = TextEditingController();

class Grades extends StatefulWidget {
  const Grades({super.key});

  @override
  State<Grades> createState() => _GradesState();
}

class _GradesState extends State<Grades> {
  String selectedGrade = "All Grades";
  String selectedStream = "All Streams";
  final ApiService _apiService = ApiService();
  late Future<List<GradeRosterModel>> _gradesFuture;

  @override
  void initState() {
    super.initState();
    _gradesFuture = _apiService.fetchGradeRoster();
  }

  List<GradeRosterModel> _filterGrades(List<GradeRosterModel> grades) {
    return grades.where((grade) {
      final matchGrade = selectedGrade == "All Grades" || grade.grade == selectedGrade;
      final matchStream = selectedStream == "All Streams" || grade.stream == selectedStream;
      return matchGrade && matchStream;
    }).toList();
  }

  Future<void> _generatePdf(List<GradeRosterModel> grades) async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (context) {
            return pw.Table.fromTextArray(
              headers: ['#', 'Adm number', 'Name', 'Grade', 'Stream', 'Status'],
              data: List<List<String>>.generate(
                grades.length,
                (index) => [
                  (index + 1).toString(),
                  grades[index].admissionNumber ?? '',
                  grades[index].studentFullName ?? '',
                  grades[index].grade ?? '',
                  grades[index].stream ?? '',
                  grades[index].status ?? 'unknown',
                ],
              ),
            );
          },
        ),
      );

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
        name: 'grade_roster.pdf',
      );
    } catch (e) {
      print('Error generating PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentwidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: primarycolor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: DropdownButton<String>(
                          value: selectedGrade,
                          isExpanded: true,
                          items: [
                            'All Grades',
                            'Grade 1',
                            'Grade 2',
                            'Grade 3',
                            'Grade 4',
                            'Grade 5',
                          ].map((String grade) {
                            return DropdownMenuItem<String>(
                              value: grade,
                              child: CustomText(
                                text: grade,
                                textcolor: primarycolor,
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedGrade = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: primarycolor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: DropdownButton<String>(
                          value: selectedStream,
                          isExpanded: true,
                          items: ['All Streams', 'A', 'B', 'C'].map((String stream) {
                            return DropdownMenuItem<String>(
                              value: stream,
                              child: CustomText(
                                text: stream,
                                textcolor: primarycolor,
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedStream = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<GradeRosterModel>>(
              future: _gradesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final filteredGrades = _filterGrades(snapshot.data!);
                  return Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 20.0,
                        ),
                        child: GradesDataTable(grades: filteredGrades),
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: AppButton(
                label: "Generate Roster",
                color: primarycolor,
                size: currentwidth * 0.9,
                action: () async {
                  try {
                    final snapshot = await _gradesFuture;
                    final filteredGrades = _filterGrades(snapshot);
                    print("Filtered Grades: ${filteredGrades.length}");
                    await _generatePdf(filteredGrades);
                  } catch (e) {
                    print('Error in button action: $e');
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class GradesDataTable extends StatelessWidget {
  final List<GradeRosterModel> grades;

  const GradesDataTable({required this.grades, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(child: HeaderCell(text: '#')),
            Expanded(flex: 2, child: HeaderCell(text: 'Adm ')),
            Expanded(flex: 3, child: HeaderCell(text: 'Name')),
            Expanded(flex: 2, child: HeaderCell(text: 'Grade')),
            Expanded(flex: 2, child: HeaderCell(text: 'Stream')),
            Expanded(flex: 2, child: HeaderCell(text: 'Status')),
          ],
        ),
        ...grades.asMap().entries.map((entry) {
          int index = entry.key + 1;
          GradeRosterModel grade = entry.value;
          return Row(
            children: [
              Expanded(child: DataCellWidget(text: index.toString())),
              Expanded(flex: 2, child: DataCellWidget(text: grade.admissionNumber ?? '')),
              Expanded(flex: 4, child: DataCellWidget(text: grade.studentFullName ?? '')),
              Expanded(flex: 3, child: DataCellWidget(text: grade.grade ?? '')),
              Expanded(flex: 1, child: DataCellWidget(text: grade.stream ?? '')),
              Expanded(
                flex: 4,
                child: StatusCellWidget(
                  text: grade.status ?? 'unknown',
                  isBadge: true,
                  isActive: grade.status == 'Active',
                ),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }
}

class HeaderCell extends StatelessWidget {
  final String text;
  const HeaderCell({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: primarycolor.withOpacity(0.2),
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

class DataCellWidget extends StatelessWidget {
  final String text;
  const DataCellWidget({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Center(
        child: CustomText(
          text: text,
          textcolor: Colors.black,
        ),
      ),
    );
  }
}

class StatusCellWidget extends StatelessWidget {
  final String text;
  final bool isBadge;
  final bool isActive;
  const StatusCellWidget({Key? key, required this.text, this.isBadge = false, this.isActive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Center(
        child: isBadge
            ? _buildBadge()
            : CustomText(
                text: text,
                textcolor: isActive ? Colors.green : primarycolor,
              ),
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(16),
      ),
      child: CustomText(text: text, textcolor: Colors.white),
    );
  }
}
