import 'package:sql_builder/sql_builder.dart';
import 'package:test/test.dart';

void main() {
  /// Test the Select query
  group('Select', () {
    test('Select all', () {
      final query = Select(table: 'users');
      expect(query.query, 'SELECT * FROM "users"');
      expect(query.parameters, {});
    });

    test('Select with columns', () {
      final query = Select(
        table: 'users',
        columns: Columns([
          Column.named('id'),
          Column.named('name'),
        ]),
      );
      expect(query.query, 'SELECT "id", "name" FROM "users"');
      expect(query.parameters, {});
    });

    test('Select with where', () {
      final query = Select(
        table: 'users',
        where: Where(
          'id = @id',
          parameters: {"id": 1},
        ),
      );
      expect(query.query, 'SELECT * FROM "users" WHERE id = @id');
      expect(query.parameters, {'id': 1});
    });

    test('Select with limit', () {
      final query = Select(
        table: 'users',
        limit: 10,
      );
      expect(query.query, 'SELECT * FROM "users" LIMIT 10');
      expect(query.parameters, {});
    });

    test('Select with offset', () {
      final query = Select(
        table: 'users',
        offset: 10,
      );
      expect(query.query, 'SELECT * FROM "users" OFFSET 10');
      expect(query.parameters, {});
    });

    test('Select with limit and offset', () {
      final query = Select(
        table: 'users',
        limit: 10,
        offset: 10,
      );
      expect(query.query, 'SELECT * FROM "users" LIMIT 10 OFFSET 10');
      expect(query.parameters, {});
    });
  });
}
