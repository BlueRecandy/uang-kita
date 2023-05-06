import 'package:uang_kita/models/expense_model.dart';

import '../models/category_type_model.dart';

class ModelUtils {
  static Expense mapToExpense(Map<String, dynamic> map) {
    final category = categoryTypeMap[map['category'].toString()];

    final expense = Expense(
        title: map['title'] as String,
        amount: int.parse(map['amount'].toString()),
        date: DateTime.parse(map['date'].toString()),
        category: category!);

    return expense;
  }
}
