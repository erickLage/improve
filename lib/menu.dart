import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'src/assets/logo_sem_fundo.png'
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                color: Colors.blue,
                onPressed: (){
                  
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Text('Jogar')
                ),
              ),
              RaisedButton(
                color: Colors.lightGreen[400],
                onPressed: (){
                  Navigator.pushNamed(context, '/cadastro');
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Text('Cadastre-se')
                ),
              ),
              RaisedButton(
                color: Colors.cyan,
                onPressed: (){
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Text('Ver pontuação')
                ),
              ),
              RaisedButton(
                color: Colors.pink[300],
                onPressed: (){
                  
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
      )
    );
  }
}