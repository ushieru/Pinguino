// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:pinguino/models/sqlite.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitState()) {
    on<LoadedTables>((event, emit) async {
      final results = await SQLite().database.query('sqlite_master',
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
      final headers = (await sqlite.database
              .rawQuery('PRAGMA table_info(${event.tableName})'))
          .map<Map<String, String>>((row) =>
              {'name': row['name'] as String, 'type': row['type'] as String})
          .toList();
      final results = await sqlite.addForeignKeys(event.tableName, rawResults);
      emit(NewTablesHeadersState(headers));
      emit(NewQueryState('SELECT * FROM ${event.tableName}'));
      emit(NewResultQueryState(results));
    });

    on<NewQueryEvent>((event, emit) async {
      final results = await SQLite().database.rawQuery(event.query);
      isNewTable(event.query);
      emit(NewQueryState(event.query));
      emit(NewResultQueryState(results));
    });

    add(LoadedTables());
  }

  isNewTable(String query) {
    if (query.toLowerCase().contains('create table')) {
      add(LoadedTables());
    }
  }
}
