
import 'package:flutter/material.dart';
import 'package:quiz_v1/src/login/login-view.dart';

class TelaInicial extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return criaTelaInicialApp(context);
  }
}
// Tela inicial do APP
Scaffold criaTelaInicialApp(BuildContext context){
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: new Login()
    );
}

// Tema principal do APP
ThemeData criaTemaApp(){
    return ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light
    );
} 
