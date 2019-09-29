
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_v1/src/login/login-widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:quiz_v1/src/quiz/quiz-componentes.dart';

class Quiz extends StatefulWidget {

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  CarouselSlider carousel;

  double idade = 18.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            FutureBuilder<List<Pessoa>>(
              future: obtemFamososFromApi('https://quiz-famosos-api.herokuapp.com/quiz/pos/obter_lista_todos_famosos'),
              builder: (context, snapshot) {
                //if (!snapshot.hasData) return Container();
                List<Pessoa> pessoas = snapshot.data;
                  return new Container(
                    padding: EdgeInsets.only(top: 25),
                    child: carousel = new CarouselSlider(
                    height: 405,
                    viewportFraction: 1.0,
                    items: pessoas.map((pessoa) => 
                      criaColunaImagemEDescricaoFamoso(pessoa)
                    ).toList(),
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SliderIdadeFamosos(idade : idade, definirChuteValorIdade: funcaoDefinirChuteValorIdade),    // Passar uma função que altere o valor da idade dessa classe ao ser mudado na outra
                  //testePrintCoisasDeOutraClasse(wd)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  criaBotaoCarousel(Colors.red, 112, 'Anterior', Icons.arrow_back, () => acaoBotaoAnterior(idade)),
                  criaBotaoCarousel(Colors.amber, 100, 'Chutar', Icons.check_circle_outline, () => acaoBotaoChutarIdadeFamoso()),
                  criaBotaoCarousel(Colors.green, 112, 'Proximo', Icons.arrow_forward, () => acaoBotaoProximo())
                ],
              ),
            ),

          ],
        ),
      )
    );
  }

  void funcaoDefinirChuteValorIdade(double val){
      setState(() {
          idade = val;
      });
  }

  void acaoBotaoAnterior(double idade){
    carousel.previousPage(duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
  }

  void acaoBotaoChutarIdadeFamoso(){
    print('chutar idade');
    print('${idade.toInt()}');
  }

  void acaoBotaoProximo (){

    carousel.nextPage(duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
  }

  void funcaoCallBack(BuildContext context) {
      Navigator.pop(context);
  }
}

