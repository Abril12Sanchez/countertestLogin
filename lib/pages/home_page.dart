import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Programacion
  int cont = 0;

  // Diseño
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contadorsito🎀'),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shadowColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Número de clicks',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            Text("$cont", style: const TextStyle(fontSize: 25)),

            // Botones

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        cont++;
                      });
                    },
                    // style: ElevatedButton.styleFrom(primary: Colors.tealAccent),
                    child: const Text(
                      'Incrementar +',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                const SizedBox(width: 25),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        cont--;
                        if (cont < 0) {
                          cont = 0;
                        }
                      });
                    },
                    // style: ElevatedButton.styleFrom(primary: Colors.pink),
                    child: const Text(
                      'Decrementar -',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )),
                const SizedBox(width: 25),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      cont = 0;
                    });
                  },
                  // style: ElevatedButton.styleFrom(primary: Colors.purpleAccent),
                  child: const Text('Reiniciar ↻',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}