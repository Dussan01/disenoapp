import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Color color;
  final String titulo;
  final String icono;
  final Function onpress;
  Button({this.color, this.titulo, this.onpress, this.icono});
  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), color: widget.color),
        width: 135.0,
        height: 135.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset(widget.icono),
              width: 50.0,
              height: 50.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(widget.titulo,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
      onTap: widget.onpress,
    );
  }
}
