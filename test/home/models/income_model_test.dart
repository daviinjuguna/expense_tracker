import 'package:expense_tracker/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Income model', () {
    test(
      "Can be created",
      () {
        expect(
          IncomeModel(
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
      final incomeOne = IncomeModel(
        uid: 'uid',
        title: 'title',
        amount: 200.2,
        date: DateTime(2021, 07, 30, 12, 34, 56),
      );

      final incomeTwo = IncomeModel(
        uid: 'uid',
        title: 'title',
        amount: 200.2,
        date: DateTime(2021, 07, 30, 12, 34, 56),
      );

      expect(incomeOne, incomeTwo);
    });

    test('fromJson() should correctly deserialize the JSON', () {
      final json = {
        'uid': 'user123',
        'title': 'Salary',
        'description': 'Monthly income',
        'amount': 2500.0,
        'date': '2023-07-30T12:34:56Z',
      };
      final incomeModel = IncomeModel.fromJson(json);

      expect(incomeModel.uid, 'user123');
      expect(incomeModel.title, 'Salary');
      expect(incomeModel.description, 'Monthly income');
      expect(incomeModel.amount, 2500.0);
      expect(incomeModel.date, DateTime.utc(2023, 07, 30, 12, 34, 56));
    });

    test('toJson() should correctly serialize the object to JSON', () {
      final incomeModel = IncomeModel(
        uid: 'user456',
        title: 'Bonus',
        description: 'Year-end bonus',
        amount: 1500.0,
        date: DateTime.utc(2023, 12, 31, 23, 59, 59),
      );

      final json = incomeModel.toJson();

      expect(json['uid'], 'user456');
      expect(json['title'], 'Bonus');
      expect(json['description'], 'Year-end bonus');
      expect(json['amount'], 1500.0);
      expect(json['date'], '2023-12-31T23:59:59.000Z');
    });
  });
}
