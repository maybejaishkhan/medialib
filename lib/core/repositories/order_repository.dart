import 'package:drift/drift.dart';

import 'package:medialib/core/database/app_database.dart';
import 'package:medialib/core/database/daos.dart';

/// A single step to store in a watching/reading order.
class OrderStepDraft {
  const OrderStepDraft({required this.title, this.note, this.mediaItemId});

  final String title;
  final String? note;
  final String? mediaItemId;
}

/// Domain-level access to watching/reading orders and their steps.
class OrderRepository {
  OrderRepository(this._db);

  final AppDatabase _db;

  WatchOrderDao get _dao => _db.watchOrderDao;

  Stream<List<WatchOrder>> watchAll() => _dao.watchAll();

  Stream<List<WatchOrder>> watchForFranchise(String franchiseId) =>
      _dao.watchForFranchise(franchiseId);

  Future<WatchOrder?> findById(String id) => _dao.findById(id);

  Stream<List<WatchOrderStep>> watchSteps(String orderId) =>
      _dao.watchStepsFor(orderId);

  Future<List<WatchOrderStep>> steps(String orderId) => _dao.stepsFor(orderId);

  Future<String> create({
    required String name,
    String? description,
    String? author,
    String? franchiseId,
    bool isUserCreated = false,
  }) => _dao.insertOrder(
    WatchOrdersCompanion.insert(
      name: name,
      description: Value.absentIfNull(description),
      author: Value.absentIfNull(author),
      franchiseId: Value.absentIfNull(franchiseId),
      isUserCreated: Value(isUserCreated),
    ),
  );

  Future<void> update(WatchOrder order) =>
      _dao.updateOrder(order.copyWith(updatedAt: DateTime.now()));

  /// Replaces the ordered steps of [orderId] with [drafts].
  Future<void> setSteps(String orderId, List<OrderStepDraft> drafts) =>
      _dao.replaceSteps(orderId, [
        for (final (index, draft) in drafts.indexed)
          WatchOrderStepsCompanion.insert(
            orderId: orderId,
            position: index,
            title: draft.title,
            note: Value.absentIfNull(draft.note),
            mediaItemId: Value.absentIfNull(draft.mediaItemId),
          ),
      ]);

  Future<void> delete(String id) => _dao.deleteOrder(id);
}
