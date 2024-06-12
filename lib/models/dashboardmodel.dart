class DashboardData {
  final int sumInvoices;
  final int sumExpenses;
  final int totalUsers;
  final int totalStudents;
  final int totalGrades;
  final int totalLearningAreas;
  final int totalTeachers;
  final int totalParents;
  final int totalIncomes;
  final Map<String, int> monthlyFeePayments;
  DashboardData({
    required this.sumInvoices,
    required this.sumExpenses,
    required this.totalUsers,
    required this.totalStudents,
    required this.totalGrades,
    required this.totalLearningAreas,
    required this.totalTeachers,
    required this.totalParents,
    required this.totalIncomes,
    required this.monthlyFeePayments,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      sumInvoices: json['sumInvoices'],
      sumExpenses: json['sumExpenses'],
      totalUsers: json['totalUsers'],
      totalStudents: json['totalStudents'],
      totalGrades: json['totalGrades'],
      totalLearningAreas: json['totalLearningAreas'],
      totalTeachers: json['totalTeachers'],
      totalParents: json['totalParents'],
      totalIncomes: json['totalIncomes'],
      monthlyFeePayments: Map<String, int>.from(json['monthlyFeePayments']),
    );
  }
}
