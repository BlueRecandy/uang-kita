import 'package:uang_kita/models/category_type_model.dart';

class Bill {
  Bill({
    this.id,
    required this.title,
    required this.amount,
    required this.dueDate,
    required this.category,
  });

  late int? id;
  final String title;
  final int amount;
  final DateTime dueDate;
  final CategoryType category;
}
