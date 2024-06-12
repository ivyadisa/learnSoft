class Grade {
  final int id;
  final String grade;
  final int createdBy;
  final String? createdAt;
  final String? updatedAt;

  Grade({
    required this.id,
    required this.grade,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'],
      grade: json['grade'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
