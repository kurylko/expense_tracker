import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expeses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
          //to swipe not needed expenses
          key: ValueKey(expenses[index]), //identify the Expense to delete
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          child: ExpenseItem(expenses[index])),
    ); //scrollable list - shows only visible items
  }
}
