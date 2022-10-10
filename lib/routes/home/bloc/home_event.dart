part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class LoadedTables extends HomeEvent {}

class SelectTableEvent extends HomeEvent {
  SelectTableEvent(this.tableName);
  final String tableName;
}

class NewQueryEvent extends HomeEvent {
  NewQueryEvent(this.query);
  final String query;
}
