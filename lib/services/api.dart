import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:secondapp/models/gradesmodel.dart';
import 'package:secondapp/models/streammodel.dart';
import 'package:secondapp/models/studentmodel.dart';

import '../models/enrollmentmodel.dart';
import '../models/graderostermodel.dart';

class ApiService {
  final String apiUrl =
      'https://demo.learnsoftschoolerp.co.ke/api/mobile-Home/api-data';
  final String gradesApiUrl =
      'https://demo.learnsoftschoolerp.co.ke/api/grades';
  final String gradeRosterUrl =
      'https://demo.learnsoftschoolerp.co.ke/api/students';
  final String studentsApiUrl =
      'https://demo.learnsoftschoolerp.co.ke/api/student-profile-information';
  static const String baseUrl = 'https://demo.learnsoftschoolerp.co.ke/api/';
  //final String studentsApiUrl = '${baseUrl}student-profile-information';
  final String studentDetailsUrl = '${baseUrl}get_student_info';

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Grade>> fetchGrades() async {
    try {
      final response = await http.get(Uri.parse(gradesApiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> gradesData = data['grades'];
        final List<Grade> grades =
            gradesData.map((json) => Grade.fromJson(json)).toList();
        return grades;
      } else {
        throw Exception('Failed to fetch grades: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch grades: $e');
    }
  }

  Future<List<StreamModel>> fetchStreams() async {
    try {
      final response = await http.get(Uri.parse(gradesApiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> streamsData = data['streams'];
        final List<StreamModel> streams = streamsData
            .map((json) => StreamModel.fromJson(json))
            .toList(); // Assuming you have a StreamModel class for your streams data
        return streams;
      } else {
        throw Exception('Failed to fetch streams: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch streams: $e');
    }
  }

  Future<List<GradeRosterModel>> fetchGradeRoster() async {
    final response = await http.post(Uri.parse(gradeRosterUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => GradeRosterModel.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load grade roster');
    }
  }


  Future<List<Student>> fetchStudents(String query) async {
    final response = await http.get(Uri.parse('$studentsApiUrl?search=$query'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> studentsData = data['students'];
      final List<Student> students =
          studentsData.map((json) => Student.fromJson(json)).toList();
      return students;
    } else {
      throw Exception('Failed to fetch students: ${response.statusCode}');
    }
  }

  Future<Student> fetchStudentDetails(int studentId) async {
    final response = await http.get(Uri.parse('$studentDetailsUrl/$studentId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Student.fromJson(data['student']);
    } else {
      throw Exception('Failed to fetch student details');
    }
  }

  Future<List<Parent>> fetchParentDetails(int studentId) async {
    final response = await http.get(Uri.parse(
        'https://demo.learnsoftschoolerp.co.ke/api/get_student_info/$studentId'));

    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body)['student'];
      final List<dynamic> jsonParents = jsonData['parents'];
      return jsonParents.map((e) => Parent.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load parent details');
    }
  }

  }

