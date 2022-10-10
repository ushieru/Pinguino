import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:pinguino/models/sqlite.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitState()) {
    on<LoadedTables>((event, emit) async {
      final results = await SQLite().database.query('sqlite_schema',
          columns: ['name'],
          where: 'type = ? AND name NOT LIKE ?',
          whereArgs: ['table', 'sqlite_%'],
          orderBy: 'name');
      final tableNames =
          results.map<String>((e) => e['name'] as String).toList();
      emit(NewTablesState(tableNames));
    });

    on<SelectTableEvent>((event, emit) async {
      final sqlite = SQLite();
      final rawResults = await sqlite.database.query(event.tableName);
      final results = await sqlite.addForeignKeys(event.tableName, rawResults);
      emit(NewQueryState('SELECT * FROM ${event.tableName}'));
      emit(NewResultQueryState(results));
    });

    on<NewQueryEvent>((event, emit) async {
      final results = await SQLite().database.rawQuery(event.query);
      emit(NewQueryState(event.query));
      emit(NewResultQueryState(results));
    });

    add(LoadedTables());
  }
}
