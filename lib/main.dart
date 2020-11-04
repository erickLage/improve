import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:improve/splashScreen.dart';
import 'package:improve/cadastro.dart';
import 'package:improve/login.dart';
import 'package:improve/Classes/user.dart';
import 'package:improve/ajuda.dart';
import 'package:improve/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

User user = new User();
SharedPreferences prefs;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //prevent device orientation change
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(new WoranaApp());
  });
}

class WoranaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'WoranaApp',
      home: Splash(),
      //Navigation routes
      routes: {
        '/menu': (context) => Menu(),
        '/splash': (context) => Splash(),
        '/cadastro': (context) => Cadastro(),
        '/login': (context) => Login(),
        '/ajuda': (context) => Ajuda(),
      },
    );
  }
}
