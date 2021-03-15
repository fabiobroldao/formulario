import 'package:flutter/material.dart';
import 'package:formulario/pages/formulario.page.dart';
import 'package:formulario/pages/lista.page.dart';
import 'package:formulario/pages/login.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => Login(),
        '/lista': (_) => Lista(),
        '/formulario': (_) => Formulario(),
      },
      onGenerateRoute: (settings) {},
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => Login());
      },
    );
  }
}
