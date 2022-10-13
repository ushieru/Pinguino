// ignore: depend_on_referenced_packages
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

typedef OnDatabaseOpenFn = Future<void> Function(SQLite);

class SQLite {
  static SQLite? _instance;
  late Database database;

  SQLite._();

  factory SQLite(
      {String route = inMemoryDatabasePath, OnDatabaseOpenFn? onCreate}) {
    if (_instance == null) {
      _instance = SQLite._();
      _instance!
          ._getDatabase(route, onCreate)
          .then((value) => _instance!.database = value);
    }
    return _instance!;
  }

  Future<Database> _getDatabase(route, OnDatabaseOpenFn? callback) async =>
      await databaseFactoryFfi.openDatabase(route,
          options: OpenDatabaseOptions(onOpen: (_) {
        if (callback != null) callback(this);
      }));

  Future<void> closeDatabase() async {
    await _instance?.database.close();
    _instance = null;
  }

  Future<List<Map<String, Object?>>> addForeignKeys(
      String tableName, List<Map<String, Object?>> results) async {
    final checkReferences = "SELECT tbl_name, sql"
        " FROM sqlite_master"
        " WHERE sql LIKE '%REFERENCES%'"
        " AND tbl_name = '$tableName'";
    final resultsFK = await database.rawQuery(checkReferences);
    if (resultsFK.isEmpty) return results;
    final strResult = resultsFK.first.toString();
    final strSubResult =
        strResult.substring(strResult.indexOf('('), strResult.lastIndexOf(')'));
    final arrayResult = strSubResult
        .split(',')
        .where((element) => element.contains('FOREIGN KEY'))
        .map<Map<String, dynamic>>((rawString) {
      final cleanString = rawString
          .replaceAll('FOREIGN KEY(', '')
          .replaceAll('(', '')
          .replaceAll(')', '')
          .split('REFERENCES');
      final tableAndId = cleanString[1].trim().split(' ');
      final table = tableAndId[0].trim();
      final fk = tableAndId[1].trim();
      final target = cleanString[0].trim();
      return {'target': target, 'query': 'SELECT * FROM $table WHERE $fk = '};
    }).toList();

    final newResults = results.map<Map<String, Object?>>((row) {
      Map<String, Object?> newRow = Map.of(row);
      for (var fk in arrayResult) {
        if (row.containsKey(fk['target'])) {
          final value = row[fk['target']];
          newRow[fk['target']] = {
            'value': value,
            'fk_query': fk['query'] + '"$value"'
          };
        }
      }
      return newRow;
    }).toList();

    return newResults;
  }
}
