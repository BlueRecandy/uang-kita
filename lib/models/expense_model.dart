import 'package:uang_kita/models/category_type_model.dart';

class Expense {
  Expense(
      {this.id,
      required this.title,
      required this.amount,
      required this.date,
      required this.category});

  int? id;
  final String title;
  final int amount;
  final DateTime date;
  final CategoryType category;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.index,
    };
  }
}
