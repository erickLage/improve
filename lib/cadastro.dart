import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:improve/Classes/user.dart';
import 'package:improve/main.dart';

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

  String _errorText = '';

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
                            if(value.length < 6){
                              return 'Mínimo de 6 digitos';
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
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    _errorText, 
                    style: TextStyle(
                      color: Colors.red
                    ),
                  ),
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
      try{
        if(user != null && user.getID() != '-1'){
          await FirebaseAuth.instance.signOut();
        }
        FirebaseUser _userFirebase = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
        _userFirebase.sendEmailVerification();

        User _user = new User.firebaseNamedUser(_userFirebase, _name);
        await _user.saveFirestore();

        await showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text('Falta pouco'), 
            content: Text('Favor verificar Email para concluir o cadastro.'),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                child: Text('ok', style: TextStyle(fontSize: 18),)
              ),
            ],
          );
        });

        if(!_userFirebase.isEmailVerified) await FirebaseAuth.instance.signOut();

        Navigator.pop(context);
      }catch(e){
        setState(() {
          switch (e.code) {
            case 'ERROR_INVALID_EMAIL':
              _errorText = 'Seu email parece estar mal formatado.';
              break;
            case 'ERROR_EMAIL_ALREADY_IN_USE':
              _errorText= 'Este email ja está sendo utilizado.';
              break;
            default:
              _errorText = 'Um erro inseperado aconteceu.';
          }
        });
        print(e.message);
      }
    }
  }

  
}