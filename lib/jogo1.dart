import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                  // RaisedButton(
                  //   color: Colors.lightGreen[400],
                  //   onPressed: () async {
                  //     await Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) => Jogo1Menu()));
                  //   },
                  //   child: Container(
                  //       alignment: Alignment.center,
                  //       width: MediaQuery.of(context).size.width - 100,
                  //       child: Text('Galeria')),
                  // ),
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
  Future<bool> ready;
  @override
  void initState() {
    ready = flameRun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {}
  Future<bool> flameRun() async {
    return true;
  }
}
