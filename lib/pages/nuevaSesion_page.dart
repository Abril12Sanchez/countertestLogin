import 'package:countertest/pages/login_page.dart';
import 'package:flutter/material.dart';
class NuevaPagina extends StatelessWidget {
  const NuevaPagina({Key? key}) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Página'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.of(context).pop(); // Esto cerrará la pantalla actual
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage() ));
          },
        ),
      ),
      body: const Center(
        child: Text('¡Bienvenido a la nueva página!'),
      ),
    );
  }
}



