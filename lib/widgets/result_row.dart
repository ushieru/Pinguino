import 'package:flutter/material.dart';
import 'package:pinguino/widgets/result_cell_fk.dart';
import 'package:pinguino/widgets/result_cell_simple.dart';

class ResultRow extends StatelessWidget {
  const ResultRow(this.resultRow, {super.key});
  final Iterable<dynamic> resultRow;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: resultRow.map<Widget>((value) {
      if (value is Map) return ResultCellFK(value);
      return ResultCellSimple(value.toString());
    }).toList());
  }
}
