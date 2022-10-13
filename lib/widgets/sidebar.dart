import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinguino/models/sqlite.dart';
import 'package:pinguino/routes/connect.dart';
import 'package:pinguino/routes/home/bloc/home_bloc.dart';
import 'package:pinguino/widgets/sidebar_table_button.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: double.maxFinite,
          decoration: const BoxDecoration(color: Colors.indigo),
          child: Text('Tables',
              style: TextStyle(
                  color: Colors.grey.shade200,
                  fontWeight: FontWeight.w600,
                  fontSize: 18))),
      const SizedBox(height: 10),
      Expanded(
          child: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) => current is NewTablesState,
              builder: (context, state) {
                if (state is! NewTablesState) {
                  return Column(children: const []);
                }
                return ListView(
                    children: state.newTableNames
                        .map<Widget>(
                            (tableName) => SidebarTableButton(tableName))
                        .toList());
              })),
      TextButton(
          onPressed: () {
            SQLite().closeDatabase().then((_) =>
                Navigator.pushNamedAndRemoveUntil(
                    context, Connect.routeName, (route) => false));
          },
          child: Row(children: const [
            Icon(Icons.exit_to_app),
            SizedBox(width: 10),
            Text('Close Database')
          ])),
      const SizedBox(height: 10)
    ]);
  }
}
