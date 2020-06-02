import 'package:disenoapp/controller/Auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommonThings {
  static Size size;
}

class ReclamosPage extends StatefulWidget {
  ReclamosPage({this.id});
  final String id;

  @override
  _ReclamosPageState createState() => _ReclamosPageState();
}

class _ReclamosPageState extends State<ReclamosPage> {
  File _foto;
  String urlFoto;
  bool _isInAsyncCall = false;

  String genero;
  List<DropdownMenuItem<String>> sexo; //Lista de ciudades.

  Auth auth = Auth();
  @override
  void initState() {
    super.initState();
    auth.infoUser().then((onValue) {
      setState(() {
        id = onValue.uid;
        sexo = getCiudadItems();
        genero = sexo[0].value;
        print('ID $id');
      });
    });
  }

  bool _validarlo() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _enviar() {
    if (_validarlo()) {
      Firestore.instance
          .collection('PQR')
          .add({
            'uid': id,
            'pregunta': genero,
            'descripcion': descripcion
          })
          .then((value) => Navigator.of(context).pop())
          .catchError((onError) =>
              print('Error en registrar el usuario en la base de datos'));
      _isInAsyncCall = false;
    }
  }

  getData() async {
    return await Firestore.instance.collection('preguntas').getDocuments();
  }

  List<DropdownMenuItem<String>> getCiudadItems() {
    List<DropdownMenuItem<String>> items = List();
    QuerySnapshot dataCiudades;
    getData().then((data) {
      dataCiudades = data;
      dataCiudades.documents.forEach((obj) {
        print('${obj.documentID} ${obj['tipo']}');
        items.add(DropdownMenuItem(
          value: obj.documentID,
          child: Text(obj['tipo']),
        ));
      });
    }).catchError((error) => print('hay un error...' + error));

    items.add(DropdownMenuItem(
      value: '0',
      child: Text('Seleccione...'),
    ));

    return items;
  }

  String id;

  final _formKey = GlobalKey<FormState>();
  String titulo;
  String uid;
  String descripcion;
  String paso;

  Widget divider() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Container(
          width: 0.8,
          color: Colors.black,
        ));
  }


  @override
  Widget build(BuildContext context) {
    CommonThings.size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregar información',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 150, vertical: 10),
              child: Text(
                'PQR',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),

            DropdownButtonFormField(
              validator: (value) =>
                  value == '0' ? 'Debe seleccionar una opcion' : null,
              decoration: InputDecoration(
                  labelText: '¿Pregunta?', icon: Icon(Icons.question_answer)),
              value: genero,
              items: sexo,
              onChanged: (value) {
                setState(() {
                  genero = value;
                });
              }, //seleccionarCiudadItem,
              onSaved: (value) => genero = value,
            ),
            SizedBox(height: 20),
            TextFormField(
              maxLines: 12,
              decoration: InputDecoration(
                hintText: 'Descripcion',
              ),
              onSaved: (value) => descripcion = value,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Preguntar',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.green,
                  disabledColor: Colors.red,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
