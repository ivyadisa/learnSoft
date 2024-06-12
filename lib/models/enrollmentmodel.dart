class Enroll {
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
  final String? nemisNumber;
  final String? assessmentNumber;
  final String? studentMedicalCondition;
  final String? medicalEmergencyContact;

  Enroll({
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
    this.nemisNumber,
    this.assessmentNumber,
    this.studentMedicalCondition,
    this.medicalEmergencyContact,
  });

  Map<String, dynamic> toJson() {
    return {
      'student_full_name': studentFullName,
      'admission_number': admissionNumber,
      'grade_id': gradeId,
      'stream_id': streamId,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'date_of_admission': dateOfAdmission,
      'mode_of_study': modeOfStudy,
      'residence': residence,
      'status': status,
      'nemis_number': nemisNumber,
      'assessment_number': assessmentNumber,
      'student_medical_condition': studentMedicalCondition,
      'medical_emergency_contact': medicalEmergencyContact,
    };
  }

  factory Enroll.fromJson(Map<String, dynamic> json) {
    return Enroll(
      studentFullName: json['student_full_name'],
      admissionNumber: json['admission_number'],
      gradeId: json['grade_id'],
      streamId: json['stream_id'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      dateOfAdmission: json['date_of_admission'],
      modeOfStudy: json['mode_of_study'],
      residence: json['residence'],
      status: json['status'],
      nemisNumber: json['nemis_number'],
      assessmentNumber: json['assessment_number'],
      studentMedicalCondition: json['student_medical_condition'],
      medicalEmergencyContact: json['medical_emergency_contact'],
    );
  }
}

class EnrollmentResponse {
  final String message;
  final Enroll admission;

  EnrollmentResponse({
    required this.message,
    required this.admission,
  });

  factory EnrollmentResponse.fromJson(Map<String, dynamic> json) {
    return EnrollmentResponse(
      message: json['message'],
      admission: Enroll.fromJson(json['admission']),
    );
  }
}
