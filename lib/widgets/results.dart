import 'package:flutter/material.dart';
import 'package:pinguino/widgets/result_rows.dart';
import 'package:pinguino/widgets/results_headers.dart';

class Results extends StatelessWidget {
  const Results({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      ResultsHeaders(),
      Expanded(child: ResultRows()),
    ]);
  }
}
