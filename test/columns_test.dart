import 'package:sql_builder/column.dart';
import 'package:sql_builder/columns.dart';
import 'package:test/test.dart';

void main() {
  group('Columns', () {
    test('Columns with one column', () {
      final query = Columns([
        Column(
          expression: 'id',
          alias: 'user_id',
        ),
      ]);
      expect(query.query, 'id AS "user_id"');
      expect(query.parameters, {});
    });

    test('Columns with two columns', () {
      final query = Columns([
        Column(
          expression: 'id',
          alias: 'user_id',
        ),
        Column(
          expression: 'name',
          alias: 'user_name',
        ),
      ]);
      expect(query.query, 'id AS "user_id", name AS "user_name"');
      expect(query.parameters, {});
    });

    test('Columns with all', () {
      final query = Columns.all();
      expect(query.query, '*');
      expect(query.parameters, {});
    });
  });
}
