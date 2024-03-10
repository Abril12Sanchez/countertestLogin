import 'dart:html';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  // Creacion de la cuenta
  Future createAcount(String email, String password)async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential.user);
      return(userCredential.user?.uid);
    }on FirebaseAuthException catch(e){
      if(e.code=='weak-password'){
        print("Tu contraseña es debil");
        return 1;
      }else if(e.code=='email-already-in-use'){
        print("esta cuenta ya existe");
        return 2;
      }

    }catch (e){
      print(e);
    }

  }

// Para crear cuenta
Future singInEmailAndPassword(String email, String password)async{
try{
  UserCredential userCredential= await _auth.signInWithEmailAndPassword(email: email, password: password);
  final a= userCredential.user;
  if(a?.uid != null){
    return a?.uid;
  }
}on FirebaseAuthException catch(e){
  if(e.code=='user-not-found'){
    return 1;
  }else if(e.code=='wrong-passwors'){
    return 2;
  }
}

}


}