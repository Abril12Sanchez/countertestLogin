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




// class NuevaPagina extends StatefulWidget {
//   const NuevaPagina({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Nueva pagina'),
//       ),
//       body: Center(
//         child: Column( // Utilizamos un Column para tener múltiples hijos
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//            const Text(
//               'Iniciaste sesion correctamente',
//               style: TextStyle(fontSize: 16), // Ajusta el tamaño del texto según tus necesidades
//             ),
//             const SizedBox(height: 20), // Espacio entre los elementos
//             ElevatedButton(
//               onPressed: () {
//                 // Navegar hacia atrás cuando se presiona el botón de "Volver"
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Regresar'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NuevaPagina extends StatefulWidget {
//   const NuevaPagina({Key? key}) : super(key: key);

//   @override
//   _NuevaPaginaState createState() => _NuevaPaginaState();
// }


