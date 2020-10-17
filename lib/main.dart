import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:improve/splashScreen.dart';

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
      home: Splash(),
      //Navigation routes
      routes: { 
      },
    );
  }
}