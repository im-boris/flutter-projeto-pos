
import 'package:flutter/material.dart';
import 'package:quiz_v1/src/login/login-widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quiz_v1/src/quiz/quiz-componentes.dart';

class Quiz extends StatelessWidget {

  CarouselSlider carousel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            criaCarouselFamosos(carousel),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 criaBotaoCarousel('Anterior', Icons.arrow_back, () => acaoBotaoAnterior('botaoAnterior')),
                 criaBotaoCarousel('Proximo', Icons.arrow_forward, () => acaoBotaoProximo('botaoProximo'))
              ],
            )
          ],
        ),
      )
    );
  }

  void acaoBotaoAnterior(String txt){
    print(txt);
    carousel.previousPage();

  }

  void acaoBotaoProximo (String txt){
    print(txt);
    carousel.nextPage();
  }

  void funcaoCallBack(BuildContext context) {
      Navigator.pop(context);
  }


}