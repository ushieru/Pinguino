import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinguino/routes/home/bloc/home_bloc.dart';

class QueryContainer extends StatelessWidget {
  QueryContainer({super.key});
  final queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
        listenWhen: (previous, current) => current is NewQueryState,
        listener: (context, state) =>
            queryController.text = (state as NewQueryState).query,
        child: Column(children: [
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.indigo.shade200, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(controller: queryController, maxLines: 5))),
          const SizedBox(height: 10),
          Row(children: [
            ElevatedButton(
                onPressed: () => context
                    .read<HomeBloc>()
                    .add(NewQueryEvent(queryController.text)),
                child: const Icon(Icons.play_arrow))
          ])
        ]));
  }
}
