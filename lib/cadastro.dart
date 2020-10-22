import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  //Key to keep inputs in the form widget
  final GlobalKey<FormState> _formkey = GlobalKey();
  String _name;
  String _email;
  String _password;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'src/assets/logo_sem_fundo.png'
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text('Cadastre seus dados', style: TextStyle(fontSize: 20),),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formkey,
                  child: Container(
                    color: Colors.green[50],
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Digite seu nome',
                          ),
                          validator: (value) {
                            if(value.isEmpty){
                              return 'Por favor, digite um email válido';
                            }
                            return null;
                          },
                          onSaved: (value){
                            _name = value;
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: emailController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Digite seu email'
                          ),
                          validator: (value) {
                            if(value.isEmpty){
                              return 'Por favor, digite um email válido';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Confirme seu email'
                          ),
                          validator: (value){
                            if(value != emailController.text){
                              return 'Emails diferentes';
                            }
                            return null;      
                          },
                          onSaved: (value) {
                            _email = value;
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: passwordController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Digite sua senha'
                          ),
                          validator: (value){
                            if(value.length < 2){
                              return 'Mínimo de 2 digitos';
                            }
                            return null;      
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Confirme sua senha'
                          ),
                          validator: (value){
                            if(value != passwordController.text){
                              return 'Senhas diferentes';
                            }
                            return null;      
                          },
                          onSaved: (value) {
                            _password = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  color: Colors.green,
                  onPressed: (){
                    signUp();
                  },
                  child: Text('Botão da Rebeca'),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  Future<void> signUp() async{
    final formState = _formkey.currentState;
    if(formState.validate()){
      formState.save();
    }
  }
}