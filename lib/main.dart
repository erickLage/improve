import 'package:dynamic_theme/dynamic_theme.dart';
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

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  //prevent device orientation change
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async{
    prefs = await SharedPreferences.getInstance();
    runApp(new ImproveApp());
  });
}



class ImproveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(prefs.getInt('improveColorRed'));
    return DynamicTheme(
      data: (brightness){
        return ThemeData(
          primaryColor: Color.fromRGBO(prefs.getInt('improveColorRed') ?? 102, prefs.getInt('improveColorGreen') ?? 178, prefs.getInt('improveColorBlue') ?? 255, 1),
          textTheme: (prefs.getBool('textBlack') ?? true) ? Typography.blackRedmond : Typography.whiteRedmond
        );
      },
      themedWidgetBuilder: (context, tema) {
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
            '/personaliza': (context) => Personaliza(),
            '/login': (context) => Login(),
            '/ajuda': (context) => Ajuda(),
            '/ajuda1': (context) => Ajuda1(),
            '/tutorial0': (context) => Ajuda1(pagina: 0,),
            '/tutorial1': (context) => Ajuda1(pagina: 1,),
            '/tutorial2': (context) => Ajuda1(pagina: 2,),
            '/tutorial3': (context) => Ajuda1(pagina: 3,),
            '/jogo0': (context) => Jogo0Menu(),
            '/jogo1': (context) => Jogo1Menu(),
            '/jogo2': (context) => Jogo2Menu(),
            '/jogo3': (context) => Jogo3Menu(),
          },
        );
      }
    );
  }
}
