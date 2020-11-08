import 'package:flutter/material.dart';
import 'package:improve/ajuda1.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('src/assets/logo_sem_fundo.png',),
              Text('Jogo das Imagens', style: TextStyle(fontSize: 20),),
              SizedBox(height: 50),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Nível:', style: TextStyle(fontSize: 18,),),
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
                  await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Jogo0(nivelSelecionado)), (route) => false);
                  //await Navigator.push(context, MaterialPageRoute(builder: (context) => Jogo0(nivelSelecionado)));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamedAndRemoveUntil(context, '/jogo0', (route) => false);
                  },
                  child: Row(
                    children: [
                      Text('Sair', style: TextStyle(fontSize: 16,color: Colors.black),),
                      Icon(Icons.exit_to_app, size: 30, color: Colors.black,),
                    ],
                  )
                )
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 250,
                      height: 250,
                      color: Colors.red,
                    ),
                    SizedBox(height: 10),
                    Text('Play pro som'),
                    SizedBox(height: 30),
                    Container(
                      width: 250,
                      child: RaisedButton(
                        onPressed: (){
                        },
                        child: Text('Opção 1'),
                      ),
                    ),
                    Container(
                      width: 250,
                      child: RaisedButton(
                        onPressed: (){
                        },
                        child: Text('Opção 2'),
                      ),
                    ),
                    Container(
                      width: 250,
                      child: RaisedButton(
                        onPressed: (){
                        },
                        child: Text('Opção 3'),
                      ),
                    ),
                    Container(
                      width: 250,
                      child: RaisedButton(
                        onPressed: (){
                        },
                        child: Text('Opção 4'),
                      ),
                    ),
                  ]
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////

class Jogo0Galeria extends StatefulWidget {
  @override
  _Jogo0GaleriaState createState() => _Jogo0GaleriaState();
}

class _Jogo0GaleriaState extends State<Jogo0Galeria> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.yellowAccent,
      ),
    );
  }
}