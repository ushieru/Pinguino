import 'package:pinguino/routes/home/home.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/material.dart';
import 'package:pinguino/routes/connect.dart';

void main() {
  sqfliteFfiInit();
  runApp(const Pinguino());
}

class Pinguino extends StatelessWidget {
  const Pinguino({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.indigo),
        title: 'Pingüino',
        initialRoute: Connect.routeName,
        routes: {
          Connect.routeName: (context) => const Connect(),
          Home.routeName: (context) => const Home(),
        });
  }
}
