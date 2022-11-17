part of 'home_bloc.dart';

abstract class HomeState {}

class InitState extends HomeState {}

class NewTablesState extends HomeState {
  NewTablesState(this.newTableNames);
  final List<String> newTableNames;
}

class NewTablesHeadersState extends HomeState {
  NewTablesHeadersState(this.newTableHeaders);
  final List<QueryHeaders> newTableHeaders;
}

class NewQueryState extends HomeState {
  NewQueryState(this.query);
  final String query;
}

class NewResultQueryState extends HomeState {
  NewResultQueryState(this.results);
  final List<Map<String, Object?>> results;
}
