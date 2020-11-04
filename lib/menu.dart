import 'package:flutter/material.dart';
import 'package:improve/main.dart';

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
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ),
            ),
            RaisedButton(
              color: Colors.blue,
              onPressed: () async {
                await Navigator.pushNamed(context, '/login');
              },
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Text(user == null || user.getID() == '-1'
                      ? 'Entrar'
                      : 'Alterar conta')),
            ),
            RaisedButton(
              color: Colors.lightGreen[400],
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Container(
                        height: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.red,
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.red,
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Text('Jogar')),
            ),
            RaisedButton(
              color: Colors.cyan,
              onPressed: () {},
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Text('Ver pontuação')),
            ),
            RaisedButton(
              color: Colors.pink[300],
              onPressed: () {},
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Text('Personalizar')),
            ),
          ],
        ),
      ),
    ));
  }
}
