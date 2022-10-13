import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinguino/routes/home/bloc/home_bloc.dart';

class SidebarTableButton extends StatelessWidget {
  const SidebarTableButton(this.tableName, {super.key});

  final String tableName;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () =>
            context.read<HomeBloc>().add(SelectTableEvent(tableName)),
        child: Row(children: [
          const Icon(Icons.table_chart_rounded),
          const SizedBox(width: 10),
          Text(tableName)
        ]));
  }
}
