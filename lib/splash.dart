import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:apimovil/login.dart';
import 'package:apimovil/dashboard.dart';
import 'package:apimovil/course.dart';




class Splash extends StatefulWidget{
    @override
    State<StatefulWidget> createState() {
        return SplashState();
    }
}

class SplashState extends State<Splash> {
    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return MaterialApp(
            routes: {
                "/login": (context)=> Login(),
                '/dash': (context) => Dashboard(),
                '/course': (context) => Cursos()
                },
            home: SplashScreen(
                seconds: 3,
                image: Image.network("https://www.nationalgeographic.com.es/medio/2018/10/15/lince-iberico_84ac35dd_1200x900.jpg"),
                navigateAfterSeconds: Login(),
                title: Text("ClassITC", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                gradientBackground: new LinearGradient(colors: [Colors.white, Colors.lightGreen], begin: Alignment.center, end: Alignment.bottomCenter),
            ),

        );
    }
}