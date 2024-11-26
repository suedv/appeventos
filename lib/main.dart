import 'package:flutter/material.dart';
import 'screens/evento_screen.dart'; // Importar a nova tela

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EventoScreen(), // Define a tela inicial como a nova tela
    );
  }
}
