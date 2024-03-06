import 'package:sql_builder/query.dart';

class Column extends Query {
  const Column({
    required this.expression,
    this.alias,
    this.wrappedAlias = true,
  });

  const Column.named(String name)
      : expression = name,
        alias = null,
        wrappedAlias = true;

  const Column.all()
      : expression = '*',
        alias = null,
        wrappedAlias = false;

  final String expression;
  final String? alias;
  final bool wrappedAlias;

  @override
  Map<String, dynamic> get parameters => {};

  @override
  String get query {
    if (alias != null) {
      return '$expression AS ${wrappedAlias ? '"$alias"' : alias}';
    }
    return wrappedAlias ? '"$expression"' : expression;
  }
}
