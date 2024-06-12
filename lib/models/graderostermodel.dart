class GradeRosterModel {
  final int id;
  final String studentFullName;
  final String admissionNumber;
  final String? grade;
  final String stream;
  final String status;

  GradeRosterModel({
    required this.id,
    required this.studentFullName,
    required this.admissionNumber,
    required this.stream,
    required this.status,
    this.grade, // Allow null value for grade
  });

  factory GradeRosterModel.fromJson(Map<String, dynamic> json) {
    return GradeRosterModel(
      id: json['id'] ?? 0, // Provide default value in case of null
      studentFullName: json['student_full_name'] ?? '', // Provide default value in case of null
      admissionNumber: json['admission_number'] ?? '', // Provide default value in case of null
      grade: json['grade'], // Nullable property, no need for null check here
      stream: json['stream'] ?? '', // Provide default value in case of null
      status: json['status'] ?? '', // Provide default value in case of null
    );
  }
}
