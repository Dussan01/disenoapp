import 'dart:io';

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

  bool _validarlo() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    CommonThings.size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Agregar información', style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.yellow,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 10),
              child: Text('PQR', style: TextStyle(color: Colors.black, fontSize: 25),),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: '¿Preguntanos?',
                icon: Icon(Icons.access_alarm),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor ingrese un titulo';
                }
              },
              onSaved: (value) => titulo = value.trim(),
            ),
            SizedBox(height: 20),
            TextFormField(
              maxLines: 12,
              decoration: InputDecoration(
                hintText: 'Descripcion',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor ingrese alguna información';
                }
              },
              onSaved: (value) => descripcion = value,
            ),
            SizedBox(height: 20),
            // TextFormField(
            //   keyboardType: TextInputType.text,
            //   decoration: InputDecoration(
            //     labelText: 'Preguntas',
            //     icon: Icon(Icons.access_alarm),
            //   ),
            //   validator: (value) {
            //     if (value.isEmpty) {
            //       return 'Por favor ingrese un paso';
            //     }
            //   },
            //   onSaved: (value) => paso = value.trim(),
            // ),
            // SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: null,
                  child: Text('Preguntar', style: TextStyle(color: Colors.white),),
                  color: Colors.green,
                  disabledColor: Colors.red,
                )
              ],
            )
          ],
        ));
  }
}
