import 'package:sqflite/sqflite.dart';
import 'package:uang_kita/models/bill_model.dart';

abstract class IBillRepository {
  Future<void> createTable(Database db);

  Future<void> delete(Database db, int id);

  Future<List<Bill>> findAll(Database db);

  Future<void> insert(Database db, Map<String, dynamic> data);

  Future<void> update(Database db, int id, Map<String, dynamic> data);
}
