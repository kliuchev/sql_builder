import 'package:sql_builder/query.dart';
import 'package:sql_builder/where.dart';

class Update extends Query {
  const Update({
    required this.table,
    required this.where,
    required this.values,
    this.valueParamsPrefix = 'value',
  });

  final String? valueParamsPrefix;
  final String table;
  final Where where;
  final Map<String, dynamic> values;

  @override
  Map<String, dynamic> get parameters => {
        ...where.parameters,
        for (var entry in values.entries)
          '${valueParamsPrefix ?? ''}${entry.key}': entry.value,
      };

  @override
  String get query =>
      'UPDATE "$table" SET ${values.entries.map((e) => '"${e.key}" = @${valueParamsPrefix ?? ''}${e.key}').join(', ')} WHERE ${where.query}';
}
