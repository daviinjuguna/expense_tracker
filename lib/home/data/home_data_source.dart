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
    // TODO: implement addExpense
    throw UnimplementedError();
  }

  @override
  Future<void> updateExpense(ExpenseModel expense, String userId) async {
    // TODO: implement updateExpense
    throw UnimplementedError();
  }

  @override
  Future<void> deleteExpense(ExpenseModel expense, String userId) async {
    // TODO: implement deleteExpense
    throw UnimplementedError();
  }

  @override
  Stream<FirebaseResponse> getIncomes(
    String userId, {
    int limit = 10,
    DocumentSnapshot? lastDoc,
  }) async* {
    // TODO: implement getIncomes
    throw UnimplementedError();
  }

  @override
  Future<void> addIncome(IncomeModel income, String userId) async {
    // TODO: implement addIncome
    throw UnimplementedError();
  }

  @override
  Future<void> updateIncome(IncomeModel income, String userId) async {
    // TODO: implement updateIncome
    throw UnimplementedError();
  }

  @override
  Future<void> deleteIncome(IncomeModel income, String userId) async {
    // TODO: implement deleteIncome
    throw UnimplementedError();
  }
}
