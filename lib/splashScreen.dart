import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:improve/Classes/user.dart';
import 'package:improve/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FirebaseUser userFirebase;

  @override
  void initState(){
    super.initState();
    gotoMenu();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> gotoMenu()async{

    userFirebase = await FirebaseAuth.instance.currentUser();
    prefs = await SharedPreferences.getInstance();


    if(userFirebase != null){
      user = new User.firebase(userFirebase);
      await user.loadFirestore();
    }
    if(prefs.getBool('firstTime') ?? true){
      await Navigator.pushNamedAndRemoveUntil(context, '/ajuda', (route) => false);
    }else{
      await Navigator.pushNamedAndRemoveUntil(context, '/menu', (route) => false);
    }
  }
}