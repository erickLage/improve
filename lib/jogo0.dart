import 'dart:math';
import 'package:flutter/material.dart';

class Jogo0Menu extends StatefulWidget {
  @override
  _Jogo0MenuState createState() => _Jogo0MenuState();
}

class _Jogo0MenuState extends State<Jogo0Menu> {
  int nivelSelecionado = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('src/assets/logo_sem_fundo.png',),
                  Text('Jogo das Imagens', style: TextStyle(fontSize: 20, color: Colors.black),),
                  SizedBox(height: 50),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Nível:', style: TextStyle(fontSize: 18, color: Colors.black),),
                      SizedBox(width: 10),

                      Container(
                        width: 62,
                        child: RaisedButton(
                          onPressed: (){
                            if(nivelSelecionado != 0){
                              setState(() {
                                nivelSelecionado = 0;
                              });
                            }
                          }, 
                          child: Text('Fácil'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: nivelSelecionado != 0 ? Colors.white : Colors.red)
                          ),
                        ),
                      ),
                      SizedBox(width: 10),

                      Container(
                        width: 72,
                        child: RaisedButton(
                          onPressed: (){
                            if(nivelSelecionado != 1){
                              setState(() {
                                nivelSelecionado = 1;
                              });
                            }
                          }, 
                          child: Text('Médio'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: nivelSelecionado != 1 ? Colors.white : Colors.red)
                          ),
                        ),
                      ),
                      SizedBox(width: 10),

                      Container(
                        width: 68,
                        child: RaisedButton(
                          onPressed: (){
                            if(nivelSelecionado != 2){
                              setState(() {
                                nivelSelecionado = 2;
                              });
                            }
                          }, 
                          child: Text('Difícil'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: nivelSelecionado != 2 ? Colors.white : Colors.red)
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () async {
                      //await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Jogo0(nivelSelecionado)), (route) => false);
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => Jogo0(nivelSelecionado)));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 100,
                      child: Text('Jogar')),
                  ),
                  RaisedButton(
                    color: Colors.lightGreen[400],
                    onPressed: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => Jogo0Galeria()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 100,
                      child: Text('Galeria')),
                  ),
                  RaisedButton(
                    color: Colors.pink[300],
                    onPressed: () async {
                      await Navigator.pushNamed(context, '/tutorial0');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 100,
                      child: Text('Tutorial')),
                  ),
                ],
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
                      Icon(Icons.chevron_left, size: 30, color: Colors.black,),
                      Text('Voltar', style: TextStyle(fontSize: 16,color: Colors.black),),        
                    ],
                  )
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

class Jogo0 extends StatefulWidget {
  final int nivel;
  Jogo0(this.nivel);
  _Jogo0State createState() => _Jogo0State();
}

class _Jogo0State extends State<Jogo0> {
  final Random random = new Random();
  List<String> opcoes = [
    'computador', 'impressora', 'grampeador', 'elevador', 'régua', 'saída de emergência', 
    'cafeteira', 'crachá', 'calculadora', 'teclado', 'pendrive', 'calendário', 'quadro', 
    'projetor', 'banheiro feminino', 'banheiro masculino', 'escaninho', 'extintor de incêndio',
    'bebedouro', 'cadeira',
  ];
  Map resposta = {};
  int fase = 0;
  Color selectedColor;
  bool isTextBlack;

  @override
  void initState(){
    opcoes = embaralhaOpcoes(opcoes);
    resposta = escolherResposta(opcoes.sublist(0, 4));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    selectedColor = Theme.of(context).primaryColor;
    isTextBlack = (selectedColor.red + selectedColor.green + selectedColor.blue) > 382.5 || (selectedColor.green > selectedColor.red + selectedColor.blue && selectedColor.green > 170);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                        ),
                        width: 250,
                        height: 250,
                        child: Image.asset('src/jogoImagens/'+resposta['palavra']+'.jpg', fit: BoxFit.cover,),
                      ),
                      SizedBox(height: 10),
                      Text('Play pro som', style: TextStyle(color: Colors.black)),
                      SizedBox(height: 30),
                      Container(
                        width: 250,
                        child: RaisedButton(
                          onPressed: (){
                            if(resposta['index'] == 0){
                              print('Parabéns');
                            }else{
                              print('É uma pena. :(');
                            }
                            if(fase < 16){
                              setState(() {
                                fase+=4;
                                resposta = escolherResposta(opcoes.sublist(fase, fase+4));
                              });
                            }else{
                              Navigator.pop(context);
                            }
                          },
                          child: Text(opcoes[fase], style: TextStyle(color: isTextBlack ? Colors.black : Colors.white)),
                          color: selectedColor,
                        ),
                      ),
                      Container(
                        width: 250,
                        child: RaisedButton(
                          onPressed: (){
                            if(resposta['index'] == 1){
                              print('Parabéns');
                            }else{
                              print('É uma pena. :(');
                            }
                            if(fase < 16){
                              setState(() {
                                fase+=4;
                                resposta = escolherResposta(opcoes.sublist(fase, fase+4));
                              });
                            }else{
                              Navigator.pop(context);
                            }
                          },
                          child: Text(opcoes[fase+1], style: TextStyle(color: isTextBlack ? Colors.black : Colors.white)),
                          color: selectedColor,
                        ),
                      ),
                      Container(
                        width: 250,
                        child: RaisedButton(
                          onPressed: (){
                            if(resposta['index'] == 2){
                              print('Parabéns');
                            }else{
                              print('É uma pena. :(');
                            }                      
                            if(fase < 16){
                              setState(() {
                                fase+=4;
                                resposta = escolherResposta(opcoes.sublist(fase, fase+4));
                              });
                            }else{
                              Navigator.pop(context);
                            }
                          },
                          child: Text(opcoes[fase+2], style: TextStyle(color: isTextBlack ? Colors.black : Colors.white)),
                          color: selectedColor,
                        ),
                      ),
                      Container(
                        width: 250,
                        child: RaisedButton(
                          onPressed: (){
                            if(resposta['index'] == 3){
                              print('Parabéns');
                            }else{
                              print('É uma pena. :(');
                            }
                            if(fase < 16){
                              setState(() {
                                fase+=4;
                                resposta = escolherResposta(opcoes.sublist(fase, fase+4));
                              });
                            }else{
                              Navigator.pop(context);
                            }
                          },
                          child: Text(opcoes[fase+3], style: TextStyle(color: isTextBlack ? Colors.black : Colors.white)),
                          color: selectedColor,
                        ),
                      ),
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
                        Icon(Icons.chevron_left, size: 30, color: Colors.black,),
                        Text('Sair', style: TextStyle(fontSize: 16,color: Colors.black),),        
                      ],
                    )
                  )
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }

  List<String> embaralhaOpcoes(List<String> items){
    for (int i = items.length - 1; i > 0; i--) {

      int n = random.nextInt(i + 1);

      String temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  Map escolherResposta(List<String> items){
    String withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž ';
    String withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz_'; 
    int index = random.nextInt(4);
    String palavra = items[index];
    for (int i = 0; i < withDia.length; i++) {
      palavra = palavra.replaceAll(withDia[i], withoutDia[i]);
    }

    return {
      'palavra': palavra,
      'index': index,
    };
  }

}

///////////////////////////////////////////////////////////////////////////////

class Jogo0Galeria extends StatefulWidget {
  @override
  _Jogo0GaleriaState createState() => _Jogo0GaleriaState();
}

class _Jogo0GaleriaState extends State<Jogo0Galeria> {

  List<String> opcoes = [
    'computador', 'impressora', 'grampeador', 'elevador', 'régua', 'saída de emergência', 
    'cafeteira', 'crachá', 'calculadora', 'teclado', 'pendrive', 'calendário', 'quadro', 
    'projetor', 'banheiro feminino', 'banheiro masculino', 'escaninho', 'extintor de incêndio',
    'bebedouro', 'cadeira',
  ];
  Color selectedColor;
  bool isTextBlack;

  @override
  void didChangeDependencies() {
    selectedColor = Theme.of(context).primaryColor;
    isTextBlack = (selectedColor.red + selectedColor.green + selectedColor.blue) > 382.5 || (selectedColor.green > selectedColor.red + selectedColor.blue && selectedColor.green > 170);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: selectedColor,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    String imagem1 = nomeArquivo(opcoes[index]);
                    String imagem2 = nomeArquivo(opcoes[index+10]);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 5, 10),
                          child: Image.asset('src/jogoImagens/'+imagem1+'.jpg', fit: BoxFit.cover),
                          width: MediaQuery.of(context).size.width/2,
                          height: MediaQuery.of(context).size.width/2,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 10, 10),
                          child: Image.asset('src/jogoImagens/'+imagem2+'.jpg', fit: BoxFit.cover),
                          width: MediaQuery.of(context).size.width/2,
                          height: MediaQuery.of(context).size.width/2,
                        ),
                      ],
                    );
                  },
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
                      Icon(Icons.chevron_left, size: 30, color: isTextBlack ? Colors.black : Colors.white),
                      Text('Voltar', style: TextStyle(fontSize: 16, color: isTextBlack ? Colors.black : Colors.white),),        
                    ],
                  )
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  String nomeArquivo(String item){
    String withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž ';
    String withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz_';

    for (int i = 0; i < withDia.length; i++) {
      item = item.replaceAll(withDia[i], withoutDia[i]);
    }

    return item;
  }

}