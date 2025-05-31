import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenses_tracker_app/model/expense.dart';

class AddExpenseForm extends StatefulWidget {
  final void Function(Expense) onAddExpense;

  const AddExpenseForm({super.key, required this.onAddExpense});

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category? _selectedCategory;
  DateTime? _selectedDate;

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid || _selectedCategory == null || _selectedDate == null) {
      _showErrorDialog();
      return;
    }

    final expense = Expense(
      title: _titleController.text.trim(),
      amount: double.parse(_amountController.text),
      category: _selectedCategory!,
      dateTime: _selectedDate!,
    );

    widget.onAddExpense(expense);
    Navigator.of(context).pop();
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Invalid Input'),
            content: Text(
              _selectedCategory == null
                  ? 'Please select a category.'
                  : _selectedDate == null
                  ? 'Please select a date.'
                  : 'Please fix the errors in the form.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, keyboardSpace + 16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add New Expense",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a valid title.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Amount'),
              validator: (value) {
                final amount = double.tryParse(value ?? '');
                if (amount == null || amount <= 0) {
                  return 'Please enter a valid amount.';
                }
                return null;
              },
            ),
            DropdownButtonFormField<Category>(
              value: _selectedCategory,
              decoration: const InputDecoration(labelText: 'Category'),
              items:
                  Category.values
                      .map(
                        (cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat.name.toUpperCase()),
                        ),
                      )
                      .toList(),
              onChanged: (value) => setState(() => _selectedCategory = value),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen'
                        : 'Date: ${DateFormat.yMMMd().format(_selectedDate!)}',
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Pick Date'),
                  onPressed: _presentDatePicker,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text("Add"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
