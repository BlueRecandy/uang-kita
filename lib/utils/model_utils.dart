import 'package:uang_kita/models/bill_model.dart';
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

  static Bill mapToBill(Map<String, dynamic> map) {
    final category = categoryTypeMap[map['category'].toString()];

    final bill = Bill(
        id: map['id'] as int,
        title: map['title'] as String,
        amount: int.parse(map['amount'].toString()),
        dueDate: DateTime.parse(map['due_date'].toString()),
        category: category!);

    return bill;
  }
}
