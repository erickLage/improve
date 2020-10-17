import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:improve/splashScreen.dart';
import 'menu.dart';

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
        '/splash': (context) => Splash()
      },
    );
  }
}