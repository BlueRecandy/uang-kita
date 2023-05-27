import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uang_kita/models/bill_model.dart';
import 'package:uang_kita/repositories/bill_repository.dart';
import 'package:uang_kita/repositories/interfaces/interface_expense_repository.dart';

import '../repositories/expense_repository.dart';
import '../repositories/interfaces/interface_repository.dart';

class SQLite {
  static final SQLite _instance = SQLite._internal();

  factory SQLite() => _instance;

  static Database? _database;

  // Repositories
  late IExpenseRepository expenseRepository;
  late IRepository<Bill, int> billRepository;

  SQLite._internal() {
    if (kDebugMode) {
      print('Initializing SQLite...');
    }

    _initRepositories();
    _connect();
  }

  static SQLite getInstance() {
    return _instance;
  }

  void _initRepositories() {
    expenseRepository = ExpenseRepository();
    billRepository = BillRepository();
  }

  Future<Database> _connect() async {
    final path = join(await getDatabasesPath(), 'uang_kita.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // create tables here
        await expenseRepository.createTable(db);
        await billRepository.createTable(db);

        if (kDebugMode) {
          print('Tables created');
        }
      },
    );

    if (kDebugMode) {
      print('Database connected');
    }

    return _database!;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    return await _connect();
  }
}
