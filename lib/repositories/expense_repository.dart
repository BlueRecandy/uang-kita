import 'package:sqflite/sqflite.dart';
import 'package:uang_kita/models/category_type_model.dart';
import 'package:uang_kita/models/expense_model.dart';
import 'package:uang_kita/utils/model_utils.dart';

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
    // validate data
    if (data['title'] == null ||
        data['category'] == null ||
        data['amount'] == null) {
      throw Exception('Field title, category, dan amount kosong');
    }

    data['date'] = DateTime.now().toIso8601String();

    final category = data['category'] as CategoryType;

    data['category'] = category.name;

    return db.insert(tableName, data);
  }

  @override
  Future<List<Expense>> findAll(Database db) async {
    final expenseRecords = await db.query(tableName);

    final List<Expense> expenses = [];

    for (var element in expenseRecords) {
      final expense = ModelUtils.mapToExpense(element);

      expenses.add(expense);
    }

    return expenses;
  }

  @override
  Future<void> delete(Database db, int id) {
    return db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<Expense?> findById(Database db, int id) async {
    final result = await db.query(tableName, where: 'id = ?', whereArgs: [id]);

    if (result.isEmpty) {
      return null;
    }

    final expenseRaw = result.first;

    final expense = ModelUtils.mapToExpense(expenseRaw);

    return expense;
  }

  @override
  Future<List<Expense>> findMany(Database db) async {
    final result = await db.query(tableName, orderBy: 'date DESC');

    final List<Expense> expenses = [];

    for (var element in result) {
      final expense = ModelUtils.mapToExpense(element);

      expenses.add(expense);
    }

    return expenses;
  }
}
