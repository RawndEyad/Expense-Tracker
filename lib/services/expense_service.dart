import 'package:expenses_tracker_app/model/expense.dart';

Map<Category, List<Expense>> groupExpensesByCategory(List<Expense> expenses) {
  final Map<Category, List<Expense>> grouped = {};
  for (var expense in expenses) {
    grouped.putIfAbsent(expense.category, () => []).add(expense);
  }
  return grouped;
}
