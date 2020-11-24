import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:improve/main.dart';

class Jogo1Menu extends StatefulWidget {
  @override
  _Jogo1MenuState createState() => _Jogo1MenuState();
}

class _Jogo1MenuState extends State<Jogo1Menu> {
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
                  Image.asset(
                    'src/assets/logo_sem_fundo.png',
                  ),
                  Text(
                    'Jogo das Interações',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Nível:',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 62,
                        child: RaisedButton(
                          onPressed: () {
                            if (nivelSelecionado != 0) {
                              setState(() {
                                nivelSelecionado = 0;
                              });
                            }
                          },
                          child: Text('Fácil'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: nivelSelecionado != 0
                                      ? Colors.white
                                      : Colors.red)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 72,
                        child: RaisedButton(
                          onPressed: () {
                            if (nivelSelecionado != 1) {
                              setState(() {
                                nivelSelecionado = 1;
                              });
                            }
                          },
                          child: Text('Médio'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: nivelSelecionado != 1
                                      ? Colors.white
                                      : Colors.red)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 68,
                        child: RaisedButton(
                          onPressed: () {
                            if (nivelSelecionado != 2) {
                              setState(() {
                                nivelSelecionado = 2;
                              });
                            }
                          },
                          child: Text('Difícil'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: nivelSelecionado != 2
                                      ? Colors.white
                                      : Colors.red)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () async {
                      //await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Jogo0(nivelSelecionado)), (route) => false);
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Jogo1(nivelSelecionado)));
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 100,
                        child: Text('Jogar')),
                  ),
                  RaisedButton(
                    color: Colors.pink[300],
                    onPressed: () async {
                      await Navigator.pushNamed(context, '/tutorial2');
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
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.chevron_left,
                            size: 30,
                            color: Colors.black,
                          ),
                          Text(
                            'Voltar',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////
class Jogo1 extends StatefulWidget {
  final int nivel;
  Jogo1(this.nivel);
  _Jogo1State createState() => _Jogo1State();
}

class _Jogo1State extends State<Jogo1> {

  final Random random = new Random();

  Color selectedColor;
  bool isTextBlack;

  int pontuacaoTotal = 0;
  int qntErro = 0;

  Stopwatch tempo = new Stopwatch();

  List<String> opcoes = [
    'computador', 'impressora', 'grampeador', 'elevador', 'regua', 'saida_de_emergencia', 
    'cafeteira', 'cracha', 'calculadora', 'teclado', 'pendrive', 'calendario', 'quadro', 
    'projetor', 'banheiro_feminino', 'banheiro_masculino', 'escaninho', 'extintor_de_incendio',
    'bebedouro', 'cadeira', 'reuniao', 'mesa', 'papeis', 'caneta', 'canetao', 'mochila',
    'maquinaponto', 'garrafinha', 'mouse', 'xicara', 'contrato'
  ];

  
  List<Map> prompts = [
    {'prompt': 'Bata o ponto', 'arrastavel': 'cracha', 'itemAlvo': 'maquinaponto'},
    {'prompt': 'Escreva um recado no quadro', 'arrastavel': 'canetao', 'itemAlvo': 'quadro'},
    {'prompt': 'Encha a garrafinha de agua', 'arrastavel': 'garrafinha', 'itemAlvo': 'bebedouro'},
    {'prompt': 'Assine o contrato', 'arrastavel': 'caneta', 'itemAlvo': 'contrato'},
    {'prompt': 'Conecte o mouse ao computador', 'arrastavel': 'mouse', 'itemAlvo': 'computador'},
    {'prompt': 'Busque um xícara de café', 'arrastavel': 'xicara', 'itemAlvo': 'cafeteira'},
    {'prompt': 'Guarde sua mochila no escaninho', 'arrastavel': 'mochila', 'itemAlvo': 'escaninho'},
    {'prompt': 'Reponha o papeis na impressora', 'arrastavel': 'papeis', 'itemAlvo': 'impressora'},
    {'prompt': 'Grampeie os papeis', 'arrastavel': 'grampeador', 'itemAlvo': 'papeis'},
    {'prompt': 'O computador está pegando fogo!', 'arrastavel': 'extintor_de_incendio', 'itemAlvo': 'computador'},
    {'prompt': 'A impressora está pegando fogo!', 'arrastavel': 'extintor_de_incendio', 'itemAlvo': 'impressora'},
    {'prompt': 'Conecte o teclado ao computador', 'arrastavel': 'teclado', 'itemAlvo': 'computador'},
    {'prompt': 'Ligue o projetor na sala de reuniões', 'arrastavel': 'projetor', 'itemAlvo': 'reuniao'},
    {'prompt': 'Conecte o pendrive ao computador', 'arrastavel': 'pendrive', 'itemAlvo': 'computador'},
  ];

  List<String> alternativas1 = new List<String>(13);
  List<String> alternativas2 = new List<String>(13);
  List<String> alternativas3 = new List<String>(13);
  
  Color corInicial = Colors.grey;

  int round = 0;

  @override
  void initState() {
    prompts = embaralhaOpcoes(prompts);
    preencheAlternativa();
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
    tempo.start();
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 100),
            Text(prompts[round]['prompt'], style: TextStyle(fontSize: 16)),
            Container(
              padding: EdgeInsets.all(10),
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(5),
                  color: Theme.of(context).accentColor,
                  child: Draggable<String>(
                    data: prompts[round]['itemAlvo'],
                    child: Container(
                      height: 75,
                      width: 75,
                      child: Image.asset('src/jogoImagens/${prompts[round]['arrastavel']}.jpg', fit: BoxFit.cover,),
                    ),
                    childWhenDragging: Container(
                      height: 75,
                      width: 75,
                      color: Colors.grey
                    ),
                    feedback:  Container(
                      height: 75,
                      width: 75,
                      child: Image.asset('src/jogoImagens/${prompts[round]['arrastavel']}.jpg', fit: BoxFit.cover,),
                    ),
                  ),
                )
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    color: Theme.of(context).accentColor,
                    child: DragTarget<String>(
                      onWillAccept: (data) => round < 4,
                      onAccept: (data) async{
                        setState(() {
                          if(data.compareTo(alternativas1[round]) == 0){
                            corInicial = Colors.green;
                            tempo.stop();
                            pontuacaoTotal+= 60 - ((tempo.elapsed.inSeconds < 60) ? tempo.elapsed.inSeconds : 60);
                            tempo.reset();
                            round++;
                          }
                          else{
                            corInicial = Colors.red;
                            qntErro++;
                          }
                        });
                        if(round >= 4){
                          await mostraPontuacao();
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, color, list){
                        return Container(
                          height: 100,
                          width: 100,
                          child: Image.asset('src/jogoImagens/${alternativas1[round]}.jpg', fit: BoxFit.cover)
                        );
                      },
                    )
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    color: Theme.of(context).accentColor,
                    child: DragTarget<String>(
                      onWillAccept: (data) => round < 4,
                      onAccept: (data) async{
                        setState(() {
                          if(data.compareTo(alternativas2[round]) == 0){
                            corInicial = Colors.green;
                            tempo.stop();
                            pontuacaoTotal+= 60 - ((tempo.elapsed.inSeconds < 60) ? tempo.elapsed.inSeconds : 60);
                            tempo.reset();
                            round++;
                          }
                          else{
                            corInicial = Colors.red;
                            qntErro++;
                          }
                        });
                        if(round >= 4){
                          await mostraPontuacao();
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, color, list){
                        return Container(
                          height: 100,
                          width: 100,
                          child: Image.asset('src/jogoImagens/${alternativas2[round]}.jpg', fit: BoxFit.cover,),
                        );
                      },
                    )
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    color: Theme.of(context).accentColor,
                    child: DragTarget<String>(
                      onWillAccept: (data) => round < 4,
                      onAccept: (data) async{
                        setState(() {
                          if(data.compareTo(alternativas3[round]) == 0){
                            corInicial = Colors.green;
                            tempo.stop();
                            pontuacaoTotal+= 60 - ((tempo.elapsed.inSeconds < 60) ? tempo.elapsed.inSeconds : 60);
                            tempo.reset();
                            round++;
                          }
                          else{
                            corInicial = Colors.red;
                            qntErro++;
                          }
                        });
                        if(round >= 4){
                          await mostraPontuacao();
                          Navigator.pop(context);
                        }
                      },
                      builder: (context, color, list){
                        return Container(
                          height: 100,
                          width: 100,
                          child: Image.asset('src/jogoImagens/${alternativas3[round]}.jpg', fit: BoxFit.cover,),
                        );
                      },
                    )
                  ),
                ],
              ),
            ),
            Container(
              color: corInicial,
              height: 100,
              width: 100,
            )
          ],
        ),
      )
    );
  }

  List<Map> embaralhaOpcoes(List<Map> items){
    for (int i = items.length - 1; i > 0; i--) {

      int n = random.nextInt(i + 1);

      Map temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }
  void preencheAlternativa(){
    for(int i = 0;i < 13;i++){
      String alt;
      do{
        int n = random.nextInt(opcoes.length);
        alt = opcoes[n];
      }while(alt.compareTo(prompts[i]['itemAlvo']) == 0 || alt.compareTo(prompts[i]['arrastavel']) == 0);
      alternativas1[i] = alt;
      do{
        int n = random.nextInt(opcoes.length);
        alt = opcoes[n];
      }while(alt.compareTo(prompts[i]['itemAlvo']) == 0 || alt.compareTo(prompts[i]['arrastavel']) == 0 || alt.compareTo(alternativas1[i]) == 0);
      alternativas2[i] = alt;
      do{
        int n = random.nextInt(opcoes.length);
        alt = opcoes[n];
      }while(alt.compareTo(prompts[i]['itemAlvo']) == 0 || alt.compareTo(prompts[i]['arrastavel']) == 0 || alt.compareTo(alternativas1[i]) == 0 || alt.compareTo(alternativas2[i]) == 0);
      alternativas3[i] = alt;
      switch(random.nextInt(3)){
        case 0:
          alternativas1[i] = prompts[i]['itemAlvo'];
          break;
        case 1:
          alternativas2[i] = prompts[i]['itemAlvo'];
          break;
        case 2:
          alternativas3[i] = prompts[i]['itemAlvo'];
          break;
      }
      
    }
  }

  Future<void> mostraPontuacao() async{
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: selectedColor,
          title: Text('Fim de jogo', style: TextStyle(color: isTextBlack ? Colors.black : Colors.white)),
          content: Container(
            child: Text('${user.getName()}, sua pontuação foi de: ${pontuacaoTotal - qntErro*5 > 0 ? pontuacaoTotal - 5*qntErro : 0}', style: TextStyle(color: isTextBlack ? Colors.black : Colors.white))
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
      },
    );
    user.setPontuacoes({
      'jogo': 1,
      'nivel': 0,
      'pontuacao': pontuacaoTotal,
      'data': Timestamp.fromDate(DateTime.now()),
    });
    await user.saveFirestore();
  }
}




Color randomColor() {
  Random rng = new Random();
  return Color.fromRGBO(
      rng.nextInt(256), rng.nextInt(256), rng.nextInt(256), 1);
}
