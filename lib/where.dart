import 'package:sql_builder/query.dart';

class Where extends Query {
  const Where(
    this.query, {
    this.parameters = const {},
  });

  factory Where.and(List<Where> children) {
    return Where.fromChildren(children: children, operator: 'AND');
  }

  factory Where.or(List<Where> children) {
    return Where.fromChildren(children: children, operator: 'OR');
  }

  factory Where.fromChildren(
      {required List<Where> children, required String operator}) {
    final queries = children.map((e) => '(${e.query})').join(' $operator ');
    final parameters = children.fold<Map<String, dynamic>>(
      <String, dynamic>{},
      (previousValue, element) => {
        ...previousValue,
        ...element.parameters,
      },
    );
    return Where(queries, parameters: parameters);
  }

  @override
  final Map<String, dynamic> parameters;

  @override
  final String query;

  bool get isEmpty => query.isEmpty;
}
