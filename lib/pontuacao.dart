import 'package:flutter/material.dart';
import 'package:improve/Classes/user.dart';

class Pontuacao extends StatefulWidget {
  _PontuacaoState createState() => _PontuacaoState();
}

class _PontuacaoState extends State<Pontuacao> {

  User user;
  List<Map> pontuacoes; 

  @override
  void didChangeDependencies() {
    user = ModalRoute.of(context).settings.arguments;
    pontuacoes = user.getPontuacoes();
    pontuacoes.sort((a, b) => b['pontuacao'] - a['pontuacao'] );
    super.didChangeDependencies();
  }
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
              Tab(text: 'Jogo das iterações'),
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
    return Container(
      child: ListView.builder(
        itemCount: pontuacoes.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index){
          return Card(
            elevation: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              height: 50,
              child: Row(
                children: [
                  Text((index+1).toString() + 'º', style: TextStyle(fontSize: 22)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  Text(pontuacoes[index]['pontuacao'].toString(), style: TextStyle(fontSize: 18)),
                  Expanded(child: SizedBox()),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Widget jogo1(){
    return Container(color: Colors.blue);
  }
}
