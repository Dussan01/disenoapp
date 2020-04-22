import 'package:disenoapp/views/DashboardPage.dart';
import 'package:disenoapp/widgets/PlantillaWidget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          Padding(
            padding: const EdgeInsets.only(top: 200, left: 50, right: 50),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.people),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.amber,
                        style: BorderStyle.solid,
                      ),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 270, left: 50, right: 50),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.people),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.yellow,
                        style: BorderStyle.solid,
                      ),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 400, left: 60),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashbordPage(),
                  ),
                );
              },
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
          )
        ],
      ),
    );
  }
}
