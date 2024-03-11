//importM
import 'package:countertest/pages/nuevaSesion_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// import com.facebook.FacebookSdk;
// import com.facebook.appevents.AppEventsLogger;

// // ----------
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

// // Para GOOGLE
Future<void> signInWithGoogle(BuildContext context) async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser != null) {
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the credential
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if the user is signed in
      if (userCredential.user != null) {
        // Navigate to another page
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const NuevaPagina()), // Reemplaza 'OtraPagina()' con la página a la que quieres dirigir al usuario
        );
      }
    } catch (e) {
      // Handle any errors that occur during sign in
      print("Error durante el inicio de sesión con Google: $e");
      // Puedes mostrar un mensaje de error al usuario si lo deseas
    }
  } else {
    // El usuario canceló el inicio de sesión con Google
    print("Inicio de sesión con Google cancelado por el usuario");
    // Puedes mostrar un mensaje al usuario si lo deseas
  }
}

// PARA FACEBOOK

Future<void> loginFacebook(context) async {
// void loginFacebook() {
  // Proveedor de inicio - Facebook
  var provider = FacebookAuthProvider();
FirebaseAuth.instance.signInWithPopup(provider).then((result) {
  // Esto te proporciona un token de acceso de Facebook. Puedes usarlo para acceder a la API de Facebook.
  var token = result.credential!.accessToken;
  // La información del usuario que ha iniciado sesión.
  // var user = result.user;

  // Navegación a 'NuevaPagina' después del inicio de sesión exitoso
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const NuevaPagina(), // Asegúrate de que 'NuevaPagina' sea una clase de página válida
  ));

  // Opcional: Actualiza el usuario en tu aplicación
  // updateUser(user!);
}).catchError((error) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const NuevaPagina(), // Asegúrate de que 'NuevaPagina' sea una clase de página válida
  ));
    // Manejar errores aquí
    // var errorCode = error.code;
    // var errorMessage = error.message;
    // // El correo electrónico de la cuenta del usuario utilizado.
    // var email = error.email;
    // // El tipo de firebase.auth.AuthCredential que se usó.
    // var credential = error.credential;
    // // ...

    // print(errorMessage);
  });
}
  	// //iniciar con Google
  	// var loginFacebook = function(){

  	//    //proveedor de inicio - Facebook
    //     var provider = new firebase.auth.FacebookAuthProvider();


  	// 	firebase.auth().signInWithPopup(provider).then(function(result) {
  	// 	  // This gives you a Google Access Token. You can use it to access the Google API.
  	// 	  var token = result.credential.accessToken;
  	// 	  // The signed-in user info.
  	// 	  var user = result.user;

  	// 	  // console.log(user.displayName);
  	// 	  updateUser(user);
  	// 	  // ...
  	// 	}).catch(function(error) {
  	// 	  // Handle Errors here.
  	// 	  var errorCode = error.code;
  	// 	  var errorMessage = error.message;
  	// 	  // The email of the user's account used.
  	// 	  var email = error.email;
  	// 	  // The firebase.auth.AuthCredential type that was used.
  	// 	  var credential = error.credential;
  	// 	  // ...

  	// 	  // console.log(errorMessage);
  	// 	});
  	// }
// FB.getLoginStatus(function(response) {
//     statusChangeCallback(response);
// });


// {
//     status: 'connected',
//     authResponse: {
//         accessToken: '...',
//         expiresIn:'...',
//         signedRequest:'...',
//         userID:'...'
//     }
// }


// Future<void> signInWithFacebook(BuildContext context) async {
//   // Trigger the sign-in flow
//   final LoginResult loginResult = await FacebookAuth.instance.login();

//   // Verifica si el inicio de sesión con Facebook fue exitoso
//   if (loginResult.status == LoginStatus.success) {
//     // Crea una credencial a partir del token de acceso
//     final AccessToken accessToken = loginResult.accessToken!;
//     final OAuthCredential facebookAuthCredential =
//         FacebookAuthProvider.credential(accessToken.token);

//     // Una vez que se haya iniciado sesión correctamente, regresa el UserCredential
//     final UserCredential userCredential = await FirebaseAuth.instance
//         .signInWithCredential(facebookAuthCredential);

//     // Redirige a otra página usando la navegación de Flutter
//     // ignore: use_build_context_synchronously
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//           builder: (context) =>
//               const HomePage()), // Reemplaza 'OtraPagina()' con la página a la que quieres dirigir al usuario
//     ); // Cambia '/otra_pagina' por la ruta de la página a la que deseas redirigir
//   } else {
//     // Si el inicio de sesión no fue exitoso, maneja el error o muestra un mensaje al usuario
//     print('Error al iniciar sesión con Facebook');
//   }
// }

// -------------------------
Future<void> registerWithEmailAndPassword(String email, String password) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      //print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      //print('The account already exists for that email.');
    }
  } catch (e) {
    //print(e);
  }
}

Future<void> signInWithEmailAndPassword(
    String email, String password, BuildContext context) async {
  try {
    // ignore: unused_local_variable
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    // Usuario inició sesión exitosamente, navegar a la página principal
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, '' );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      // print('No se encontró ningún usuario con ese correo electrónico.');
    } else if (e.code == 'wrong-password') {
      // print('Contraseña incorrecta para ese usuario.');
    }
  }
}

// ---------

//stfulW
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Stack(
      children: [
        Fondo(),
        Contenido(),
      ],
    ));
  }
}

//statelessW
class Fondo extends StatelessWidget {
  const Fondo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //min propiedad may widget, los wid aceptan propiedades
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 125, 190, 243),
          Colors.blue,
        ],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
      )),
    );
  }
}

//StatefulW
class Contenido extends StatefulWidget {
  const Contenido({super.key});

  @override
  State<Contenido> createState() => _ContenidoState();
}

class _ContenidoState extends State<Contenido> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Welcome to your count',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 15),
          Datos(),
          SizedBox(
            height: 20,
          ),
          Politica(),
        ],
      ),
    );
  }
}

class Datos extends StatefulWidget {
  const Datos({super.key});

  @override
  State<Datos> createState() => _DatosState();
}

class _DatosState extends State<Datos> {
  bool showPass = true;
  // final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Email',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'micorreo@micorreo.com'),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Password',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: showPass,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.remove_red_eye_outlined),
                  onPressed: () {
                    // setState((){
                    //   showPass == true ? showPass=false: showPass=true;
                    // })
                    setState(() {
                      showPass = !showPass;
                    });
                  },
                )),
          ),
          const Remember(),
          const SizedBox(
            height: 30,
          ),
          const Botones(),
        ],
      ),
    );
  }
}

class Botones extends StatelessWidget {
  // const Botones({super.key});
  const Botones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // boton para logearse
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              signInWithEmailAndPassword(
                      _emailController.text, _passwordController.text, context)
                  .then((user) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Datos incorrectos')),
                );
              }).catchError((error) {
                // Si el inicio de sesión es exitoso, muestra un SnackBar y luego redirige
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Iniciando sesión...')),
                );
                // Utiliza Future.delayed para esperar que el SnackBar se muestre antes de navegar
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NuevaPagina()));
                });

                // Si hay un error, maneja el error aquí
                // print(error);
              });
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff142047)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
          width: double.infinity,
        ),
// Boton para registrarse
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            // onPressed: () {
            //     Navigator.pushNamed(context, '/register');
            //   },

            onPressed: () {
              registerWithEmailAndPassword(
                      _emailController.text, _passwordController.text)
                  .then((user) {
                // Si el inicio de sesión es exitoso, muestra un SnackBar y luego redirige
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Registrado correctamente')),
                );
                // Utiliza Future.delayed para esperar que el SnackBar se muestre antes de navegar
                // Future.delayed(const Duration(seconds: 2), () {
                //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NuevaPagina()));
                // });
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error al registrar')),
                );
                // Si hay un error, maneja el error aquí
                // print(error);
              });
            },

            // onPressed: () async {
            //   registerWithEmailAndPassword(
            //       _emailController.text, _passwordController.text);
            // },

            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff142047)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
            child: const Text(
              'Registro',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
          width: double.infinity,
        ),

        const Text(
          'or sign with',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 25,
          width: double.infinity,
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            // onPressed: () async {
            //   await signInWithGoogle(context);
            // },

            //  onPressed: () => {
            //   _signInWithGoogle
            //   // signInWithGoogle(context)
            //   },
            onPressed: () => {
              signInWithGoogle(context)
            }, //signInWithGoogle(context)
            child: const Text(
              'Google',
              style: TextStyle(
                color: Color(0xff142047),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        //  GestureDetector(
        //         onTap: () {

        //         },
        //           ),
        const SizedBox(
          height: 15,
          width: double.infinity,
        ),

        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            // onPressed: () {
            //   signInWithFacebook(context);
            // },
            onPressed: () async {
                await loginFacebook(context);
              },
            child: const Text(
              'Facebook',
              style: TextStyle(
                color: Color(0xff142047),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),

        const SizedBox(
          height: 15,
          width: double.infinity,
        ),
      ],
    );
  }
}

class Politica extends StatelessWidget {
  const Politica({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Read user'),
        //  const Spacer(),
        TextButton(
          onPressed: () => {},
          child: const Text(
            'Privacy Policy',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

// si va a tener funcionamiento  statefulW

class Remember extends StatefulWidget {
  const Remember({super.key});

  @override
  State<Remember> createState() => _RememberState();
}

class _RememberState extends State<Remember> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: checked,
          onChanged: (value) {
            setState(() {
              checked = value ?? false;
            });
          },
        ),
        const Text('Remember me'),
        const Spacer(),
        TextButton(
          onPressed: () {
            // Navegar a la página de "forgot password"
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ForgotPasswordPage(),
              ),
            );
          },
          child: const Text(
            'Forgot Password?',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}

// Nueva página para "forgot password"
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Center(
        child: Column(
          // Utilizamos un Column para tener múltiples hijos
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pagina para recuperar contraseña',
              style: TextStyle(
                  fontSize:
                      16), // Ajusta el tamaño del texto según tus necesidades
            ),
            const SizedBox(height: 20), // Espacio entre los elementos
            ElevatedButton(
              onPressed: () {
                // Navegar hacia atrás cuando se presiona el botón de "Volver"
                Navigator.of(context).pop();
              },
              child: const Text('Regresar'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Remember Checkbox'),
      ),
      body: const Remember(),
    ),
  ));
}
