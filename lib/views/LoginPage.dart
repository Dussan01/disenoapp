import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disenoapp/controller/Auth.dart';
import 'package:disenoapp/models/UserModel.dart';
import 'package:disenoapp/views/DashboardPage.dart';
import 'package:disenoapp/views/DashboardPage.dart';
import 'package:disenoapp/widgets/PlantillaWidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignIn});

  final BaseAuth auth;
  final VoidCallback onSignIn;
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, registro }
enum SelectSource { camara, galeria }

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  //Declaramos las variables
  String _email;
  String _password;
  String _nombre;
  String _telefono;
  String _itemCiudad;
  String _direccion;
  String _urlFoto = '';
  String usuario;

  bool _obscureText = true;
  FormType _formType = FormType.login;
  List<DropdownMenuItem<String>> _ciudadItems; //Lista de ciudades.

  @override
  void initState() {
    super.initState();
    setState(() {
      _ciudadItems = getCiudadItems();
      _itemCiudad = _ciudadItems[0].value;
    });
  }

  getData() async {
    return await Firestore.instance.collection('ciudades').getDocuments();
  }

  //Dropdownlist from firestore
  List<DropdownMenuItem<String>> getCiudadItems() {
    List<DropdownMenuItem<String>> items = List();
    QuerySnapshot dataCiudades;
    getData().then((data) {
      dataCiudades = data;
      dataCiudades.documents.forEach((obj) {
        print('${obj.documentID} ${obj['nombre']}');
        items.add(DropdownMenuItem(
          value: obj.documentID,
          child: Text(obj['nombre']),
        ));
      });
    }).catchError((error) => print('hay un error...' + error));

    items.add(DropdownMenuItem(
      value: '0',
      child: Text('Seleccione...'),
    ));

    return items;
  }

  bool _validarGuardar() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //Crea un metodo de validar y enviar
  void _validarEnviar() async {
    if (_validarGuardar()) {
      try {
        String userId =
            await widget.auth.signInEmailPassword(_email, _password);
        print('Usuario logueado : $userId '); //ok
        widget.onSignIn();
        DashbordPage(auth: widget.auth); //return menu_page.dart
        Navigator.of(context).pop();
      } catch (e) {
        print('Error .... $e');
        AlertDialog alerta = new AlertDialog(
          content: Text('Error en la Autenticación'),
          title: Text('Error'),
          actions: <Widget>[],
        );
        showDialog(context: context, child: alerta);
      }
    }
  }

  //Metodo de validar y enviar registro
  void _validarRegistrar() async {
    if (_validarGuardar()) {
      try {
        Usuario usuario = Usuario(
            //Instanciamos el modelo usuario para capturar informacion
            nombre: _nombre,
            ciudad: _itemCiudad,
            direccion: _direccion,
            email: _email,
            password: _password,
            telefono: _telefono,
            foto: _urlFoto);
        String userId = await widget.auth.signUpEmailPassword(usuario);
        print('Usuario logueado : $userId'); //ok
        widget.onSignIn();
        DashbordPage(auth: widget.auth); //menu_page.dart
        Navigator.of(context).pop();
      } catch (e) {
        print('Error .... $e');
        AlertDialog alerta = new AlertDialog(
          content: Text('Error en el registro'),
          title: Text('Error'),
          actions: <Widget>[],
        );
        showDialog(context: context, child: alerta);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlantillaWidget(
      stack: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 10, left: 28),
            child: Container(
              height: 450,
              width: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/imagenes/fondo2.png'),
                fit: BoxFit.fill,
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 300),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/imagenes/logo.png'))),
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 220, left: 50, right: 50),
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          prefixIcon: Icon(FontAwesomeIcons.envelope),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Colors.amber,
                              style: BorderStyle.solid,
                            ),
                          )),
                      validator: (value) =>
                          value.isEmpty ? 'El campo Email está vacio' : null,
                      onSaved: (value) => _email = value.trim()),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 50, right: 50, bottom: 10),
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          prefixIcon: Icon(FontAwesomeIcons.key),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Colors.yellow,
                              style: BorderStyle.solid,
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          )),
                      validator: (value) =>
                          value.isEmpty ? 'El campo Email está vacio' : null,
                      onSaved: (value) => _password = value.trim()),
                ),
                RaisedButton(
                  onPressed: _validarEnviar,
                  child: Text(
                    "Logear",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
