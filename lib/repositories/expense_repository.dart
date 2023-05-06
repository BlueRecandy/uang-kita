import 'package:sqflite/sqflite.dart';
import 'package:uang_kita/models/category_type_model.dart';
import 'package:uang_kita/models/expense_model.dart';

import 'interfaces/interface_repository.dart';

class ExpenseRepository extends IRepository<Expense, int> {
  final tableName = 'expenses';

  @override
  Future<void> createTable(Database db) {
    return db.execute('CREATE TABLE IF NOT EXISTS $tableName ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'title TEXT,'
        'amount INTEGER,'
        'date DATE,'
        'category TEXT'
        ' )');
  }

  @override
  Future<void> insert(Database db, Map<String, dynamic> data) {
    return db.insert(tableName, data);
  }

  @override
  Future<List<Expense>> findAll(Database db) async {
    final expenseRecords = await db.query(tableName);

    final List<Expense> expenses = [];

    for (var element in expenseRecords) {
      final category =
          CategoryType.values[int.parse(element['category'].toString())];

      final expense = Expense(
          title: element['title'] as String,
          amount: int.parse(element['amount'].toString()),
          date: DateTime.parse(element['date'].toString()),
          category: category);

      expenses.add(expense);
    }

    return expenses;
  }

  @override
  Future<void> delete(Database db, int id) {
    return db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
