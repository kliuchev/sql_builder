import 'package:sql_builder/column.dart';
import 'package:sql_builder/query.dart';

class Columns extends Query {
  const Columns(this.columns);

  const Columns.all() : columns = const [Column.all()];

  final List<Column> columns;

  @override
  String get query => columns.map((e) => e.query).join(', ');

  @override
  Map<String, dynamic> get parameters => columns.fold<Map<String, dynamic>>(
        <String, dynamic>{},
        (previousValue, element) => {
          ...previousValue,
          ...element.parameters,
        },
      );
}
