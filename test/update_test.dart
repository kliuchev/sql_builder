import 'package:sql_builder/update.dart';
import 'package:sql_builder/where.dart';
import 'package:test/test.dart';

void main() async {
  group('Update', () {
    test('Simple update', () {
      final update = Update(
        table: 'users',
        where: Where('"name" = @name', parameters: {'name': 'John Doe'}),
        values: {'name': 'John Doe', 'age': 30},
      );

      expect(update.query,
          'UPDATE "users" SET "name" = @valuename, "age" = @valueage WHERE "name" = @name');
      expect(update.parameters,
          {'name': 'John Doe', 'valuename': 'John Doe', 'valueage': 30});
    });
  });
}
