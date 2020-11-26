import 'package:flutter/material.dart';
import 'package:improve/Classes/user.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class Pontuacao extends StatefulWidget {
  _PontuacaoState createState() => _PontuacaoState();
}

class _PontuacaoState extends State<Pontuacao> {

  User user;
  List<Map> pontuacoes = []; 
  List<Map> pontuacaoImagens = [];
  List<Map> pontuacaoInteracoes = [];

  @override
  void didChangeDependencies() {
    user = ModalRoute.of(context).settings.arguments;
    pontuacoes = [];
    pontuacaoImagens = [];
    pontuacaoInteracoes = [];
    pontuacoes = user.getPontuacoes();
    pontuacoes.sort((a, b) => b['pontuacao'] - a['pontuacao'] );
    pontuacoes.forEach((element) { 
      if(element['jogo'] == 0){
        pontuacaoImagens.add(element);
      }
      else{
        pontuacaoInteracoes.add(element);
      }
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: user.getID() != '-1' 
          ? FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.share, size: 34),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    titlePadding: EdgeInsets.symmetric(vertical: 10),
                    title: Center(child: Text('Compartilhe sua pontuação', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)),
                    content: Container(
                      child: Text('Compartilhe suas 5 melhores pontuações de cada jogo.', style: TextStyle(color: Colors.black)),
                    ),
                    actions: [
                      FlatButton(
                        onPressed: () async{
                          Navigator.pop(context);
                        }, 
                        child: Text('Sair')
                      ),
                      FlatButton(
                        onPressed: () async{
                          String pontuacoesImagens = '';
                          for(int i = 0; i<5 && i<pontuacaoImagens.length; i++) pontuacoesImagens+='\t\t${i+1}- ${pontuacaoImagens[i]['pontuacao']}\n';
                          String pontuacoesInteracoes = '';
                          for(int i = 0; i<5 && i<pontuacaoInteracoes.length; i++) pontuacoesInteracoes+='\t\t${i+1}- ${pontuacaoInteracoes[i]['pontuacao']}\n';
                          Share.text('Pontuação do '+user.getName(), 
                          'Confira minhas melhores pontuações no Improve:\n\n\t- Jogo das Imagens:\n' + pontuacoesImagens + '\n\t- Jogo das Interações:\n' + pontuacoesInteracoes, 
                          'text/plain');
                        }, 
                        child: Text('Compartilhar')
                      ),
                    ],
                  );
                }
              );
            },
          )
          : null,
        appBar: AppBar(
          title: Text('Pontuação'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Jogo das imagens'),
              Tab(text: 'Jogo das interações'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            jogoImagens(),
            jogoInteracao()
          ],
        )
      ),
    );
  }

  Widget jogoImagens(){
    return Container(
      child: ListView.builder(
        itemCount: pontuacaoImagens?.length ?? 0,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index){
          String nivel = 'Fácil';
          if(pontuacaoImagens[index]['nivel'] == 1){
            nivel = 'Médio';
          }
          else{
            if(pontuacaoImagens[index]['nivel'] == 2){
              nivel = 'Difícil';
            }
          }
          return Card(
            elevation: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              height: 50,
              child: Row(
                children: [
                  Text((index+1).toString() + 'º', style: TextStyle(fontSize: 22, color:Colors.black)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  Text(pontuacaoImagens[index]['pontuacao'].toString(), style: TextStyle(fontSize: 18, color: Colors.black)),
                  Expanded(child: SizedBox()),
                  Text(nivel, style: TextStyle(fontSize: 14, color: Colors.black))
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  Widget jogoInteracao(){
    return Container(
      child: ListView.builder(
        itemCount: pontuacaoInteracoes?.length ?? 0,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index){
          return Card(
            elevation: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              height: 50,
              child: Row(
                children: [
                  Text((index+1).toString() + 'º', style: TextStyle(fontSize: 22, color: Colors.black)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  Text(pontuacaoInteracoes[index]['pontuacao'].toString(), style: TextStyle(fontSize: 18, color: Colors.black)),
                  Expanded(child: SizedBox()),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
