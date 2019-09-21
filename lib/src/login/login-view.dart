import 'package:flutter/material.dart';
import 'package:quiz_v1/src/login/login-widgets.dart';
import 'package:quiz_v1/src/quiz/quiz-view.dart';

class Login extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return desenhandoTelaLogin(context);
  }

}

Column desenhandoTelaLogin(BuildContext context){
  return Column(
      children: <Widget>[
        criaImagemTopApp('https://image.freepik.com/free-vector/abstract-white-background-with-blue-hexagonal-shapes_1017-19744.jpg', 0),
        criaTexto('Quiz idade dos famosos', Colors.green, 25, FontStyle.italic, FontWeight.bold, 25),
        Container(
          height: 80,
          width: 360,
          margin: EdgeInsets.only(top: 20),
          //color: Colors.green,
          child: Row(
            children: <Widget>[
              criaBotao('FACEBOOK', 160, Colors.blue,()=>loginComFacebook(context), 15, 5, 0),
              criaBotao('GOOGLE+', 160, Colors.red,()=>loginComGoogle(context), 5, 0, 0),
            ],
          ),
        ),
        criaCampoEntrada('Usuário', TextInputType.text, false, Icons.person, Colors.purple),

        criaCampoEntrada('Senha', TextInputType.datetime, true, Icons.security, Colors.orange),

        criaBotao('Entrar', 330, Colors.lightBlueAccent, ()=>logarNoApp(context) , 0, 0, 25),

        criaTexto('Sou burro, esqueci a senha?', Colors.grey, 20, FontStyle.normal, FontWeight.normal, 33),
       
        criaBotao('Sem conta? Registre-se agora', 330, Colors.teal, ()=>criarContaNoApp(context), 0, 0, 28),
      ],
  );
}

void loginComFacebook(BuildContext context){
    print('login com facebook');
}

void loginComGoogle(BuildContext context){
    print('login com google');
}

void logarNoApp(BuildContext context){
  Navigator.push(context,
            MaterialPageRoute(builder: (context) => Quiz()),
  );
}

void criarContaNoApp(BuildContext context){
  print('criar uma conta no app');
}

  // Navigator.push(context,
  //           MaterialPageRoute(builder: (context) => Quiz()),
  // );