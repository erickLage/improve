import 'dart:math';
import 'package:flutter/material.dart';
import 'package:improve/main.dart';

class Ajuda1 extends StatefulWidget {
  final int pagina;
  final bool isBlack;
  Ajuda1(this.isBlack, {this.pagina});
  _Ajuda1State createState() => _Ajuda1State(isBlack);
}

class _Ajuda1State extends State<Ajuda1> {
  final bool isBlack;
  int paginaAtual;
  String jogo;
  PageController pageController;
  List<String> titulo;
  List<dynamic> descricao;
  List<Widget> icones;

  _Ajuda1State(this.isBlack){
    pageController =
      new PageController(initialPage: 0, viewportFraction: 1);
    paginaAtual = 0;
    jogo = '';
    titulo = [
      'Tutoriais',
      'Jogo das Imagens',
      'Jogo das Interações',
    ];
    descricao = [
      Text(
        'Aprenda a como jogar os jogos propostos',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: this.isBlack ? Colors.black : Colors.white),
      ),
      Column(
        children: [
          RichText(    
            text: TextSpan( text: 'Fácil: ', style: TextStyle(fontSize: 18, color: this.isBlack ? Colors.black : Colors.white, fontWeight: FontWeight.bold), 
              children: <TextSpan>[
                TextSpan(text: 'Marque a palavra que descreve a imagem. \n', style: TextStyle(fontSize: 16, color: this.isBlack ? Colors.black : Colors.white)),
              ],
            ),
            textAlign: TextAlign.left,
          ),
          RichText(    
            text: TextSpan(text: 'Médio: ', style: TextStyle(fontSize: 18, color: this.isBlack ? Colors.black : Colors.white, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(text: 'Marque a imagem de acordo com o texto. \n', style: TextStyle(fontSize: 16, color: this.isBlack ? Colors.black : Colors.white)),
              ],
            ),
            textAlign: TextAlign.left,    
          ),
          RichText(    
            text: TextSpan(text: 'Difícil: ', style: TextStyle(fontSize: 18, color: this.isBlack ? Colors.black : Colors.white, fontWeight: FontWeight.bold), 
              children: <TextSpan>[
                TextSpan(text: 'Escreva o que representa a imagem.', style: TextStyle(fontSize: 16, color: this.isBlack ? Colors.black : Colors.white)),
              ],
            ),
            textAlign: TextAlign.left,       
          ),
        ],
      ),
      Text(
        'Combine objetos para completar tarefas',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: this.isBlack ? Colors.black : Colors.white),
      ),
    ];
    icones = [
      Icon(Icons.accessibility, size: 100, color: this.isBlack ? Colors.black : Colors.white),
      Icon(Icons.collections_outlined, size: 100, color: this.isBlack ? Colors.black : Colors.white),
      Icon(Icons.gamepad, size: 100, color: this.isBlack ? Colors.black : Colors.white),
    ];
  }

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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icones[widget.pagina],
                      Text(
                        titulo[widget.pagina],
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: this.isBlack ? Colors.black : Colors.white
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: descricao[widget.pagina],
                      )
                    ]
                  ),
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
                        Icon(Icons.chevron_left, size: 30, color: this.isBlack ? Colors.black : Colors.white,),
                        Text('Voltar', style: TextStyle(fontSize: 16,color: this.isBlack ? Colors.black : Colors.white),),        
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
                itemCount: 3,
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
                            child: descricao[index],   
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
                        if (paginaAtual < 2) {
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
