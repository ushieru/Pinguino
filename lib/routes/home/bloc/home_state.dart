part of 'home_bloc.dart';

abstract class HomeState {}

class InitState extends HomeState {
  final List<String> tableNames = [];
  final String currentTableName = '';
  final String query = '';
  final List<Map<String, Object?>> results = [];
}

class NewTablesState extends HomeState {
  NewTablesState(this.newTableNames);
  final List<String> newTableNames;
}

class NewQueryState extends HomeState {
  NewQueryState(this.query);
  final String query;
}

class NewResultQueryState extends HomeState {
  NewResultQueryState(this.results);
  final List<Map<String, Object?>> results;
}
