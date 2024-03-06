import 'package:sql_builder/delete.dart';
import 'package:sql_builder/where.dart';
import 'package:test/test.dart';

void main() {
  group('Delete', () {
    test('Simple delete', () {
      final delete = Delete(
        table: 'users',
        where: Where('"name" = @name', parameters: {'name': 'John Doe'}),
      );

      expect(delete.query, 'DELETE FROM "users" WHERE "name" = @name');
      expect(delete.parameters, {'name': 'John Doe'});
    });
  });
}
