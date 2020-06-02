import 'package:disenoapp/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui/utils.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<String> signInEmailPassword(
      String email, String password); // Metodo Ingresar con Email y Password
  Future<String> signUpEmailPassword(
      Usuario usuario); //Le pasamos el modelo para el metodo registrar
  Future<void> signOut(); // Metodo cerrar session
  Future<String> currentUser(); // Metodo Estado del Usuario
  handleFacebook();
  Future<String> signInWithGoogle();
  Future<void> cerrarSesion();

  Future<FirebaseUser> infoUser(); // Metodo informacion del usuario
}

class Auth implements BaseAuth {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    @override
  Future<void> cerrarSesion() async {
    await googleSignIn.signOut();
    return _firebaseAuth.signOut();
  }


// Metodo Ingresar con Email y Password
  Future<String> signInEmailPassword(String email, String password) async {
    FirebaseUser user = (await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password));
    return 'Listo';
  }

//Le pasamos el modelo para el metodo registrar
  Future<String> signUpEmailPassword(Usuario usuarioModel) async {
    final FirebaseUser user = (await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: usuarioModel.email, password: usuarioModel.password));

    UserUpdateInfo usuario = UserUpdateInfo();
    usuario.displayName = usuarioModel.nombre;
    await user.updateProfile(usuario);
    // await user.sendEmailVerification().then((onValue) => print('Email de verificacion enviado'))
    //     .catchError((onError) => print('Error de Email de verificacion: $onError'));

    await Firestore.instance
        .collection('usuarios')
        .document('${user.uid}')
        .setData({
          'nombre': usuarioModel
              .nombre, //Se crea el campo nombre con los datos recividos del formulario de registro
          'telefono': usuarioModel
              .telefono, //Se crea el campo telefono con los datos recividos del formulario de registro
          'email': usuarioModel
              .email, //Se crea el campo email con los datos recividos del formulario de registro
          'ciudad': usuarioModel
              .ciudad, //Se crea el campo ciudad con los datos recividos del formulario de registro
          'direccion': usuarioModel
              .direccion, //Se crea el campo direccion con los datos recividos del formulario de registro
          'role':
              'Usuario', //Esta la asigne por defecto ya que la mayoria van a hacer usuarios
        })
        .then((value) => print('Usuario registrado en la Base de datos'))
        .catchError((onError) =>
            print('Error en registrar el usuario en la Base de datos'));
    return user.uid;
  }

// Metodo cerrar session
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

// Metodo Estado del Usuario
  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    String userId = user != null ? user.uid : 'no_login';
    return userId;
  }

  // Metodo informacion del usuario
  Future<FirebaseUser> infoUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    String userId = user != null ? user.uid : 'No se pudo recuperar el usuario';
    print('recuperando usuario + $userId');
    return user;
  }

 @override
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final FirebaseUser user =
        await _firebaseAuth.signInWithCredential(credential);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    assert(user.email != null);
    assert(user.displayName != null);

    return 'Ingreso sastifactorio: $user';
  }


  @override
  handleFacebook() async {
    FacebookLoginResult result =
        await facebookLogin.logInWithReadPermissions(['email']);
    if (result.accessToken != null) {
      try {
        AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
        FirebaseUser user =
            (await _firebaseAuth.signInWithCredential(credential));
        await Firestore.instance
            .collection('usuarios')
            .document('${user.uid}')
            .setData({
              'nombre': user.displayName,
              'email': user.email,
              'telefono': user.phoneNumber,
              'role': 'Usuario',
            })
            .then((value) => print('Usuario registrado en la Base de Datos'))
            .catchError((onError) =>
                print('Error en registrar el usuario en la Base de Datos'));
      } catch (e) {
        print(e);
        // showErrorDialog(context, e.details);
      }
    }
  }
}
