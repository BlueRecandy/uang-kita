import 'package:uang_kita/models/category_type_model.dart';

class Expense {
  const Expense(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date,
      required this.category});

  final int id;
  final String title;
  final int amount;
  final DateTime date;
  final CategoryType category;
}
