import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flame/flame.dart";
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

User user = new User();
SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.util.fullScreen();
  WidgetsFlutterBinding.ensureInitialized();
  //prevent device orientation change
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    prefs = await SharedPreferences.getInstance();
    runApp(new ImproveApp());
  });
}

class ImproveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(data: (brightness) {
      List<int> colors = [
        prefs.getInt('improveColorRed') ?? 102, 
        prefs.getInt('improveColorGreen') ?? 178,
        prefs.getInt('improveColorBlue') ?? 255
      ];
      return ThemeData(
        primaryColor: Color.fromRGBO(
            colors[0],
            colors[1],
            colors[2],
            1),
        accentColor: prefs.getBool('textBlack') ?? true
          ? Color.fromRGBO(
            colors[0] - ((colors[0])/3).round(), 
            colors[1] - ((colors[1])/3).round(), 
            colors[2] - ((colors[2])/3).round(),  
            1
          )
          : Color.fromRGBO(
            colors[0] + ((255 - colors[0])/3).round(), 
            colors[1] + ((255 - colors[1])/3).round(), 
            colors[2] + ((255 - colors[2])/3).round(),  
            1
          )
      );
    }, themedWidgetBuilder: (context, tema) {
      return new MaterialApp(
        title: 'ImproveApp',
        theme: tema,
        home: Splash(),
        //Navigation routes
        routes: {
          '/menu': (context) => Menu(),
          '/splash': (context) => Splash(),
          '/cadastro': (context) => Cadastro(),
          '/pontuacao': (context) => Pontuacao(),
          '/personaliza': (context) => Personaliza(prefs.getInt('improveSound') ?? 0),
          '/login': (context) => Login(),
          '/ajuda': (context) => Ajuda(prefs.getBool('textBlack') ?? true),
          '/ajuda1': (context) => Ajuda1(prefs.getBool('textBlack') ?? true),
          '/tutorial0': (context) => Ajuda1( 
                prefs.getBool('textBlack') ?? true,
                pagina: 0,
              ),
          '/tutorial1': (context) => Ajuda1(
                prefs.getBool('textBlack') ?? true,
                pagina: 1,
              ),
          '/tutorial2': (context) => Ajuda1(
                prefs.getBool('textBlack') ?? true,
                pagina: 2,
              ),
          '/jogo0': (context) => Jogo0Menu(prefs.getInt('improveSound') ?? 0),
          '/jogo1': (context) => Jogo1Menu(prefs.getInt('improveSound') ?? 0),
        },
      );
    });
  }
}
