import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:improve/Classes/user.dart';
import 'package:improve/main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //Key to keep inputs in the form widget
  final GlobalKey<FormState> _formkey = GlobalKey();
  String _email;
  String _password;

  String _errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                Text('Entre com seu email e senha:', style: TextStyle(fontSize: 20),),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formkey,
                  child: Container(
                    color: Colors.blue[50],
                    child: Column(
                      children: <Widget>[
                        TextFormField(
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
                          onSaved: (value) {
                            _email = value;
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextFormField(
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
                  color: Colors.blue,
                  onPressed: (){
                    signIn();
                  },
                  child: Text('Entrar'),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  child: Text("Cadastrar-se", style: TextStyle(color: Colors.green),),
                  onTap: () async{
                    await Navigator.pushNamed(context, '/cadastro');
                  },
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  Future<void> signIn() async{
    final formState = _formkey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        if(user != null && user.getID() != '-1'){
          await FirebaseAuth.instance.signOut();
        }
        FirebaseUser _userFirebase = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;

        if(_userFirebase != null){
          if(_userFirebase.isEmailVerified){
            user = new User.firebase(_userFirebase);
            await user.loadFirestore();
            await Navigator.pushReplacementNamed(context, '/menu');
          }
        }else{
          setState(() {
            _errorText = 'Seu email ainda não foi verificado.';
          });
        }

        
      }catch(e){
        setState(() {
          _errorText = 'Conta inexistente ou senha incorreta';
        });
        print(e.message);
      }
    }
  }

  
}