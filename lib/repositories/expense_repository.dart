import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uang_kita/models/category_type_model.dart';
import 'package:uang_kita/models/expense_model.dart';
import 'package:uang_kita/repositories/interfaces/interface_expense_repository.dart';
import 'package:uang_kita/utils/model_utils.dart';

class ExpenseRepository implements IExpenseRepository {
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
  Future<void> insert(Database db, Map<String, dynamic> data) async {
    // validate data
    if (data['title'] == null ||
        data['category'] == null ||
        data['amount'] == null) {
      throw Exception('Field title, category, dan amount kosong');
    }

    if (data['date'] == null) {
      data['date'] = DateTime.now();
    }

    final date = data['date'] as DateTime;

    data['date'] = date.toIso8601String();
    final category = data['category'] as CategoryType;

    data['category'] = category.name;

    await db.insert(tableName, data);
  }

  @override
  Future<List<Expense>> findAll(Database db,
      {bool isDescendingDate = true}) async {
    final expenseRecords = await db.query(tableName,
        orderBy: isDescendingDate ? 'date DESC' : 'date ASC');

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
  Future<Expense> findEarliest(Database db) async {
    final result = await db.query(tableName, orderBy: 'date ASC', limit: 1);

    if (result.isEmpty) {
      throw Exception('Data tidak ditemukan');
    }

    return ModelUtils.mapToExpense(result.first);
  }

  @override
  Future<Expense> findLatest(Database db) async {
    final result = await db.query(tableName, orderBy: 'date DESC', limit: 1);

    if (result.isEmpty) {
      throw Exception('Data tidak ditemukan');
    }

    return ModelUtils.mapToExpense(result.first);
  }

  @override
  Future<List<Expense>> findInDateRange(Database db, DateTimeRange dateRange,
      {int limit = 60, bool isDescendingDate = true}) {
    final startDate = dateRange.start.toIso8601String();
    final endDate = dateRange.end.toIso8601String();

    return db
        .query(tableName,
            where: 'date BETWEEN ? AND ?',
            whereArgs: [startDate, endDate],
            orderBy: isDescendingDate ? 'date DESC' : 'date ASC',
            limit: limit)
        .then((value) {
      final List<Expense> expenses = [];

      for (var element in value) {
        final expense = ModelUtils.mapToExpense(element);

        expenses.add(expense);
      }

      return expenses;
    });
  }
}
