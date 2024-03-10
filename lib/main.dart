// import 'package:countertest/pages/home_page.dart';
import 'package:countertest/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


//mateapp



// ---------------------
// void main() => runApp(const MyApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform); 
  // options:DefaultFirebaseOptions.currentPlatform
  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: "",
      cookie: true,
      xfbml: true,
      version: "v15.0",
    );
  }
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Super es el constructor de la clase padre

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, //para el debug
      title: 'Contador2',
      home:LoginPage(),
      
     // home: HomePage(),
    );
  }
}

//-- ---------------------

//fire

// import { initializeApp } from "firebase/app";

// const firebaseConfig = {
//   apiKey: "AIzaSyDYr6HmoE_rX0FQYHN20GZokqgRLYV2C1Y",
//   authDomain: "aut-flutter.firebaseapp.com",
//   projectId: "aut-flutter",
//   storageBucket: "aut-flutter.appspot.com",
//   messagingSenderId: "829057897086",
//   appId: "1:829057897086:web:859414b12b261913ebfe2f"
// };

// // Initialize Firebase
// const app = initializeApp(firebaseConfig);