import 'package:sql_builder/columns.dart';
import 'package:sql_builder/order.dart';
import 'package:sql_builder/query.dart';
import 'package:sql_builder/where.dart';

class Select extends Query {
  const Select({
    required this.table,
    this.where,
    this.columns = const Columns.all(),
    this.limit,
    this.offset,
    this.order,
  });

  final String table;
  final Where? where;
  final Columns columns;
  final int? limit;
  final int? offset;
  final Order? order;

  @override
  String get query {
    final buffer = StringBuffer('SELECT ${columns.query} FROM "$table"');

    if (!(where?.isEmpty ?? true)) {
      buffer.write(' WHERE ${where!.query}');
    }

    if (order != null) {
      buffer.write(' ORDER BY ${order!.query}');
    }

    if (limit != null) {
      buffer.write(' LIMIT $limit');
    }
    if (offset != null) {
      buffer.write(' OFFSET $offset');
    }

    return buffer.toString();
  }

  @override
  Map<String, dynamic> get parameters => {
        if (where != null) ...where!.parameters,
        ...columns.parameters,
      };
}
