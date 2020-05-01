import 'package:disenoapp/controller/Auth.dart';
import 'package:disenoapp/views/LoginPage.dart';
import 'package:disenoapp/widgets/PlantillaWidget.dart';
import 'package:flutter/material.dart';

class BienvenidaPage extends StatefulWidget {
  BienvenidaPage({this.auth, this.onSignIn});
    final BaseAuth auth;
  final VoidCallback onSignIn;

  @override
  _BienvenidaPageState createState() => _BienvenidaPageState();
}

class _BienvenidaPageState extends State<BienvenidaPage> {
  @override
  Widget build(BuildContext context) {
    return PlantillaWidget(
      stack: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 130, left: 120),
            child: Text(
              "Bienvenidos",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/imagenes/logo.png'))),
          ),
        ],
      ),
      botonflotante: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(auth: widget.auth, onSignIn: widget.onSignIn,),
            ),
          );
        },
        backgroundColor: Colors.blue[300],
        child: Icon(Icons.skip_next),
      ),
    );
  }
}
