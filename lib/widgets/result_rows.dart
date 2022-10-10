import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinguino/routes/home/bloc/home_bloc.dart';

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
                  .map<Widget>((row) => Row(
                          children: row.values.map<Widget>((value) {
                        if (value is Map) {
                          return _ResultRowFK(value);
                        }
                        return _ResultRowSimple(value.toString());
                      }).toList()))
                  .toList());
        });
  }
}

class _ResultRowSimple extends StatelessWidget {
  const _ResultRowSimple(this.value);
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          height: 55,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.indigo.shade200)),
          child: TextField(
              controller: TextEditingController(text: value),
              enabled: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.zero)),
              ))),
    );
  }
}

class _ResultRowFK extends StatelessWidget {
  const _ResultRowFK(this.mapValue);
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
                child: TextField(
                    controller: TextEditingController(text: value),
                    enabled: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.zero)),
                    ))),
            ElevatedButton(
                onPressed: () =>
                    context.read<HomeBloc>().add(NewQueryEvent(query)),
                style: ElevatedButton.styleFrom(fixedSize: const Size(55, 55)),
                child: const Icon(Icons.link))
          ])),
    );
  }
}
