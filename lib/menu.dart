import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:improve/Classes/user.dart';
import 'package:improve/main.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.help_outline, size: 34),
        onPressed: () async {
          await Navigator.pushNamed(context, '/ajuda');
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Image.asset('src/assets/logo_sem_fundo.png'),
              ),
              SizedBox(
                height: 80,
              ),
              Visibility(
                visible: user != null && user.getID() != '-1',
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Bem vindo, " + user.getName(),
                    style: TextStyle(fontSize: 18, color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              RaisedButton(
                color: Colors.blue,
                onPressed: () async {
                  if(user == null || user.getID() == '-1'){
                    await Navigator.pushNamed(context, '/login');
                  }else{
                    await FirebaseAuth.instance.signOut();
                    setState((){
                      user = new User();
                    });
                  }
                },
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Text(user == null || user.getID() == '-1'
                        ? 'Entrar'
                        : 'Sair da conta')),
              ),      
              RaisedButton(
                color: Colors.lightGreen[400],
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.all(2),
                        content: Container(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage('src/jogoImagens/jogo_das_imagens.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        onTap: () async{
                                          if (prefs.getBool(
                                                  'firstTimePlaying') ??
                                              true)
                                            await Navigator.pushNamed(
                                                context, '/ajuda1',
                                                arguments: '/jogo0');
                                          else
                                            await Navigator.pushNamed(
                                                context, '/jogo0');
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Jogo Das Imagens',
                                        style: TextStyle(fontSize: 14, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage('src/jogoIteracoes/jogo_das_iteracoes.jpg'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          if (prefs.getBool(
                                                  'firstTimePlaying') ??
                                              true)
                                            Navigator.pushNamed(
                                                context, '/ajuda1',
                                                arguments: '/jogo1');
                                          else
                                            Navigator.pushNamed(
                                                context, "/jogo1");
                                        },
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Jogo Das Interações',
                                        style: TextStyle(fontSize: 14, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          IconButton(
                            icon: Icon(Icons.help),
                            onPressed: () {
                              Navigator.pushNamed(context, '/ajuda1', arguments: 'menu');
                            }
                          )
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Text('Jogar')
                ),
              ),
              RaisedButton(
                color: Colors.cyan,
                onPressed: () {
                  Navigator.pushNamed(context, '/pontuacao', arguments: user);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Text('Ver pontuação')
                ),
              ),
              RaisedButton(
                color: Colors.pink[300],
                onPressed: () {
                  Navigator.pushNamed(context, '/personaliza');
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Text('Personalizar')
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
