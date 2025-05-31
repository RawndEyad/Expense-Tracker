import 'package:expenses_tracker_app/views/widgets/expense_category_%D8%A7eader.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker_app/model/expense.dart';
import 'package:expenses_tracker_app/services/expense_service.dart';
import 'package:expenses_tracker_app/views/pages/new_expense.dart';
import 'package:expenses_tracker_app/views/widgets/listTile_item.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Groceries',
      amount: 50.0,
      category: Category.food,
      dateTime: DateTime.now().subtract(Duration(days: 1)),
    ),
    Expense(
      title: 'Bus Ticket',
      amount: 10.0,
      category: Category.travel,
      dateTime: DateTime.now().subtract(Duration(days: 2)),
    ),
    Expense(
      title: 'Movie Night',
      amount: 30.0,
      category: Category.leisure,
      dateTime: DateTime.now().subtract(Duration(days: 3)),
    ),
    Expense(
      title: 'Online Course',
      amount: 100.0,
      category: Category.education,
      dateTime: DateTime.now().subtract(Duration(days: 4)),
    ),
    Expense(
      title: 'Office Supplies',
      amount: 25.0,
      category: Category.work,
      dateTime: DateTime.now().subtract(Duration(days: 5)),
    ),
    Expense(
      title: 'Bus Ticket',
      amount: 10.0,
      category: Category.travel,
      dateTime: DateTime.now().subtract(Duration(days: 2)),
    ),
  ];

  int? expandedIndex;

  final Map<Category, IconData> _categoryIcons = {
    Category.food: Icons.fastfood,
    Category.travel: Icons.directions_bus,
    Category.leisure: Icons.movie,
    Category.education: Icons.school,
    Category.work: Icons.work,
  };

  Icon _getCategoryIcon(Category category) {
    return Icon(
      _categoryIcons[category] ?? Icons.category,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (ctx) => AddExpenseForm(
            onAddExpense: (newExpense) {
              setState(() {
                _registeredExpenses.add(newExpense);
              });
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryEntries =
        groupExpensesByCategory(_registeredExpenses).entries.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Expense Tracker'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpenseOverlay,
        tooltip: 'Add Expense',
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.only(bottom: 80),
        itemCount: categoryEntries.length,
        separatorBuilder: (_, __) => const SizedBox(height: 6),
        itemBuilder: (context, index) {
          final category = categoryEntries[index].key;
          final expenses = categoryEntries[index].value;
          final isExpanded = expandedIndex == index;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  key: ValueKey(index),
                  leading: _getCategoryIcon(category),
                  title: ExpenseCategoryHeader(
                    title: category.name.toUpperCase(),
                    itemCount: expenses.length,
                    totalAmount: expenses.fold(0.0, (sum, e) => sum + e.amount),
                  ),
                  initiallyExpanded: isExpanded,
                  onExpansionChanged: (expanded) {
                    setState(() {
                      expandedIndex = expanded ? index : null;
                    });
                  },
                  children:
                      expenses
                          .map((expense) => ListTile_Item(expense: expense))
                          .toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
