import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenses_tracker_app/model/expense.dart';

class ListTile_Item extends StatelessWidget {
  final Expense expense;

  const ListTile_Item({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMd().format(expense.dateTime);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          title: Text(
            expense.title,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            formattedDate,
            style: TextStyle(color: Colors.grey[600]),
          ),
          trailing: Text(
            '\$${expense.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
