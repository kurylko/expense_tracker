import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid(); // unique id initializer

enum Category { food, travel, work, cat } //const values - to avoid typo

const CategoryIcons = {
  Category.food: Icons.dining_rounded,
  Category.travel: Icons.flight,
  Category.cat: Icons.sunny,
  Category.work: Icons.laptop,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); // assigning unique property id

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    // this is flutter getter
    return formatter.format(date);
  }
}

//For the chart - utility constructor function
class ExpenseBucket {
  const ExpenseBucket({required this.expenses, required this.category});

  ExpenseBucket.forCategory(
    //filtering expenses by category
    List<Expense> allExpenses,
    this.category,
  ) : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; //sum = sum + expense.amount
    }

    return sum;
  }
}
