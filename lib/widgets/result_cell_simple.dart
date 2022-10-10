import 'package:flutter/material.dart';

class ResultCellSimple extends StatelessWidget {
  const ResultCellSimple(this.value, {super.key});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            height: 55,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.indigo.shade200)),
            child: SelectableText(value, textAlign: TextAlign.center)));
  }
}
