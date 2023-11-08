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

  String get formattedDate {            // this is flutter getter 
    return formatter.format(date);
  }
}
