import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class Login extends StatefulWidget{
    @override
    State<StatefulWidget> createState() {
        // TODO: implement createState
        return LoginState();
    }
}

class LoginState extends State<Login>{

    final txtUserController = TextEditingController();
    final txtPwdController = TextEditingController();

    bool _mantener = false;

    @override
    Widget build(BuildContext context) {

        Future<int> validateUser() async{
            var user = txtUserController.text;
            var pwd = txtPwdController.text;

            http.Response response = await http.get(
                Uri.encodeFull("http://192.168.1.107:8888/usuarios/$user/$pwd"),
                headers: { "Accept" : "application/json"}
            );

            var token = response.body; // Obtener el token de la peticion o el error
            return response.statusCode;
        }

        final logo = Hero(
            tag: 'hero',
            child: CircleAvatar(
                //backgroundColor: Colors.lightGreen,
                radius: 48.0,
                child: Image.asset("imagenes/logo.jpg"),
                //child: Image.network("https://dms.com.pe/wp-content/uploads/2017/02/acceso-web.png"),
            ),
        );

        final txtEmail = TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: txtUserController,
            //autofocus: false,
            decoration: InputDecoration(
                hintText: 'Introduce el e-mail :)',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
        );

        final txtPwd = TextFormField(
            //autofocus: false,
            //initialValue: 'some password',
            controller: txtPwdController,
            obscureText: true,
            decoration: InputDecoration(
                hintText: 'Introduce el password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
        );

        final loginButton = Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                ),
                onPressed: () {
                        guardarSF();
                        Navigator.of(context).pushReplacementNamed('/dash');
                },
                padding: EdgeInsets.all(12),
                color: Colors.lightBlue,
                child: Text('Entrar', style: TextStyle(color: Colors.white)),
            ),
        );

        final checkBox = Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
                children: <Widget>[
                    Checkbox(
                        value: _mantener,
                        onChanged: _mantenerSession,
                    ),
                    Text("Mantener Session"),
                ],
            )

        );

        return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 24.0, right: 24.0),
                    children: <Widget>[
                        logo,
                        SizedBox(height: 40.0),
                        txtEmail,
                        SizedBox(height: 30.0),
                        txtPwd,
                        checkBox,
                        SizedBox(height: 30.0),
                        loginButton
                    ],
                ),
            ),
        );
    }

    @protected
    @mustCallSuper
    void initState() {
        obtenerSF();
    }

    void _mantenerSession(bool value){
        this.setState((){
            _mantener = value;
        });
    }

    guardarSF() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('mantenerSession', _mantener);
    }

    obtenerSF() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        //Return bool
        bool boolValue = prefs.getBool('mantenerSession');

        if(boolValue != null) {
            this.setState((){
                _mantener = boolValue;
                if(_mantener) {
                    Navigator.of(context).pushReplacementNamed('/dash');
                }
            });
        }
    }
}