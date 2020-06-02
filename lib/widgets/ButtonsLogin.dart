import 'package:flutter/material.dart';
class ButtonsLogin extends StatefulWidget {
  final IconData icons;
  final String titulo;
  final Function onPress;
  final Color colorButton;
  ButtonsLogin({this.icons, this.titulo, this.onPress, this.colorButton});
  @override
  _ButtonsLoginState createState() => _ButtonsLoginState();
}

class _ButtonsLoginState extends State<ButtonsLogin> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: widget.colorButton),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 20,),
                  Icon(widget.icons, color: Colors.white, size: 20,),
                  SizedBox(
                    width: 30,
                  ),
                  Text(widget.titulo, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                ],
              ),
            ),
            onTap: widget.onPress,
          )
        ],
      ),
  ),
    );
  }
}