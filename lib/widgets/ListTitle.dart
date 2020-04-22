import 'package:flutter/material.dart';

class ListTitle extends StatefulWidget {
  final String titulo;
  final Icon icon;
  ListTitle({this.icon, this.titulo});
  @override
  _ListTitleState createState() => _ListTitleState();
}

class _ListTitleState extends State<ListTitle> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: widget.icon,
      title: Text(
        widget.titulo,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
