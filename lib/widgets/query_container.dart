import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:highlight/languages/sql.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:pinguino/routes/home/bloc/home_bloc.dart';

class QueryContainer extends StatelessWidget {
  QueryContainer({super.key});
  final queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        listenWhen: (previous, current) => current is NewQueryState,
        listener: (context, state) =>
            queryController.text = (state as NewQueryState).query,
        buildWhen: (previous, current) => current is NewQueryState,
        builder: (context, state) {
          return Column(children: [
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigo.shade200, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CodeField(
                        controller: CodeController(
                            onChange: (query) => queryController.text = query,
                            text: queryController.text,
                            language: sql,
                            theme: monokaiSublimeTheme)))),
            const SizedBox(height: 10),
            Row(children: [
              ElevatedButton(
                  onPressed: () => context
                      .read<HomeBloc>()
                      .add(NewQueryEvent(queryController.text)),
                  child: const Icon(Icons.play_arrow))
            ])
          ]);
        });
  }
}
