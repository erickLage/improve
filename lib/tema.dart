import 'package:flutter/material.dart';

class Tema {
  Color corPrimaria, corSecundaria;
  Tema() {
    ThemeData tema = new ThemeData(
      primaryColor: corPrimaria,
      accentColor: corSecundaria,
    );
  }
} //fim Tema
