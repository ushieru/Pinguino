import 'package:flutter/material.dart';
import 'package:pinguino/routes/home/home.dart';

class Connect extends StatelessWidget {
  static const routeName = '/connect';
  const Connect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Form(
          child: Column(children: [
        TextFormField(),
        TextFormField(),
        ElevatedButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, Home.routeName, (route) => false),
            child: const Text('Conectar'))
      ]))
    ]));
  }
}
