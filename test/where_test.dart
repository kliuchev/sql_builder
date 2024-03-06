import 'package:sql_builder/sql_builder.dart';
import 'package:test/test.dart';

void main() {
  group('Where', () {
    test('Where with one condition', () {
      final query = Where('id = @id', parameters: {"id": 1});
      expect(query.query, 'id = @id');
      expect(query.parameters, {'id': 1});
    });

    test('Where with AND', () {
      final query = Where.and(
        [
          Where('id = @id', parameters: {"id": 1}),
          Where('name = @name', parameters: {"name": 'John'}),
        ],
      );

      expect(query.query, '(id = @id) AND (name = @name)');
      expect(query.parameters, {'id': 1, 'name': 'John'});
    });

    test('Where with OR', () {
      final query = Where.or(
        [
          Where('id = @id', parameters: {"id": 1}),
          Where('name = @name', parameters: {"name": 'John'}),
        ],
      );

      expect(query.query, '(id = @id) OR (name = @name)');

      expect(query.parameters, {'id': 1, 'name': 'John'});
    });

    test('Where with AND and OR', () {
      final query = Where.and(
        [
          Where(
            'id = @id',
            parameters: {"id": 1},
          ),
          Where.or(
            [
              Where('name = @name', parameters: {"name": 'John'}),
              Where('name = @name', parameters: {"name": 'Doe'}),
            ],
          ),
        ],
      );

      expect(query.query, '(id = @id) AND ((name = @name) OR (name = @name))');
      expect(query.parameters, {'id': 1, 'name': 'Doe'});
    });
  });
}
