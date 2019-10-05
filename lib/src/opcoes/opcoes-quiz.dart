import 'package:flutter/material.dart';
import 'package:quiz_v1/src/quiz/quiz-componentes.dart';

import 'opcoes-quiz-componentes.dart';

class OpcoesQuiz extends StatelessWidget {

  JogadorQuiz jogador;

  OpcoesQuiz({Key key, this.jogador}) : super (key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: OpcoesMenuQuiz(jogador: jogador),
    );
  }
}