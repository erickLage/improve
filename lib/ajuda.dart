import 'dart:math';

import 'package:flutter/material.dart';

class Ajuda extends StatefulWidget {
  @override
  _AjudaState createState() => _AjudaState();
}

class _AjudaState extends State<Ajuda> {
  PageController pageController =
      new PageController(initialPage: 0, viewportFraction: 1);
  List<String> titulo = [
    'Bem vindo ao Improve!',
    'Cadastre-se',
    'Personalize',
    'Jogue',
    'Pontue e compartilhe'
  ];
  List<String> descricao = [];
  List<Icon> icones = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  color: randomColor(),
                  child: Center(
                    child: Text(
                      titulo[index],
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 60,
            child: Row(
              children: [
                FlatButton(
                  child: Text("Pular"),
                  onPressed: () {
                    //TBD
                  },
                ),
                //TBD
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    pageController.nextPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.bounceIn);
                  },
                )
              ],
            ),
          )
        ], //children
      )),
    );
  }
}

Color randomColor() {
  Random rng = new Random();
  return Color.fromRGBO(
      rng.nextInt(256), rng.nextInt(256), rng.nextInt(256), 1);
}
