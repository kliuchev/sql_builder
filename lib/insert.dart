import 'package:sql_builder/query.dart';

class Insert extends Query {
  const Insert({
    required this.table,
    required this.columns,
    required this.values,
  });

  Insert.fromList({
    required this.table,
    required this.columns,
    required List<List<dynamic>> values,
  }) : values = values.indexed
            .map(
              (e) => InsertValue(
                columns: columns,
                values: e.$2,
                prefix: e.$1.toString(),
              ),
            )
            .toList();

  final String table;
  final List<String> columns;
  final List<InsertValue> values;

  @override
  String get query =>
      'INSERT INTO "$table" (${columns.map((e) => '"$e"').join(', ')}) VALUES ${values.map((e) => '(${e.query})').join(', ')}';

  @override
  Map<String, dynamic> get parameters => {
        for (var i = 0; i < values.length; i++) ...values[i].parameters,
      };
}

class InsertValue extends Query {
  const InsertValue({
    required this.columns,
    required this.values,
    this.prefix,
  });

  final String? prefix;
  final List<dynamic> values;
  final List<String> columns;

  @override
  Map<String, dynamic> get parameters {
    final parameters = <String, dynamic>{};

    for (var i = 0; i < values.length; i++) {
      final value = values[i];
      final column = columns[i];
      final key = prefix != null ? '$prefix$column' : column;
      parameters[key] = value;
    }

    return parameters;
  }

  @override
  String get query => parameters.keys.map((e) => "@$e").join(', ');
}
