import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      // elevated container
      child: Padding(
        padding: const EdgeInsets.symmetric(
          // adding spasing for cards
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                    '\$${expense.amount.toStringAsFixed(2)}'), // 26.9999 => 26.99 (2 digits)
                const Spacer(),
                Row(
                  children: [
                    Icon(CategoryIcons[expense.category],),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expense.formattedDate), //using getter 
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
