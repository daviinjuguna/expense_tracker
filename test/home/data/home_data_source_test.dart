import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/home/home.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore mockFirebaseFirestore;

  final ExpenseModel expesne = ExpenseModel(
    uid: 'expenseId',
    title: 'Test Expense',
    amount: 100,
    date: DateTime(2021, 07, 30, 12, 34, 56),
  );

  late HomeDataSource source;
  setUp(() async {
    mockFirebaseFirestore = FakeFirebaseFirestore();
    source = HomeDataSourceImpl(mockFirebaseFirestore);
  });

  group('StreamExpense', () {
    test('Will return FirebaseResponse when successfull, when last doc is null',
        () async {
      await mockFirebaseFirestore
          .collection('expense')
          .doc('userId')
          .collection('expense')
          .doc('expenseId')
          .set(expesne.toJson());
      final matcher = mockFirebaseFirestore
          .collection("user")
          .doc("userId")
          .collection("expense")
          .limit(10)
          .snapshots()
          .map((event) => FirebaseResponse.success(event.docs));

      expect(source.getExpenses('userId'), emitsInOrder([matcher]));
    });
  });
}
