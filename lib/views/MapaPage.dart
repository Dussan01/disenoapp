import 'package:flutter/material.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mapa',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.network(
                  'https://static.wixstatic.com/media/084790_eb7d8e7e577c43848b7700e795d04a3e~mv2.jpg/v1/crop/x_0,y_2,w_1170,h_616/fill/w_560,h_314,al_c,q_80,usm_0.66_1.00_0.01/Cartagena%20Golf%20Condominio.webp'),
            ),
            SizedBox(height: 10),
            Text('Condominio CondoPlus',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
