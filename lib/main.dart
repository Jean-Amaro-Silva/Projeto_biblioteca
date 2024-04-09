import 'package:flutter/material.dart';
import 'package:projeto_biblioteca/view/login.dart';
import 'package:projeto_biblioteca/view/inicio.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Minha biblioteca",
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const Login(),
        '/inicio': (context) => const inicio(),
      },
    );
  }
}
