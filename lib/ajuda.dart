import 'dart:math';
import 'package:flutter/material.dart';
import 'package:improve/main.dart';

class Ajuda extends StatefulWidget {
  final bool isBlack;
  Ajuda(this.isBlack);
  _AjudaState createState() => _AjudaState(isBlack);
}

class _AjudaState extends State<Ajuda> {
  final bool isBlack;
  PageController pageController;
  int paginaAtual;
  List<String> titulo;
  List<String> descricao;
  List<Widget> icones;

  _AjudaState(this.isBlack){
    pageController =
      new PageController(initialPage: 0, viewportFraction: 1);
    paginaAtual = 0;
    titulo = [
      'Bem vindo ao Improve!',
      'Cadastre-se',
      'Personalize',
      'Jogue',
      'Pontue e compartilhe'
    ];
    descricao = [
      'Este aplicativo foi desenvolvido para pessoas com a sindrome de asperger. Se necessário, peça a ajuda de um acompanhante.',
      'Para começar, cadastre-se na tela inicial, verifique o seu email e depois faça o login.',
      'Personalize o aplicativo de acordo com a suas preferências.',
      'Jogue, divirta-se e aprenda.',
      'Verifique suas melhores pontuações. Se quiser, cadastre as informações de um especialista e compartilhe seus resultados.'
    ];
    icones = [
      Image.asset('src/assets/logo_sem_fundo.png', color: this.isBlack ? Colors.black : Colors.white),
      Icon(Icons.face, size: 100, color: this.isBlack ? Colors.black : Colors.white),
      Icon(Icons.create, size: 100, color: this.isBlack ? Colors.black : Colors.white),
      Icon(Icons.sports_esports, size: 100, color: this.isBlack ? Colors.black : Colors.white),
      Icon(Icons.share, size: 100, color: this.isBlack ? Colors.black : Colors.white)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              onPageChanged: (index) {
                setState(() {
                  paginaAtual = index;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icones[index],
                        Text(
                          titulo[index],
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: this.isBlack ? Colors.black : Colors.white),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            descricao[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: this.isBlack ? Colors.black : Colors.white),
                          ),
                        )
                      ]),
                );
              },
            ),
          ),
          Container(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: FlatButton(
                    child: Text("Pular"),
                    onPressed: () async {
                      if (prefs.getBool('firstTime') ?? true)
                        await prefs.setBool('firstTime', false);
                      await Navigator.pushNamedAndRemoveUntil(
                          context, '/menu', (route) => false);
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: titulo.map((url) {
                      int index = titulo.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: paginaAtual == index
                              ? Color.fromRGBO(0, 0, 0, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () async {
                      if (paginaAtual < 4) {
                        await pageController.nextPage(
                            duration: Duration(milliseconds: 200),
                            curve: Curves.bounceIn);
                      } else {
                        if (prefs.getBool('firstTime') ?? true)
                          await prefs.setBool('firstTime', false);
                        await Navigator.pushNamedAndRemoveUntil(
                            context, '/menu', (route) => false);
                      }
                    },
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

Color randomColor() {
  Random rng = new Random();
  return Color.fromRGBO(
      rng.nextInt(256), rng.nextInt(256), rng.nextInt(256), 1);
}
