import 'package:sql_builder/insert.dart';
import 'package:test/test.dart';

void main() {
  group('Insert', () {
    test('Simple insert', () {
      final columns = ['name', 'age'];
      final insert = Insert(
        table: 'users',
        columns: columns,
        values: [
          InsertValue(prefix: "0", columns: columns, values: ['John Doe', 30]),
          InsertValue(prefix: "1", columns: columns, values: ['Jane Doe', 29]),
        ],
      );

      expect(
        insert.query,
        'INSERT INTO "users" ("name", "age") VALUES (@0name, @0age), (@1name, @1age)',
      );

      expect(
        insert.parameters,
        {
          '0name': 'John Doe',
          '0age': 30,
          '1name': 'Jane Doe',
          '1age': 29,
        },
      );
    });

    test('Insert from list', () {
      final columns = ['name', 'age'];
      final insert = Insert.fromList(
        table: 'users',
        columns: columns,
        values: [
          ['John Doe', 30],
          ['Jane Doe', 29],
        ],
      );

      expect(
        insert.query,
        'INSERT INTO "users" ("name", "age") VALUES (@0name, @0age), (@1name, @1age)',
      );

      expect(
        insert.parameters,
        {
          '0name': 'John Doe',
          '0age': 30,
          '1name': 'Jane Doe',
          '1age': 29,
        },
      );
    });
  });

  group('InsertValue', () {
    test('Simple insert value', () {
      final columns = ['name', 'age'];
      final insertValue = InsertValue(
        columns: columns,
        values: ['John Doe', 30],
      );

      expect(
        insertValue.query,
        '@name, @age',
      );

      expect(
        insertValue.parameters,
        {
          'name': 'John Doe',
          'age': 30,
        },
      );
    });

    test('Insert value with prefix', () {
      final columns = ['name', 'age'];
      final insertValue = InsertValue(
        prefix: "0",
        columns: columns,
        values: ['John Doe', 30],
      );

      expect(
        insertValue.query,
        '@0name, @0age',
      );

      expect(
        insertValue.parameters,
        {
          '0name': 'John Doe',
          '0age': 30,
        },
      );
    });
  });
}
