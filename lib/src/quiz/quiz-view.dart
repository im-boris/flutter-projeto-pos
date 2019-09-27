
import 'package:flutter/material.dart';
import 'package:quiz_v1/src/login/login-widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quiz_v1/src/quiz/quiz-componentes.dart';

class Quiz extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            criaCarouselFamosos()
          ],
        ),
      )
    );
  }

  void funcaoCallBack(BuildContext context) {
      Navigator.pop(context);
  }


}