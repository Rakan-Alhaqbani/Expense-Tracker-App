import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expanse {
  Expanse(
      {required this.title,
      required this.amount,
      required this.category,
      required this.date})
      : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpanseBucket {
  ExpanseBucket({required this.category, required this.expanses});

  ExpanseBucket.forCategory(List<Expanse> allExpanses, this.category)
      : expanses = allExpanses
            .where((expanse) => expanse.category == category)
            .toList();

  final Category category;
  final List<Expanse> expanses;
  double get totalExpanses {
    double sum = 0;

    for (final expanse in expanses) {
      sum = sum + expanse.amount;
    }
    return sum;
  }
}
