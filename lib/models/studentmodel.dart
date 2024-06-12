class Student {
  final int studentId;
  final String studentFullName;
  final String admissionNumber;
  final int gradeId;
  final int streamId;
  final String gender;
  final String dateOfBirth;
  final String dateOfAdmission;
  final String modeOfStudy;
  final String residence;
  final String status;
  final String? studentPhoto;
  final String? nemisNumber;
  final String? assessmentNumber;
  final String? studentMedicalCondition;
  final String? medicalEmergencyContact;
  final String createdAt;
  final String updatedAt;
  final String grade;
  final String stream;
  List<Parent> parents; // Add list of parents

  Student({
    required this.studentId,
    required this.studentFullName,
    required this.admissionNumber,
    required this.gradeId,
    required this.streamId,
    required this.gender,
    required this.dateOfBirth,
    required this.dateOfAdmission,
    required this.modeOfStudy,
    required this.residence,
    required this.status,
    this.studentPhoto,
    this.nemisNumber,
    this.assessmentNumber,
    this.studentMedicalCondition,
    this.medicalEmergencyContact,
    required this.createdAt,
    required this.updatedAt,
    required this.grade,
    required this.stream,
    required this.parents, // Initialize list of parents
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    // Convert parent json array to list of Parent objects
    List<dynamic> parentsJson = json['parents'] ?? [];
    List<Parent> parents =
        parentsJson.map((parentJson) => Parent.fromJson(parentJson)).toList();

    return Student(
      studentId: json['id'] ?? 0,
      studentFullName: json['student_full_name'] ?? '',
      admissionNumber: json['admission_number'] ?? '',
      gradeId: json['grade_id'] ?? 0,
      streamId: json['stream_id'] ?? 0,
      gender: json['gender'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      dateOfAdmission: json['date_of_admission'] ?? '',
      modeOfStudy: json['mode_of_study'] ?? '',
      residence: json['residence'] ?? '',
      status: json['status'] ?? '',
      studentPhoto: json['student_photo'],
      nemisNumber: json['nemis_number'],
      assessmentNumber: json['assessment_number'],
      studentMedicalCondition: json['student_medical_condition'],
      medicalEmergencyContact: json['medical_emergency_contact'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      grade: json['grade'] ?? '',
      stream: json['stream'] ?? '',

      parents: parents, // Assign list of parents
    );
  }
}

class Parent {
  final int id;
  final String firstName;
  final String surname;
  final String phoneNumber;
  final String? email;
  final int status;
  final String residence;
  final String createdAt;
  final String updatedAt;

  Parent({
    required this.id,
    required this.firstName,
    required this.surname,
    required this.phoneNumber,
    this.email,
    required this.status,
    required this.residence,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      surname: json['surname'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email'],
      status: json['status'] ?? 0,
      residence: json['residence'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class FinanceDetails {
  final double totalInvoiceAmount;
  final double paidAmount;
  final double balance;

  FinanceDetails({
    required this.totalInvoiceAmount,
    required this.paidAmount,
    required this.balance,
  });

  factory FinanceDetails.fromJson(Map<String, dynamic> json) {
    return FinanceDetails(
      totalInvoiceAmount: json['totalInvoiceAmount'],
      paidAmount: json['paidAmount'],
      balance: json['balance'],
    );
  }
}
