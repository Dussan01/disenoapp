
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disenoapp/models/User_model.dart';
import 'package:firebase_auth/firebase_auth.dart';



abstract class BaseAuth {
  Future<String> signInEmailPassword(String email, String password); // Metodo Ingresar con Email y Password
  Future<String> signUpEmailPassword(Usuario usuario);//Le pasamos el modelo para el metodo registrar
  Future<void>   signOut(); // Metodo cerrar session
  Future<String> currentUser(); // Metodo Estado del Usuario
  Future<FirebaseUser> infoUser(); // Metodo informacion del usuario
}

class Auth implements BaseAuth{

FirebaseAuth  _firebaseAuth = FirebaseAuth.instance;

// Metodo Ingresar con Email y Password
Future<String> signInEmailPassword(String email, String password) async {
    FirebaseUser user = (
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
        )) .user;
  }
//Le pasamos el modelo para el metodo registrar
Future<String> signUpEmailPassword(Usuario usuarioModel) async {
    final FirebaseUser user = (
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: usuarioModel.email,
            password: usuarioModel.password)) .user;

    UserUpdateInfo usuario = UserUpdateInfo();
    usuario.displayName = usuarioModel.nombre;
    await user.updateProfile(usuario);
    // await user.sendEmailVerification().then((onValue) => print('Email de verificacion enviado'))
    //     .catchError((onError) => print('Error de Email de verificacion: $onError'));

    await Firestore.instance.collection('usuarios').document('${user.uid}').setData({
          'nombre': usuarioModel.nombre,//Se crea el campo nombre con los datos recividos del formulario de registro
          'telefono': usuarioModel.telefono,//Se crea el campo telefono con los datos recividos del formulario de registro
          'email': usuarioModel.email,//Se crea el campo email con los datos recividos del formulario de registro
          'ciudad': usuarioModel.ciudad,//Se crea el campo ciudad con los datos recividos del formulario de registro
          'direccion': usuarioModel.direccion,//Se crea el campo direccion con los datos recividos del formulario de registro
          'role': 'Usuario',//Esta la asigne por defecto ya que la mayoria van a hacer usuarios
        })
        .then((value) => print('Usuario registrado en la Base de datos'))
        .catchError(
            (onError) => print('Error en registrar el usuario en la Base de datos'));
    return user.uid;
  }

// Metodo cerrar session
  Future<void> signOut() async {
    return _firebaseAuth.signOut();     
  }

// Metodo Estado del Usuario
   Future<String> currentUser() async{
     FirebaseUser user = await _firebaseAuth.currentUser();
     String userId = user !=null ? user.uid : 'no_login';     
     return userId;
  }
  // Metodo informacion del usuario
  Future<FirebaseUser> infoUser() async{
     FirebaseUser user = await _firebaseAuth.currentUser();
     String userId = user !=null ? user.uid : 'No se pudo recuperar el usuario';
     print('recuperando usuario + $userId');     
     return user;
  }



}


