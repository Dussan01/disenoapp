import 'package:disenoapp/controller/Auth.dart';
// import 'package:disenoapp/controller/Content.dart';
import 'package:disenoapp/widgets/ListTitle.dart';
import 'package:disenoapp/widgets/MenuPage.dart';
import 'package:flutter/material.dart';

class DashbordPage extends StatefulWidget {
  DashbordPage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  @override
  _DashbordPageState createState() => _DashbordPageState();
}

class _DashbordPageState extends State<DashbordPage> {
  
    void _signOut() async {
    try {
      widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }


  Widget contentPage = Menu();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          elevation: 30.0,
          child: Container(
            color: Colors.yellow,
            child: ListView(
              children: <Widget>[
                ListTitle(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  titulo: "Vision",
                ),
                Divider(height: 2.0, color: Colors.black),
                ListTitle(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  titulo: "Mision",
                ),
                Divider(height: 2.0, color: Colors.black),
                ListTitle(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  titulo: "Administrativos",
                ),
                Divider(height: 2.0, color: Colors.black),
                ListTitle(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  titulo: "Personal",
                ),
                Divider(height: 2.0, color: Colors.black),
                ListTitle(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  titulo: "Reglamento",
                ),
                Divider(height: 2.0, color: Colors.black),
                ListTitle(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  titulo: "Horarios",
                ),
                Divider(height: 2.0, color: Colors.black),
                ListTitle(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  titulo: "Telefonos",
                ),
                Divider(height: 2.0, color: Colors.black),
                ListTitle(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  titulo: "Otros",
                ),
                Divider(height: 2.0, color: Colors.black),
                ListTitle(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  titulo: "Salir",
                  onTap: () {
                    Navigator.of(context).pop();
                    _signOut();
                  },
                ),
                Divider(height: 2.0, color: Colors.black),
              ],
            ),
          )),
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text(''),
      ),
      body: contentPage,
    );
  }
}
