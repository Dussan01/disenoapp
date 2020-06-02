import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SalonEventosPage extends StatefulWidget {
  @override
  _SalonEventosPageState createState() => _SalonEventosPageState();
}

class _SalonEventosPageState extends State<SalonEventosPage> {
  final _formKey = GlobalKey<FormState>();

  String nombre;
  String fecha;
  TimeOfDay hora;
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Reserva'),
          backgroundColor: Colors.yellow,
        ),
        body: ListView(
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
                    // TextFormField(
                    //   keyboardType: TextInputType.phone,
                    //   decoration: InputDecoration(labelText: 'Hora'),
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return 'Por favor ingrese un hora';
                    //     }
                    //   },
                    //   onSaved: (value) => hora = value.trim(),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(_dateTime == null
                        ? 'No has seleccionado'
                        : _dateTime.toString()),
                    Text(hora == null
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
                      child: Text('Selecciona Hora'),
                      onPressed: () {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((time) {
                          setState(() {
                            hora = time;
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
            StreamBuilder(
              stream: Firestore.instance
                  .collection('reserva')
                  // .document(widget.id)
                  // .collection('infoComida')
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
                                  '\n Esperando Pedidos.\n',
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

                                  subtitle: Text(
                                    'hora ' +
                                        document['hora']
                                            .toString()
                                            .toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.0),
                                  ),
                                  //editar la receta
                                  onTap: () {
                                    // Producto infoComida = Producto(
                                    //   uid: document['uid'],
                                    //   titulo: document['titulo'],
                                    //   imagen: document['image'],
                                    //   descripcion: document['descripcion'],
                                    //   precio: document['precio'],
                                    //   categoria: document['categoria']

                                    // );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => EditInfo(
                                    //             info: infoComida,
                                    //             idInfo: document.documentID,
                                    //             uid: userID)));
                                  },
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  //eliminamos la receta personal
                                  // document.data.remove('key');
                                  // Firestore.instance
                                  //     .collection('infoComida')
                                  //     .document(document.documentID)
                                  //     .delete();
                                  // //eliminamos la foto
                                  // FirebaseStorage.instance
                                  //     .ref()
                                  //     .child(
                                  //         'infoComida/$userID/uid/categoria/${document['titulo'].toString()}.jpg')
                                  //     .delete()
                                  //     .then((onValue) {
                                  //   print('foto eliminada');
                                  // });
                                }, //funciona
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.blueAccent,
                                ),
                                //Visualizar la receta,
                                onPressed: () {
                                  // Info infoDescripcion = Info(
                                  //   titulo: document['titulo'].toString(),
                                  //   descripcion: document['descripcion'].toString(),
                                  //   paso: document['paso'].toString(),
                                  //   image: document['image']
                                  // );
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => VerInfo(
                                  //             infoDecripcion: infoDescripcion,
                                  //             idInfo: document.documentID,
                                  //             uid: userID)));
                                },
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
          ],
        ));
  }
}
