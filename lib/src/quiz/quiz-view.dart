
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

  double idade = 18.0;
  List<Pessoa> listaFamosos;
  Pessoa famosoAtual;
  int idadeFamosoAtual;
  int dicaIdadeFamosoAtual;
  int pontuacaoJogador;
  
  List<PessoaDTO> listaFamososDTO;
  PessoaDTO famosoDTO;
  

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
                listaFamososDTO = criaListaFamosoDTO(pessoas.length);

                return new Container(
                    padding: EdgeInsets.only(top: 25),
                    child: carousel = new CarouselSlider(
                    height: 405,
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
              margin: EdgeInsets.only(top: 15, left: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SliderIdadeFamosos(idade : idade, definirChuteValorIdade: funcaoDefinirChuteValorIdade),    // Passar uma função que altere o valor da idade dessa classe ao ser mudado na outra
                  
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  criaBotaoCarousel(Colors.red, 112, 'Anterior', Icons.arrow_back, () => acaoBotaoAnterior()),
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

  List<PessoaDTO> criaListaFamosoDTO(int tam){
      List<PessoaDTO> lista = new List<PessoaDTO>();

      for (var i = 0; i < tam; i++) {

        PessoaDTO dto = new PessoaDTO();

        dto.nome = '';
        dto.dataNasc = '';
        dto.urlImagem = '';
        dto.dica = '';
        dto.sexo = '';
        dto.qtdTentativas = 0;
        dto.idadeFamoso = 0;
        dto.dicaIdadeFamosoAtual = geraDicaIdade();

        lista.add(dto);
      }

      return lista;
  }

  PessoaDTO criaFamosoDTOInicial(){
    PessoaDTO dto = new PessoaDTO();

    dto.dicaIdadeFamosoAtual = 0;
    dto.idadeFamoso = 0;
    dto.qtdTentativas = 0;

    return dto;

  }   

  dynamic famosoSendoApresentadoAgora(int x){

    famosoAtual = listaFamosos[x];

    idadeFamosoAtual = calculaIdadeFamosoAtual();
    dicaIdadeFamosoAtual = geraDicaIdade();

  }
  void funcaoDefinirChuteValorIdade(double val){
      setState(() {
          idade = val;
      });
  }

  void acaoBotaoAnterior(){
    carousel.previousPage(duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
  }

  void acaoBotaoProximo (){
    carousel.nextPage(duration: Duration(milliseconds: 800), curve: Curves.fastOutSlowIn);
  }

  void acaoBotaoChutarIdadeFamoso(){

    if ( descobreSeAcertouChuteIdade(idade.toInt()) ) {
        print('Parabens, vc acertou ${famosoAtual.nome} tem $idadeFamosoAtual anos');
    } else{
        print('Errou. Dica : idade entre ${idadeFamosoAtual - dicaIdadeFamosoAtual} e ${idadeFamosoAtual + dicaIdadeFamosoAtual}');
    }

  }

  int geraDicaIdade(){

    Random rand = new Random();
    int min = 1;
    int max = 10;

    int numeroDicaRandom = min + rand.nextInt(max - min);

    return numeroDicaRandom;
  }

  bool descobreSeAcertouChuteIdade(int chuteIdade){
    
    if (chuteIdade == idadeFamosoAtual)
      return true;

    return false;
    
  }

  int calculaIdadeFamosoAtual (){

    int idadeFamoso = 0;

    List<String> ano = famosoAtual.dataNasc.split('/');
    String dataNascimentoFormatada = ano[2]+'-'+ ano[1]+'-'+ ano[0];

    DateTime dataFormatada = DateTime.parse(dataNascimentoFormatada);
    Duration duracao =  DateTime.now().difference(dataFormatada);
    idadeFamoso = (duracao.inDays/365).floor().toInt();

    return idadeFamoso;
  }

  void funcaoCallBack(BuildContext context) {
      Navigator.pop(context);
  }
}

