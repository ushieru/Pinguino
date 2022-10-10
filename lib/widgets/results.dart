import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinguino/routes/home/bloc/home_bloc.dart';
import 'package:pinguino/widgets/result_rows.dart';
import 'package:pinguino/widgets/results_headers.dart';

class Results extends StatelessWidget {
  const Results({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      ResultsHeaders(),
      Expanded(child: ResultRows()),
    ]);
  }
}
