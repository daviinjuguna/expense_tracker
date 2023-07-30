import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/home/home.dart';
import 'package:injectable/injectable.dart';

abstract class HomeDataSource {
  Stream<List<ExpenseModel>> getExpenses(String userId);
  Future<void> addExpense(ExpenseModel expense, String userId);
  Future<void> updateExpense(ExpenseModel expense, String userId);
  Future<void> deleteExpense(ExpenseModel expense, String userId);

  Stream<List<IncomeModel>> getIncomes(String userId);
  Future<void> addIncome(IncomeModel income, String userId);
  Future<void> updateIncome(IncomeModel income, String userId);
  Future<void> deleteIncome(IncomeModel income, String userId);
}

@LazySingleton(as: HomeDataSource)
class HomeDataSourceImpl implements HomeDataSource {
  final FirebaseFirestore _firestore;

  HomeDataSourceImpl(this._firestore);
  @override
  Stream<List<ExpenseModel>> getExpenses(String userId) {
    // TODO: implement getExpenses
    throw UnimplementedError();
  }

  @override
  Future<void> addExpense(ExpenseModel expense, String userId) {
    // TODO: implement addExpense
    throw UnimplementedError();
  }

  @override
  Future<void> updateExpense(ExpenseModel expense, String userId) {
    // TODO: implement updateExpense
    throw UnimplementedError();
  }

  @override
  Future<void> deleteExpense(ExpenseModel expense, String userId) {
    // TODO: implement deleteExpense
    throw UnimplementedError();
  }

  @override
  Stream<List<IncomeModel>> getIncomes(String userId) {
    // TODO: implement getIncomes
    throw UnimplementedError();
  }

  @override
  Future<void> addIncome(IncomeModel income, String userId) {
    // TODO: implement addIncome
    throw UnimplementedError();
  }

  @override
  Future<void> updateIncome(IncomeModel income, String userId) {
    // TODO: implement updateIncome
    throw UnimplementedError();
  }

  @override
  Future<void> deleteIncome(IncomeModel income, String userId) {
    // TODO: implement deleteIncome
    throw UnimplementedError();
  }
}
