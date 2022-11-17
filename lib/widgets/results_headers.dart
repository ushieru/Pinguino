import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinguino/routes/home/bloc/home_bloc.dart';

class ResultsHeaders extends StatelessWidget {
  const ResultsHeaders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => current is NewTablesHeadersState,
        builder: (context, state) {
          if (state is! NewTablesHeadersState ||
              state.newTableHeaders.isEmpty) {
            return Row(children: const []);
          }
          return Row(
              children: state.newTableHeaders
                  .map<Widget>((rowName) => Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(3),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.indigo.shade200,
                              border:
                                  Border.all(color: Colors.indigo, width: 2)),
                          child: Text(rowName.name,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)))))
                  .toList());
        });
  }
}
