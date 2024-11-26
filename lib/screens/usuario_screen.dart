// lib/usuario_screen.dart
import 'package:flutter/material.dart';

class UsuarioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://plus.unsplash.com/premium_photo-1689977968861-9c91dbb16049?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Zm90byUyMGRvJTIwcGVyZmlsfGVufDB8fDB8fHww'), // Substitua pela URL da imagem do perfil
            ),
            SizedBox(height: 16),
            Text(
              'Nome do Usuário',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Email: usuario@example.com'),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Para voltar à tela anterior
              },
              child: Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
