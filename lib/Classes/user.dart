import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User{
  String _id;
  String _name;
  String _email;

  User(){

  }

  User.firebase(FirebaseUser newUser){

  }

  User.firebaseNamedUser(FirebaseUser newUser, String userName){

  }
}