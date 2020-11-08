import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:improve/ajuda1.dart';
import 'package:improve/personaliza.dart';
import 'package:improve/pontuacao.dart';
import 'package:improve/splashScreen.dart';
import 'package:improve/cadastro.dart';
import 'package:improve/login.dart';
import 'package:improve/Classes/user.dart';
import 'package:improve/ajuda.dart';
import 'package:improve/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:improve/jogo0.dart';
import 'package:improve/jogo1.dart';
import 'package:improve/jogo2.dart';
import 'package:improve/jogo3.dart';

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
      title: 'ImproveApp',
      theme: ,
      home: Splash(),
      //Navigation routes
      routes: {
        '/menu': (context) => Menu(),
        '/splash': (context) => Splash(),
        '/cadastro': (context) => Cadastro(),
        '/pontuacao': (context) => Pontuacao(),
        '/personaliza': (context) => Personaliza(),
        '/login': (context) => Login(),
        '/ajuda': (context) => Ajuda(),
        '/ajuda1': (context) => Ajuda1(),
        '/jogo0': (context) => Jogo0(),
        '/jogo1': (context) => Jogo1(),
        '/jogo2': (context) => Jogo2(),
        '/jogo3': (context) => Jogo3(),
      },
    );
  }
}
