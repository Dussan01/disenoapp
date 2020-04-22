import 'package:disenoapp/views/CalendarioPage.dart';
import 'package:disenoapp/views/GaleriaPage.dart';
import 'package:disenoapp/views/MapaPage.dart';
import 'package:disenoapp/views/ReclamosPage.dart';
import 'package:disenoapp/views/ReservasPage.dart';
import 'package:disenoapp/widgets/FormCard.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
            colors: [Colors.lightBlue, Colors.lightBlue, Colors.blue],
            stops: [0.5, 0.5, 0.8],
            radius: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Button(
                    icono: 'assets/icons/hotel.png',
                    titulo: "Mapa",
                    color: Colors.yellow,
                    onpress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new MapaPage()));
                    },
                  ),
                  Button(
                    titulo: "Calendario",
                    icono: 'assets/icons/calendario.png',
                    color: Colors.yellow,
                    onpress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new MyHomePage(title: 'Calendario')));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Button(
                    icono: 'assets/icons/reservas.png',
                    titulo: "Reservas",
                    color: Colors.yellow,
                    onpress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new ReservasPage()));
                    },
                  ),
                  Button(
                    icono: 'assets/icons/galeria.png',
                    titulo: "Galeria",
                    color: Colors.yellow,
                    onpress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new GaleriaPage()));
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Button(
                    icono: 'assets/icons/letra.png',
                    titulo: "Reclamos",
                    color: Colors.yellow,
                    onpress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new ReclamosPage()));
                    },
                  ),
                  Button(
                    icono: 'assets/icons/contacto.png',
                    titulo: "Contactos",
                    color: Colors.yellow,
                    onpress: () {
                      print("hola");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
