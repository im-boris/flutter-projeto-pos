import 'package:flutter/material.dart';
import 'package:quiz_v1/src/login/login-widgets.dart';
import 'package:quiz_v1/src/quiz/quiz-componentes.dart';
import 'package:quiz_v1/src/quiz/quiz-view.dart';

class OpcoesMenuQuiz extends StatelessWidget {

  JogadorQuiz jogador;

  OpcoesMenuQuiz({Key key, this.jogador}) : super (key : key);

  @override
  Widget build(BuildContext context) {

    //print('Nome jogador : ${jogador.nomeJogador}');
    return Container(
      child: Column(
        children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                    Container(
                      child: criaImagemTopApp('https://ramakblog.files.wordpress.com/2016/02/oscars-supporting-actors-actress-montage-620.jpg?w=469&h=265', 0),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 50, top: 50),
                      child: Text('Olá ${jogador.nomeJogador}', style: TextStyle(color: Colors.lightBlueAccent, fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 50),
                      child: Text('Escolha uma opção de quiz : ', style: TextStyle(color: Colors.black, fontSize: 25, fontStyle: FontStyle.italic)),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: criaBotao('QUIZ apenas com mulheres', 280, Colors.purple,()=>abrirJogoQuiz(context,'https://quiz-famosos-api.herokuapp.com/quiz/pos/obter_lista_famosos_mulheres'), 15, 5, 0),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: criaBotao('QUIZ apenas com homens', 280, Colors.blue,()=>abrirJogoQuiz(context,'https://quiz-famosos-api.herokuapp.com/quiz/pos/obter_lista_famosos_homens'), 15, 5, 0),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child : criaBotao('QUIZ com homens e mulheres', 280, Colors.green,()=>abrirJogoQuiz(context,'https://quiz-famosos-api.herokuapp.com/quiz/pos/obter_lista_todos_famosos'), 15, 5, 0)
                    ),
                ],
              ),
          )
        ],
      ),
    );
  }
  void abrirJogoQuiz(BuildContext context, String urlAPI){

    Navigator.push(context,
              MaterialPageRoute(builder: (context) => Quiz(jogador: jogador, urlAPI: urlAPI)),
    );
  }
  
}