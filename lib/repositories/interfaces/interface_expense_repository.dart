import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uang_kita/models/expense_model.dart';

abstract class IExpenseRepository {
  Future<void> createTable(Database db);

  Future<void> insert(Database db, Map<String, dynamic> data);

  Future<void> delete(Database db, int id);

  Future<List<Expense>> findAll(Database db, {bool isDescendingDate});

  Future<List<Expense>> findInDateRange(Database db, DateTimeRange dateRange,
      {int limit, bool isDescendingDate});

  Future<Expense> findEarliest(Database db);

  Future<Expense> findLatest(Database db);
}
