enum Category { travel, work, education, leisure, food }

class Expense {
  final String title;
  final double amount;
  final Category category;
  final DateTime dateTime;

  Expense({
    required this.title,
    required this.amount,
    required this.category,
    required this.dateTime,
  });
}
