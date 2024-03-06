import 'package:sql_builder/query.dart';

class Order extends Query {
  const Order(this.by, {this.ascending = true});

  final String by;
  final bool ascending;

  @override
  Map<String, dynamic> get parameters => {};

  @override
  String get query => '"$by" ${ascending ? 'ASC' : 'DESC'}';
}
