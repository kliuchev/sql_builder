import 'package:sql_builder/column.dart';
import 'package:test/test.dart';

void main() {
  group('Column', () {
    test('Column with expression and alias', () {
      final query = Column(
        expression: 'id',
        alias: 'user_id',
      );
      expect(query.query, 'id AS "user_id"');
      expect(query.parameters, {});
    });

    test('Column with expression', () {
      final query = Column.named('id');
      expect(query.query, '"id"');
      expect(query.parameters, {});
    });

    test('Column with all', () {
      final query = Column.all();
      expect(query.query, '*');
      expect(query.parameters, {});
    });
  });
}
