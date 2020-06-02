import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disenoapp/views/ReclamosPage.dart';
import 'package:flutter/material.dart';

class SalonEventosPage extends StatefulWidget {
  @override
  _SalonEventosPageState createState() => _SalonEventosPageState();
}

class _SalonEventosPageState extends State<SalonEventosPage> {
  final _formKey = GlobalKey<FormState>();

  String nombre;
  String fecha;
  String hora;

  bool _validar() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _enviar() {
    //send the information to firestore
    if (_validar()) {
      Firestore.instance
          .collection('reserva')
          .add({
            'reserva': nombre,
            'fecha': _dateTime,
            'hora': hora,
          })
          .then((value) => Navigator.of(context).pop())
          .catchError(
              (onError) => print('Error editar la informacion en la bd'));
    } else {
      print('objeto no validado');
    }
  }

  DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    CommonThings.size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reserva'),
        backgroundColor: Colors.yellow,
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 280),
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('reserva')
                  // .document(widget.id)
                  // .collection('mycolrecipes')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text("loading....");
                } else {
                  if (snapshot.data.documents.length == 0) {
                    return Center(
                      child: Column(
                        children: <Widget>[
                          Card(
                            margin: EdgeInsets.all(15),
                            shape: BeveledRectangleBorder(
                                side: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5.0)),
                            elevation: 5.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '\nAdd my recipe.\n',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.blue),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    //print("from the streamBuilder: "+ snapshot.data.documents[]);
                    // print(length.toString() + " doc length");

                    return ListView(
                      children: snapshot.data.documents.map((document) {
                        return Card(
                          elevation: 5.0,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    document['reserva']
                                        .toString()
                                        .toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: <Widget>[
                                      Text(
                                        'Fecha: ' +
                                        document['fecha'].toDate().toString(),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12.0),
                                            maxLines: 1,
                                      ),
                                      Text(
                                        ' Hora: ' + 
                                        document['hora'].toString(),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 12.0),
                                            maxLines: 1,
                                      ),
                                    ],
                                  ),

                                  //editar la receta
                                  onTap: () {},
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }
                }
              },
            ),
          ),
          ListView(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      // TextFormField(decoration: InputDecoration(labelText: '')),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Nombre'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor ingrese un nombre';
                          }
                        },
                        onSaved: (value) => nombre = value.trim(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Hora'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor ingrese un hora';
                          }
                        },
                        onSaved: (value) => hora = value.trim(),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Text(_dateTime == null
                          ? 'No has seleccionado'
                          : _dateTime.toString()),

                      RaisedButton(
                        child: Text('Selecciona fecha'),
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2001),
                                  lastDate: DateTime(2222))
                              .then((date) {
                            setState(() {
                              _dateTime = date;
                            });
                          });
                        },
                      ),

                      RaisedButton(
                        onPressed: _enviar,
                        child: Text("Guardar"),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
