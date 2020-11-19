import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User{
  String _id;
  String _name;
  String _email;
  List<Map> _pontuacoes = [];

  User(){
    _id = '-1';
    _name = 'Visitante';
    _email = '';
  }

  User.firebase(FirebaseUser newUser){
    _email = newUser.email;
    _id = newUser.uid;
  }

  User.firebaseNamedUser(FirebaseUser newUser, String userName){
    _name = userName;
    _email = newUser.email;
    _id = newUser.uid;
  }

  void setName(String name){
    _name = name;
  } 

  void setEmail(String newEmail){
    _email = newEmail;
  }

  void setPontuacoes(Map pontuacao){
    _pontuacoes.add(pontuacao);
  } 

  String getID(){
    return _id;
  }

  String getName(){
    return _name;
  }

  String getEmail(){
    return _email;
  }

  List<Map> getPontuacoes(){
    return _pontuacoes;
  }

  //recover user information on Firestore
  Future<bool> loadFirestore() async{
    try{
      await Firestore.instance.collection('users').document(this._id).get().then((DocumentSnapshot ds){
        this._email = ds.data['email'].toString();
        this._name = ds.data['name'].toString();
        this._pontuacoes = List<Map>.from(ds.data['pontuacoes'] ?? []);
      });
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  //update user information on Firestore
  Future<bool> saveFirestore() async{
    await Firestore.instance.collection('users').document(this._id).setData({
      'email': this._email, 'name': this._name, 'pontuacoes': this._pontuacoes
    }, merge: true).catchError((e){
      print(e);
      return true;
    });
    return true;
  }
}