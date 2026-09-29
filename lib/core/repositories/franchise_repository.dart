import 'package:drift/drift.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/daos.dart';

/// Domain-level access to franchises and series.
class FranchiseRepository {
  FranchiseRepository(this._db);

  final AppDatabase _db;

  FranchiseDao get _dao => _db.franchiseDao;

  Stream<List<Franchise>> watchAll() => _dao.watchAll();

  Future<Franchise?> findById(String id) => _dao.findById(id);

  Future<String> create({required String name, String? description}) =>
      _dao.insertFranchise(
        FranchisesCompanion.insert(
          name: name,
          description: Value.absentIfNull(description),
        ),
      );

  Future<void> update(Franchise franchise) =>
      _dao.updateFranchise(franchise.copyWith(updatedAt: DateTime.now()));

  Future<void> delete(String id) => _dao.deleteById(id);
}
