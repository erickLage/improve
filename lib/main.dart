import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:improve/splashScreen.dart';
import 'package:improve/cadastro.dart';
import 'package:improve/login.dart';
import 'package:improve/Classes/user.dart';
import 'menu.dart';

User user = new User();
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  //prevent device orientation change
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_){
    runApp(new WoranaApp());
  });
}

class WoranaApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'WoranaApp',
      home: Menu(),
      //Navigation routes
      routes: { 
        '/menu': (context) => Menu(),
        '/splash': (context) => Splash(),
        '/cadastro': (context) => Cadastro(),
        '/login': (context) => Login(),
      },
    );
  }
}