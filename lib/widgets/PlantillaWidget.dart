import 'package:flutter/material.dart';

class PlantillaWidget extends StatefulWidget {
  PlantillaWidget({this.appBar, this.stack, this.botonflotante, this.container});
  final AppBar appBar;
  final Stack stack;
  final Container container;
  final FloatingActionButton botonflotante;

  @override
  _PlantillaWidgetState createState() => _PlantillaWidgetState();
}

class _PlantillaWidgetState extends State<PlantillaWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        appBar: widget.appBar,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/imagenes/fondo.png',
                  ),
                  fit: BoxFit.fill)),
          child: widget.stack,
        ),
        floatingActionButton: widget.botonflotante);
  }
}
