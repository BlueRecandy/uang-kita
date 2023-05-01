import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uang_kita/models/expense_model.dart';

import 'package:uang_kita/repositories/expense_repository.dart';
import '../repositories/interfaces/interface_repository.dart';

class SQLite {
  late Database connection;

  late final IRepository<Expense, int> expensesRepository;

  SQLite() {
    expensesRepository = ExpenseRepository();
    if (kDebugMode) {
      print('Initializing...');
    }
  }

  Future<void> connect() async {
    connection = await openDatabase('database.db', version: 1,
        onCreate: (db, version) async {
      await expensesRepository.createTable(db);
    });
  }
}
