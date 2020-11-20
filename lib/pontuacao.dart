import 'package:flutter/material.dart';
import 'package:improve/Classes/user.dart';

class Pontuacao extends StatefulWidget {
  _PontuacaoState createState() => _PontuacaoState();
}

class _PontuacaoState extends State<Pontuacao> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pontuação'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Jogo das imagens'),
              Tab(text: 'Ache o chefinho'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            jogoImagens(),
            jogo1()
          ],
        )
      ),
    );
  }

  Widget jogoImagens(){
    return Container(color: Colors.red);
  }

  Widget jogo1(){
    return Container(color: Colors.blue);
  }
}
