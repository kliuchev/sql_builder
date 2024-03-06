// DELETE FROM table_name
// WHERE condition;

import 'package:sql_builder/query.dart';
import 'package:sql_builder/where.dart';

class Delete extends Query {
  const Delete({
    required this.table,
    required this.where,
  });

  final String table;
  final Where where;

  @override
  Map<String, dynamic> get parameters => where.parameters;

  @override
  String get query => 'DELETE FROM "$table" WHERE ${where.query}';
}
