import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinguino/routes/home/bloc/home_bloc.dart';
import 'package:pinguino/widgets/result_row.dart';

class ResultRows extends StatelessWidget {
  const ResultRows({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) => current is NewResultQueryState,
        builder: (context, state) {
          if (state is! NewResultQueryState || state.results.isEmpty) {
            return ListView(children: const []);
          }
          return ListView(
              children: state.results
                  .map<Widget>((row) => ResultRow(row.values))
                  .toList());
        });
  }
}
