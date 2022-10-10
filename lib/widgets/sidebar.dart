import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinguino/routes/home/bloc/home_bloc.dart';
import 'package:pinguino/widgets/sidebar_table_button.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(
          padding: EdgeInsets.only(left: 18, top: 5, bottom: 5),
          child: Text('Tables', style: TextStyle(fontWeight: FontWeight.w600))),
      BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) => current is NewTablesState,
          builder: (context, state) {
            if (state is! NewTablesState) {
              return Column(children: const []);
            }
            return Column(
                children: state.newTableNames
                    .map<Widget>((tableName) => SidebarTableButton(tableName))
                    .toList());
          })
    ]);
  }
}
