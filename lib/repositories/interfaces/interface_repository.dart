import 'package:sqflite/sqflite.dart';

/* T is id type, E is entity type */
abstract class IRepository<E, T> {
  Future<void> createTable(Database db);

  Future<void> insert(Database db, Map<String, dynamic> data);

  Future<void> delete(Database db, T id);

  Future<List<E>> findAll(Database db);

  Future<List<E>> findMany(Database db);

  Future<E?> findById(Database db, T id);
}
