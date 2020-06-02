import 'package:disenoapp/views/Reservas/SalonEventos.dart';
import 'package:flutter/material.dart';

class ReservasPage extends StatefulWidget {
  @override
  _ReservasPageState createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Reservas',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.yellow),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('CondoPlus',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new SalonEventosPage()));
                  },
                  child: Text(
                    'Salon Eventos',
                    style: TextStyle(color: Colors.black),
                  ),
                  // disabledColor: Colors.yellow,
                  color: Colors.yellow,
                  padding: EdgeInsets.symmetric(horizontal: 60),
                ),
                RaisedButton(
                  onPressed: null,
                  child: Text(
                    'Canchas',
                    style: TextStyle(color: Colors.black),
                  ),
                  disabledColor: Colors.yellow,
                  padding: EdgeInsets.symmetric(horizontal: 80),
                ),
                RaisedButton(
                  onPressed: null,
                  child: Text(
                    'Parques',
                    style: TextStyle(color: Colors.black),
                  ),
                  disabledColor: Colors.yellow,
                  padding: EdgeInsets.symmetric(horizontal: 80),
                ),
                RaisedButton(
                  onPressed: null,
                  child: Text(
                    'GYM',
                    style: TextStyle(color: Colors.black),
                  ),
                  disabledColor: Colors.yellow,
                  padding: EdgeInsets.symmetric(horizontal: 100),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
