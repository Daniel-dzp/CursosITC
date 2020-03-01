import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatelessWidget{
    @override
    Widget build(BuildContext context) {
        return MenuLateral();
    }
}

class MenuLateral extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return MenuLateralState();
    }
}

class MenuLateralState extends State<MenuLateral>{
    @override
    Widget build(BuildContext context) {

        return MaterialApp(
            home: Scaffold(
            appBar: AppBar(
                title: Text("Dashboard EPP"),
                backgroundColor: Colors.blue,
            ),
            drawer: Drawer(
                child: ListView(
                    children: <Widget>[
                        UserAccountsDrawerHeader(
                            decoration: BoxDecoration(
                                color: Colors.blueAccent
                            ),
                            accountName: Text("Daniel Zamudio Pichardo"),
                            accountEmail: Text("15030090@itcelaya.edu.mx"),
                            currentAccountPicture: CircleAvatar(
                                backgroundImage: new NetworkImage("http://i.pravatar.cc/300"),
                            ),
                        ),
                        ListTile(
                            title: Text("Cursos"),
                            leading: Icon(Icons.golf_course),
                            trailing: Icon(Icons.contacts),
                            onTap: (){
                                //Navigator.pop(context);
                                Navigator.of(context).pushNamed('/course');
                            },
                        ),
                        ListTile(
                            title: Text("Salir"),
                            trailing: Icon(Icons.exit_to_app),
                            onTap: (){
                                guardarSF();
                                Navigator.of(context).pushReplacementNamed('/login');
                            },
                        )
                    ],
                ),
            ),
        )
        );
    }

    guardarSF() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('mantenerSession', false);
    }
}
