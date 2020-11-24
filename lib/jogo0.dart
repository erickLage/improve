import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:improve/main.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;


enum TtsState { playing, stopped, paused, continued }

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
                      await Navigator.pushNamed(context, '/tutorial1');
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
    'bebedouro', 'cadeira', 'reunião', 'mesa', 'papéis', 'caneta',
  ];
  Map resposta = {};
  int fase = 0;
  Color selectedColor;
  bool isTextBlack;
  int pontuacao = 0;
  Stopwatch tempo = new Stopwatch();

  FlutterTts audio;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  String _newVoiceText;
  TtsState ttsState = TtsState.stopped;

  TextEditingController textEditingController = new TextEditingController();
  String respostaUser = '';

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  get isPaused => ttsState == TtsState.paused;

  get isContinued => ttsState == TtsState.continued;

  @override
  void initState(){
    opcoes = embaralhaOpcoes(opcoes);
    resposta = escolherResposta(opcoes.sublist(0, 4));
    initTts();
    super.initState();
  }

  initTts() {
    audio = FlutterTts();

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        _getEngines();
      }
    }

    audio.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    audio.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    audio.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    if (kIsWeb || Platform.isIOS) {
      audio.setPauseHandler(() {
        setState(() {
          print("Paused");
          ttsState = TtsState.paused;
        });
      });

      audio.setContinueHandler(() {
        setState(() {
          print("Continued");
          ttsState = TtsState.continued;
        });
      });
    }

    audio.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getEngines() async {
    var engines = await audio.getEngines;
    if (engines != null) {
      for (dynamic engine in engines) {
        print(engine);
      }
    }
  }

  Future _speak() async {

    await audio.setPitch(1);
    await audio.setSpeechRate(1);
    await audio.setLanguage('pt-BR');
    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        await audio.awaitSpeakCompletion(true);
        await audio.speak(_newVoiceText);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    audio.stop();
  }

  @override
  void didChangeDependencies() {
    selectedColor = Theme.of(context).primaryColor;
    isTextBlack = (selectedColor.red + selectedColor.green + selectedColor.blue) > 382.5 || (selectedColor.green > selectedColor.red + selectedColor.blue && selectedColor.green > 170);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.nivel) {
      case 0:
        tempo.start();
        _newVoiceText = opcoes[fase+resposta['index']];
        return nivelFacil();
        break;
      case 1:
        tempo.start();
        return nivelMedio();
        break;
      case 2:
        return nivelDificil();
        break;
      default:
        return null;
    }
  }
  
  Widget nivelFacil(){
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
                        child: Image.asset('src/jogoImagens/'+nomeArquivo(resposta['palavra'])+'.jpg', fit: BoxFit.cover,),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                          children: [
                            _buildButtonColumn(Colors.green, Colors.greenAccent,
                            Icons.play_arrow, 'Ouvir som', _speak),
                          ]
                        )
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: 250,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 4,
                          itemBuilder: (context, index){
                            return Container(
                              width: 250,
                              child: RaisedButton(
                                onPressed: () async{
                                  tempo.stop();
                                  if(resposta['index'] == index){
                                    pontuacao+= 60 - ((tempo.elapsed.inSeconds < 60) ? tempo.elapsed.inSeconds : 60);
                                  }else{
                                    await showDialog(
                                      context: context,
                                      builder: (context){
                                        return AlertDialog(
                                          
                                          content: Text('Infelizmente não foi desta vez.\nA resposta certa era: ${resposta['palavra']}'),
                                          actions: [
                                            FlatButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                              }, 
                                              child: Text('Ok')
                                            ),
                                          ],
                                        );
                                      }
                                    );
                                  }
                                  tempo.reset();
                                  if(fase < 16){
                                    setState(() {
                                      fase+=4;
                                      resposta = escolherResposta(opcoes.sublist(fase, fase+4));
                                    });
                                  }else{
                                    await showDialog(
                                      context: context,
                                      builder: (context){
                                        return AlertDialog(
                                          backgroundColor: selectedColor,
                                          title: Text('Fim de jogo', style: TextStyle(color: isTextBlack ? Colors.black : Colors.white)),
                                          content: Container(
                                            child: Text('${user.getName()}, sua pontuação foi de: $pontuacao', style: TextStyle(color: isTextBlack ? Colors.black : Colors.white))
                                          ),
                                          actions: [
                                            FlatButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                              }, 
                                              child: Text('Ok', style: TextStyle(color: isTextBlack ? Colors.black : Colors.white))
                                            ),
                                          ],
                                        );
                                      }
                                    );
                                    user.setPontuacoes({
                                      'jogo': 0,
                                      'nivel': 0,
                                      'pontuacao': pontuacao,
                                      'data': Timestamp.fromDate(DateTime.now()),
                                    });
                                    await user.saveFirestore();
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text(opcoes[fase+index], style: TextStyle(color: isTextBlack ? Colors.black : Colors.white)),
                                color: selectedColor,
                              ),
                            );
                          }
                        ),
                      ),
                    ]
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Text('${(fase/4).round()+1}/5', style: TextStyle(fontSize: 16,color: Colors.black),),        
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

  Widget nivelMedio(){
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
                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                        ),
                        child: Text(resposta['palavra'], textAlign: TextAlign.center, style: TextStyle(fontSize: 26),)
                      ),
                      SizedBox(height: 50),
                      Text('Qual é a imagem correta?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (context, index){
                            String imagem1 = nomeArquivo(opcoes[fase+index]);
                            String imagem2 = nomeArquivo(opcoes[fase+index+2]);                      
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap:() async{
                                    tempo.stop();
                                    if(resposta['index'] == index){
                                      pontuacao+= 60 - ((tempo.elapsed.inSeconds < 60) ? tempo.elapsed.inSeconds : 60);
                                    }else{
                                      await showDialog(
                                        context: context,
                                        builder: (context){
                                          return AlertDialog( 
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children:[
                                                Text('Infelizmente não foi desta vez.\nA resposta certa era: ${resposta['palavra']}'),
                                                SizedBox(height: 10),
                                                Container(   
                                                  child: Image.asset('src/jogoImagens/'+nomeArquivo(resposta['palavra'])+'.jpg', fit: BoxFit.cover),
                                                  width: MediaQuery.of(context).size.width/2.2,
                                                  height: MediaQuery.of(context).size.width/2.2,
                                                ),
                                              ]
                                            ),
                                            actions: [
                                              FlatButton(
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                }, 
                                                child: Text('Ok')
                                              ),
                                            ],
                                          );
                                        }
                                      );
                                    }
                                    tempo.reset();
                                    if(fase < 16){
                                      setState(() {
                                        fase+=4;
                                        resposta = escolherResposta(opcoes.sublist(fase, fase+4));
                                      });
                                    }else{
                                      pontuacao = (pontuacao * 1.2).round();
                                      await showDialog(
                                        context: context,
                                        builder: (context){
                                          return AlertDialog(
                                            backgroundColor: selectedColor,
                                            title: Text('Fim de jogo', style: TextStyle(color: isTextBlack ? Colors.black : Colors.white)),
                                            content: Container(
                                              child: Text('${user.getName()}, sua pontuação foi de: $pontuacao', style: TextStyle(color: isTextBlack ? Colors.black : Colors.white))
                                            ),
                                            actions: [
                                              FlatButton(
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                }, 
                                                child: Text('Ok', style: TextStyle(color: isTextBlack ? Colors.black : Colors.white))
                                              ),
                                            ],
                                          );
                                        }
                                      );
                                      user.setPontuacoes({
                                        'jogo': 0,
                                        'nivel': 1,
                                        'pontuacao': pontuacao,
                                        'data': Timestamp.fromDate(DateTime.now()),
                                      });
                                      await user.saveFirestore();
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 5, 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 3, color: Theme.of(context).primaryColor),
                                      ),
                                      child: Image.asset('src/jogoImagens/'+imagem1+'.jpg', fit: BoxFit.cover),
                                      width: MediaQuery.of(context).size.width/2.2,
                                      height: MediaQuery.of(context).size.width/2.2,
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap:() async{
                                    tempo.stop();
                                    if(resposta['index'] == index+2){
                                      pontuacao+= 60 - ((tempo.elapsed.inSeconds < 60) ? tempo.elapsed.inSeconds : 60);
                                    }else{
                                      await showDialog(
                                        context: context,
                                        builder: (context){
                                          return AlertDialog(                                      
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children:[
                                                Text('Infelizmente não foi desta vez.\nA resposta certa era: ${resposta['palavra']}'),
                                                SizedBox(height: 10),
                                                Container(   
                                                  child: Image.asset('src/jogoImagens/'+nomeArquivo(resposta['palavra'])+'.jpg', fit: BoxFit.cover),
                                                  width: MediaQuery.of(context).size.width/2.2,
                                                  height: MediaQuery.of(context).size.width/2.2,
                                                ),
                                              ]
                                            ),
                                            actions: [
                                              FlatButton(
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                }, 
                                                child: Text('Ok')
                                              ),
                                            ],
                                          );
                                        }
                                      );
                                    }
                                    tempo.reset();
                                    if(fase < 16){
                                      setState(() {
                                        fase+=4;
                                        resposta = escolherResposta(opcoes.sublist(fase, fase+4));
                                      });
                                    }else{
                                      pontuacao = (pontuacao * 1.2).round();
                                      await showDialog(
                                        context: context,
                                        builder: (context){
                                          return AlertDialog(
                                            backgroundColor: selectedColor,
                                            title: Text('Fim de jogo', style: TextStyle(color: isTextBlack ? Colors.black : Colors.white)),
                                            content: Container(
                                              child: Text('${user.getName()}, sua pontuação foi de: $pontuacao', style: TextStyle(color: isTextBlack ? Colors.black : Colors.white))
                                            ),
                                            actions: [
                                              FlatButton(
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                }, 
                                                child: Text('Ok :)', style: TextStyle(color: isTextBlack ? Colors.black : Colors.white))
                                              ),
                                            ],
                                          );
                                        }
                                      );
                                      user.setPontuacoes({
                                        'jogo': 0,
                                        'nivel': 1,
                                        'pontuacao': pontuacao,
                                        'data': Timestamp.fromDate(DateTime.now()),
                                      });
                                      await user.saveFirestore();
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 5, 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 3, color: Theme.of(context).primaryColor),
                                      ),
                                      child: Image.asset('src/jogoImagens/'+imagem2+'.jpg', fit: BoxFit.cover),
                                      width: MediaQuery.of(context).size.width/2.2,
                                      height: MediaQuery.of(context).size.width/2.2,
                                    ),
                                  ),
                                ),
                              ]
                            );
                          }
                        ),
                      ),
                    ]
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Text('${(fase/4).round()+1}/5', style: TextStyle(fontSize: 16,color: Colors.black),),        
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

  Widget nivelDificil(){
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Center(
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
                            child: Image.asset('src/jogoImagens/'+nomeArquivo(resposta['palavra'])+'.jpg', fit: BoxFit.cover,),
                          ),                   
                          SizedBox(height: 50),
                          Container(
                            width: 250,
                            child: TextField(
                              controller: textEditingController,
                              decoration: InputDecoration(
                                hintText: 'Escreva o nome da imagem'
                              ),
                              onChanged: (s){
                                respostaUser = s;
                              }
                            )
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                            onPressed: () async{
                              if(respostaUser.toLowerCase() == resposta['palavra']){
                                pontuacao+= 60;
                              }else if(semAcento(respostaUser.toLowerCase()) == semAcento(resposta['palavra'])){
                                pontuacao+=30;
                              }else{
                                await showDialog(
                                  context: context,
                                  builder: (context){
                                    return AlertDialog(
                                      content: Text('Infelizmente não foi desta vez.\nA resposta certa era: ${resposta['palavra']}'),
                                      actions: [
                                        FlatButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          }, 
                                          child: Text('Ok')
                                        ),
                                      ],
                                    );
                                  }
                                );
                              }
                              respostaUser = '';
                              textEditingController.clear();
                              if(fase < 16){
                                setState(() {
                                  fase+=4;
                                  resposta = escolherResposta(opcoes.sublist(fase, fase+4));
                                });
                              }else{
                                pontuacao = (pontuacao * 1.4).round();
                                await showDialog(
                                  context: context,
                                  builder: (context){
                                    return AlertDialog(
                                      backgroundColor: selectedColor,
                                      title: Text('Fim de jogo', style: TextStyle(color: isTextBlack ? Colors.black : Colors.white)),
                                      content: Container(
                                        child: Text('${user.getName()}, sua pontuação foi de: $pontuacao', style: TextStyle(color: isTextBlack ? Colors.black : Colors.white))
                                      ),
                                      actions: [
                                        FlatButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          }, 
                                          child: Text('Ok', style: TextStyle(color: isTextBlack ? Colors.black : Colors.white))
                                        ),
                                      ],
                                    );
                                  }
                                );
                                user.setPontuacoes({
                                  'jogo': 0,
                                  'nivel': 2,
                                  'pontuacao': pontuacao,
                                  'data': Timestamp.fromDate(DateTime.now()),
                                });
                                await user.saveFirestore();
                                Navigator.pop(context);
                              }
                            },
                            child: Text('Enviar resposta', style: TextStyle(color: isTextBlack ? Colors.black : Colors.white)),
                            color: selectedColor,
                          ),
                        ]
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Text('${(fase/4).round()+1}/5', style: TextStyle(fontSize: 16,color: Colors.black),),        
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

  String nomeArquivo(String palavra){
    String withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž ';
    String withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz_'; 
    for (int i = 0; i < withDia.length; i++) {
      palavra = palavra.replaceAll(withDia[i], withoutDia[i]);
    }
    return palavra;
  }

  String semAcento(String palavra){
    String withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    String withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz'; 
    for (int i = 0; i < withDia.length; i++) {
      palavra = palavra.replaceAll(withDia[i], withoutDia[i]);
    }
    return palavra;
  }

  Map escolherResposta(List<String> items){
    int index = random.nextInt(4);
    String palavra = items[index];
    return {
      'palavra': palavra,
      'index': index,
    };
  }

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon, String label, Function func) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(icon),
          color: color,
          splashColor: splashColor,
          onPressed: () => func()
        ),
        Container(
          margin: const EdgeInsets.only(top: 2.0),
          child: Text(label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: color
            )
          )
        )
      ] 
    );
  }

}

///////////////////////////////////////////////////////////////////////////////

class Jogo0Galeria extends StatefulWidget {
  @override
  _Jogo0GaleriaState createState() => _Jogo0GaleriaState();
}

class _Jogo0GaleriaState extends State<Jogo0Galeria> {

  FlutterTts audio;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  String _newVoiceText;
  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  get isPaused => ttsState == TtsState.paused;

  get isContinued => ttsState == TtsState.continued;

  List<String> opcoes = [
    'computador', 'impressora', 'grampeador', 'elevador', 'régua', 'saída de emergência', 
    'cafeteira', 'crachá', 'calculadora', 'teclado', 'pendrive', 'calendário', 'quadro', 
    'projetor', 'banheiro feminino', 'banheiro masculino', 'escaninho', 'extintor de incêndio',
    'bebedouro', 'cadeira', 'reunião', 'mesa', 'papéis', 'caneta'
  ];
  Color selectedColor;
  bool isTextBlack;

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    audio = FlutterTts();

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        _getEngines();
      }
    }

    audio.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    audio.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    audio.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    if (kIsWeb || Platform.isIOS) {
      audio.setPauseHandler(() {
        setState(() {
          print("Paused");
          ttsState = TtsState.paused;
        });
      });

      audio.setContinueHandler(() {
        setState(() {
          print("Continued");
          ttsState = TtsState.continued;
        });
      });
    }

    audio.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getEngines() async {
    var engines = await audio.getEngines;
    if (engines != null) {
      for (dynamic engine in engines) {
        print(engine);
      }
    }
  }

  Future _speak() async {

    await audio.setPitch(1);
    await audio.setSpeechRate(1);
    await audio.setLanguage('pt-BR');
    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        await audio.awaitSpeakCompletion(true);
        await audio.speak(_newVoiceText);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    audio.stop();
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
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    String imagem1 = nomeArquivo(opcoes[index]);
                    String imagem2 = nomeArquivo(opcoes[index+12]);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async{
                            _newVoiceText = opcoes[index];
                            await showDialog(
                              context: context,
                              builder: (context){
                                return AlertDialog(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                  content: Container(
                                    width: 270,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 250,
                                          child: Image.asset('src/jogoImagens/'+imagem1+'.jpg', fit: BoxFit.cover)
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                                            children: [
                                              _buildButtonColumn(Colors.green, Colors.greenAccent,
                                              Icons.play_arrow, 'Ouvir som', _speak),
                                            ]
                                          )
                                        ),
                                        SizedBox(height: 10),
                                        Text(opcoes[index], style: TextStyle(fontSize: 18),)
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: Text('Voltar'),
                                    )
                                  ],
                                );
                              }
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 5, 10),
                            child: Image.asset('src/jogoImagens/'+imagem1+'.jpg', fit: BoxFit.cover),
                            width: MediaQuery.of(context).size.width/2,
                            height: MediaQuery.of(context).size.width/2,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async{
                            _newVoiceText = opcoes[index+12];
                            await showDialog(
                              context: context,
                              builder: (context){
                                return AlertDialog(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                  content: Container(
                                    width: 270,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 250,
                                          height: 250,
                                          child: Image.asset('src/jogoImagens/'+imagem2+'.jpg', fit: BoxFit.cover)
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                                            children: [
                                              _buildButtonColumn(Colors.green, Colors.greenAccent,
                                              Icons.play_arrow, 'Ouvir som', _speak),
                                            ]
                                          )
                                        ),
                                        SizedBox(height: 10),
                                        Text(opcoes[index+12], style: TextStyle(fontSize: 20),)
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: Text('Voltar'),
                                    )
                                  ],
                                );
                              }
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5, 0, 10, 10),
                            child: Image.asset('src/jogoImagens/'+imagem2+'.jpg', fit: BoxFit.cover),
                            width: MediaQuery.of(context).size.width/2,
                            height: MediaQuery.of(context).size.width/2,
                          ),
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

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon, String label, Function func) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(icon),
          color: color,
          splashColor: splashColor,
          onPressed: () => func()
        ),
        Container(
          margin: const EdgeInsets.only(top: 2.0),
          child: Text(label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: color
            )
          )
        )
      ] 
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