import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/home/home.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

abstract class HomeDataSource {
  Stream<FirebaseResponse> getExpenses(
    String userId, {
    int limit = 10,
    DocumentSnapshot? lastDoc,
  });
  Future<void> addExpense(ExpenseModel expense, String userId);
  Future<void> updateExpense(ExpenseModel expense, String userId);
  Future<void> deleteExpense(ExpenseModel expense, String userId);

  Stream<FirebaseResponse> getIncomes(
    String userId, {
    int limit = 10,
    DocumentSnapshot? lastDoc,
  });
  Future<void> addIncome(IncomeModel income, String userId);
  Future<void> updateIncome(IncomeModel income, String userId);
  Future<void> deleteIncome(IncomeModel income, String userId);
}

@LazySingleton(as: HomeDataSource)
class HomeDataSourceImpl implements HomeDataSource {
  final FirebaseFirestore _firestore;

  HomeDataSourceImpl(this._firestore);
  @override
  Stream<FirebaseResponse> getExpenses(
    String userId, {
    int limit = 10,
    DocumentSnapshot? lastDoc,
  }) async* {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;

    final query = await _firestore
        .collection('expenses')
        .doc(userId)
        .collection('expenses')
        .limit(limit);

    if (lastDoc != null) {
      snapshot = query.startAfterDocument(lastDoc).snapshots();
    } else {
      snapshot = query.snapshots();
    }

    yield* snapshot
        .map((event) => FirebaseResponse.success(event.docs))
        .onErrorReturnWith((error, stackTrace) {
      return FirebaseResponse.error('fetch-error');
    });
  }

  @override
  Future<void> addExpense(ExpenseModel expense, String userId) async {
    try {
      await _firestore
          .collection('expenses')
          .doc(userId)
          .collection('expenses')
          .add(expense.toJson());
    } catch (e, s) {
      log("add", error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> updateExpense(ExpenseModel expense, String userId) async {
    try {
      await _firestore
          .collection('expenses')
          .doc(userId)
          .collection('expenses')
          .doc(expense.uid)
          .update(expense.toJson());
    } catch (e, s) {
      log("add", error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> deleteExpense(ExpenseModel expense, String userId) async {
    try {
      await _firestore
          .collection('expenses')
          .doc(userId)
          .collection('expenses')
          .doc(expense.uid)
          .delete();
    } catch (e, s) {
      log("add", error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Stream<FirebaseResponse> getIncomes(
    String userId, {
    int limit = 10,
    DocumentSnapshot? lastDoc,
  }) async* {
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;

    final query = await _firestore
        .collection('income')
        .doc(userId)
        .collection('income')
        .limit(limit);

    if (lastDoc != null) {
      snapshot = query.startAfterDocument(lastDoc).snapshots();
    } else {
      snapshot = query.snapshots();
    }

    yield* snapshot
        .map((event) => FirebaseResponse.success(event.docs))
        .onErrorReturnWith((error, stackTrace) {
      return FirebaseResponse.error('fetch-error');
    });
  }

  @override
  Future<void> addIncome(IncomeModel income, String userId) async {
    try {
      await _firestore
          .collection('income')
          .doc(userId)
          .collection('income')
          .add(income.toJson());
    } catch (e, s) {
      log("add", error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> updateIncome(IncomeModel income, String userId) async {
    try {
      await _firestore
          .collection('income')
          .doc(userId)
          .collection('income')
          .doc(income.uid)
          .update(income.toJson());
    } catch (e, s) {
      log("add", error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  Future<void> deleteIncome(IncomeModel income, String userId) async {
    try {
      await _firestore
          .collection('income')
          .doc(userId)
          .collection('income')
          .doc(income.uid)
          .delete();
    } catch (e, s) {
      log("add", error: e, stackTrace: s);
      rethrow;
    }
  }
}
