import 'package:flutter/material.dart';
import 'home.dart';

class SplashHome extends StatefulWidget {
  @override
  _SplashHomeState createState() => _SplashHomeState();
}

class _SplashHomeState extends State<SplashHome> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 5)).then((_) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end, // MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: 800,
            height: 600,
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage("images/fundo_m6.jpeg"))),
          ),
          //Text( "TELA DE ABERTURA"),
        ],
      ),
    );
  }
}
