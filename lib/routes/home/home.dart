import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinguino/routes/home/bloc/home_bloc.dart';
import 'package:pinguino/widgets/query_container.dart';
import 'package:pinguino/widgets/results.dart';
import 'package:pinguino/widgets/sidebar.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => HomeBloc(),
        child: Scaffold(
            body: Row(children: [
          const SizedBox(width: 180, child: Sidebar()),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(color: Colors.indigo.shade200, width: 2))),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(children: [
                  QueryContainer(),
                  const SizedBox(height: 20),
                  const Expanded(child: Results())
                ])),
          ))
        ])));
  }
}
