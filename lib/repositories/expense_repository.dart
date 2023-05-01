import 'package:sqflite/sqflite.dart';
import 'package:uang_kita/models/category_type_model.dart';
import 'package:uang_kita/models/expense_model.dart';
import 'package:uang_kita/repositories/interfaces/interface_repository.dart';

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

    return expenseRecords.map((record) {
      return Expense(
          id: record['id'] as int,
          title: record['title'] as String,
          amount: record['amount'] as int,
          date: DateTime.parse(record['date'] as String),
          category: categoryTypeMap[record['category'] as String]!);
    }).toList();
  }

  @override
  Future<void> delete(Database db, int id) {
    return db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
