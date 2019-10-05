import 'package:flutter/material.dart';
import 'package:quiz_v1/src/login/login-widgets.dart';
import 'package:quiz_v1/src/quiz/quiz-view.dart';

class Login extends StatefulWidget {
  
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final controleCampoTextoNome = TextEditingController();
  final controleCampoTextoSenha = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controleCampoTextoNome.dispose();
    controleCampoTextoSenha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return desenhandoTelaLogin(context);
  }
  
  Column desenhandoTelaLogin(BuildContext context){
    return Column(
        children: <Widget>[
          criaImagemTopApp('https://ramakblog.files.wordpress.com/2016/02/oscars-supporting-actors-actress-montage-620.jpg?w=469&h=265', 0),
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
          criaCampoEntrada('Usuário', TextInputType.text, false, Icons.person, Colors.purple, controleCampoTextoNome),

          criaCampoEntrada('Senha', TextInputType.datetime, true, Icons.security, Colors.orange, controleCampoTextoSenha),

          criaBotao('Entrar', 330, Colors.lightBlueAccent, ()=>logarNoApp(context) , 0, 0, 25),

          criaTexto('Esqueci a senha?', Colors.grey, 20, FontStyle.normal, FontWeight.normal, 33),
        
          criaBotao('Sem conta? Registre-se agora', 330, Colors.teal, ()=>criarContaNoApp(context), 0, 0, 28),
        ],
    );
  }
}


void loginComFacebook(BuildContext context){
    criaPopUpNotificacao(context, 'Ops!', 'Ainda não é possível logar com a conta facebook');
    print('login com facebook');
}

void loginComGoogle(BuildContext context){
  criaPopUpNotificacao(context, 'Ops!', 'Ainda não é possível logar com a conta google');
    print('login com google');
}

void logarNoApp(BuildContext context){
  Navigator.push(context,
            MaterialPageRoute(builder: (context) => Quiz()),
  );
}

void criarContaNoApp(BuildContext context){
  criaPopUpNotificacao(context, 'Ops!', 'Por enquanto não é necessário, pode criar um nome e entrar');
  print('criar uma conta no app');
}

Future<void> criaPopUpNotificacao(BuildContext context, String msgTituloCaixa, String msgTextoCaixa) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(msgTituloCaixa),
        content: Text(msgTextoCaixa),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
