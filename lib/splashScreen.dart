import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void didChangeDependencies() {
    gotoMenu();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  void gotoMenu(){
    //Navigator.pushNamedAndRemoveUntil(context, '/menu', (route) => false);
  }
}