
import 'dart:async';
import 'dart:math';

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

  double idade;
  List<Pessoa> listaFamosos;

  List<PessoaDTO> listaFamososDTO;
  PessoaDTO famosoDTO;
  
  JogadorQuiz jogador;


  @override
  void initState() {
      super.initState();

      idade = 18.0;

      jogador = new JogadorQuiz();

      jogador.nomeJogador = "Mateus";
      jogador.qtdTentativas = 0;
      jogador.qtdErros = 0;
      jogador.pontuacao = 0;

      print('----- Dados jogador carregado ----- ');
      print('----- ${jogador.nomeJogador} ----- ');
      print('----- ${jogador.qtdTentativas} ----- ');
      print('----- ${jogador.qtdErros} ----- ');
      print('----- ${jogador.pontuacao} ----- ');
      // This will print "initState() ---> MainPage"
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            FutureBuilder<List<Pessoa>>(
              //future: obtemFamososFromApi('https://quiz-famosos-api.herokuapp.com/quiz/pos/obter_lista_todos_famosos'),
              future: obtemFamososFromLocal(),
              builder: (context, snapshot) {
                //if (!snapshot.hasData) return Container();
                List<Pessoa> pessoas = snapshot.data;
                listaFamosos = pessoas;
                listaFamososDTO = criaListaFamosoDTO(pessoas);

                return new Container(
                    padding: EdgeInsets.only(top: 25),
                    child: carousel = new CarouselSlider(
                    height: 385,
                    viewportFraction: 1.0,
                    onPageChanged: famosoSendoApresentadoAgora,
                    items: pessoas.map((pessoa) => 
                      criaColunaImagemEDescricaoFamoso(pessoa),                    
                    ).toList(),
                  ),
                );
              },
            ),
            Container(
              //color: Colors.red,
              margin: EdgeInsets.only(left: 18, right: 15),
              child: Row(
                children: <Widget>[
                  SliderIdadeFamosos(idade : idade, textoValorMin: '18', textoValorMax: '90', definirChuteValorIdade: funcaoDefinirChuteValorIdade),    // Passar uma função que altere o valor da idade dessa classe ao ser mudado na outra
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  criaBotaoCarousel(Colors.red, 112, 20, 20, 0 ,0, 'Anterior', Icons.arrow_back, () => acaoBotaoAnterior()),
                  criaBotaoCarousel(Colors.amber, 100, 0, 0, 0, 0, 'Chutar', Icons.check_circle_outline, () => acaoBotaoChutarIdadeFamoso()),
                  criaBotaoCarousel(Colors.green, 112, 0, 0 , 20, 20, 'Proximo', Icons.arrow_forward, () => acaoBotaoProximo())
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  dynamic famosoSendoApresentadoAgora(int x){
    famosoDTO = listaFamososDTO[x];
  }
  
  void funcaoDefinirChuteValorIdade(double val){
      setState(() {
          idade = val;
      });
  }

  void acaoBotaoAnterior(){
    carousel.previousPage(duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
  }

  void acaoBotaoProximo(){
    carousel.nextPage(duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
  }

  void acaoBotaoChutarIdadeFamoso(){

    jogador.qtdTentativas++;
    
    if ( descobreSeAcertouChuteIdade(idade.toInt(), famosoDTO.idadeFamoso) ) {
        print('Parabens, ${jogador.nomeJogador}, ${famosoDTO.nome} tem ${famosoDTO.idadeFamoso} anos\n vc acertou em ${jogador.qtdTentativas} tentativas');

    } else{
        jogador.qtdErros++;
        print('Errou. Dica : ${famosoDTO.nome} tem idade entre ${famosoDTO.idadeFamoso - famosoDTO.dicaIdadeFamosoAtual} e ${famosoDTO.idadeFamoso + famosoDTO.dicaIdadeFamosoAtual} anos');
        print('qtd erros nessa foto : ${jogador.qtdErros}');
    }

  }

  void funcaoCallBack(BuildContext context) {
      Navigator.pop(context);
  }

}

