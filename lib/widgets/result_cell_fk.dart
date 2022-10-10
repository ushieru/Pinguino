import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinguino/routes/home/bloc/home_bloc.dart';

class ResultCellFK extends StatelessWidget {
  const ResultCellFK(this.mapValue, {super.key});
  final Map mapValue;

  @override
  Widget build(BuildContext context) {
    final value = mapValue['value'];
    final query = mapValue['fk_query'];
    return Expanded(
      child: Container(
          height: 55,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.indigo.shade200)),
          child: Row(children: [
            Expanded(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    height: 55,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.indigo.shade200)),
                    child: SelectableText(value, textAlign: TextAlign.center))),
            ElevatedButton(
                onPressed: () =>
                    context.read<HomeBloc>().add(NewQueryEvent(query)),
                style: ElevatedButton.styleFrom(fixedSize: const Size(55, 55)),
                child: const Icon(Icons.link))
          ])),
    );
  }
}
