class StreamModel {
  final int id;
  final String stream;
  final int createdBy;
  final String createdAt;
  final String updatedAt;

  StreamModel({
    required this.id,
    required this.stream,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StreamModel.fromJson(Map<String, dynamic> json) {
    return StreamModel(
      id: json['id'],
      stream: json['stream'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
