import 'dart:math';
import 'package:flutter/material.dart';
import 'package:improve/main.dart';

class Ajuda1 extends StatefulWidget {
  final int pagina;
  Ajuda1({this.pagina});
  _Ajuda1State createState() => _Ajuda1State();
}

class _Ajuda1State extends State<Ajuda1> {
  PageController pageController =
      new PageController(initialPage: 0, viewportFraction: 1);
  int paginaAtual = 0;
  String jogo = '';
  List<String> titulo = [
    'Tutoriais',
    'Cadastre-se',
    'Personalize',
    'Jogue',
    'Pontue e compartilhe'
  ];
  List<String> descricao = [
    'Aprenda a como jogar os jogos propostos',
    'Para começar, cadastre-se na tela inicial, verifique o seu email e depois faça o login.',
    'Personalize o aplicativo de acordo com a suas preferências.',
    'Jogue, divirta-se e aprenda.',
    'Verifique suas melhores pontuações. Se quiser, cadastre as informações de um especialista e compartilhe seus resultados.'
  ];
  List<Widget> icones = [
    Icon(Icons.ac_unit, size: 100, color: Colors.white),
    Icon(Icons.face, size: 100, color: Colors.white),
    Icon(Icons.create, size: 100, color: Colors.white),
    Icon(Icons.ac_unit, size: 100, color: Colors.white),
    Icon(Icons.share, size: 100, color: Colors.white)
  ];

  @override
  void didChangeDependencies() {
    jogo = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.pagina != null){
      return Scaffold(
        body: SafeArea(
          child: Container(
            color: randomColor(),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icones[widget.pagina],
                    Text(
                      titulo[widget.pagina],
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        descricao[widget.pagina],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    )
                  ]
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.chevron_left, size: 30, color: Colors.white,),
                        Text('Voltar', style: TextStyle(fontSize: 16,color: Colors.white),),        
                      ],
                    )
                  )
                ),
              ],
            ),   
          ),
        )
      );
    }
    else return Scaffold(
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
                    color: randomColor(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          icones[index],
                          Text(
                            titulo[index],
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              descricao[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, color: Colors.white),
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
                        if (prefs.getBool('firstTimePlaying') ?? true)
                          await prefs.setBool('firstTimePlaying', false);
                        if (jogo == 'menu')
                          Navigator.pop(context);
                        else
                          await Navigator.popAndPushNamed(context, jogo);
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
                          if (prefs.getBool('firstTimePlaying') ?? true)
                            await prefs.setBool('firstTimePlaying', false);
                          if (jogo == 'menu')
                            Navigator.pop(context);
                          else
                            await Navigator.popAndPushNamed(context, jogo);
                        }
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}

Color randomColor() {
  Random rng = new Random();
  return Color.fromRGBO(
      rng.nextInt(256), rng.nextInt(256), rng.nextInt(256), 1);
}
