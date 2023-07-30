import 'package:expense_tracker/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpenseModel', () {
    test(
      "Can be created",
      () {
        expect(
          ExpenseModel(
            uid: 'uid',
            title: 'title',
            amount: 200.2,
            date: DateTime.now(),
          ),
          isNotNull,
        );
      },
    );

    test('supporst equality', () {
      final incomeOne = ExpenseModel(
        uid: 'uid',
        title: 'title',
        amount: 200.2,
        date: DateTime.now(),
      );

      final incomeTwo = ExpenseModel(
        uid: 'uid',
        title: 'title',
        amount: 200.2,
        date: DateTime.now(),
      );

      expect(incomeOne, incomeTwo);
    });

    test('fromJson() should correctly deserialize the JSON', () {
      final json = {
        'uid': 'user123',
        'title': 'Rent',
        'description': 'Monthly rent',
        'amount': 2500.0,
        'date': '2023-07-30T12:34:56Z',
      };
      final expenseModel = ExpenseModel.fromJson(json);

      expect(expenseModel.uid, 'user123');
      expect(expenseModel.title, 'Rent');
      expect(expenseModel.description, 'Monthly rent');
      expect(expenseModel.amount, 2500.0);
      expect(expenseModel.date, DateTime.utc(2023, 07, 30, 12, 34, 56));
    });

    test('toJson() should correctly serialize the object to JSON', () {
      final expenseModel = ExpenseModel(
        uid: 'user456',
        title: 'shopping',
        description: 'Year-end shopping',
        amount: 1500.0,
        date: DateTime.utc(2023, 12, 31, 23, 59, 59),
      );

      final json = expenseModel.toJson();

      expect(json['uid'], 'user456');
      expect(json['title'], 'shopping');
      expect(json['description'], 'Year-end shopping');
      expect(json['amount'], 1500.0);
      expect(json['date'], '2023-12-31T23:59:59.000Z');
    });
  });
}
