
import 'dart:collection';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


Widget criaCarouselFamosos() {

    return new FutureBuilder<List<Pessoa>>(
      future: obtemFamososFromApi('https://quiz-famosos-api.herokuapp.com/quiz/pos/obter_lista_todos_famosos'),
      builder: (context, snapshot) {
        //if (!snapshot.hasData) return Container();
        List<Pessoa> pessoas = snapshot.data;
          return new Container(
            padding: EdgeInsets.only(top: 25),
            child: CarouselSlider(
            height: 480,
            viewportFraction: 1.0,
            items: pessoas.map((pessoa) => 
              Column(
                children: <Widget>[
                  Container(
                    child: Image.network(pessoa.urlImagem, height: 345, width: 300, fit: BoxFit.fill),
                    decoration: decoracaoBordaCartao()
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 60,
                    width: 320,
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment(0.0, 0.0),
                          child: Text(pessoa.nome, style: TextStyle(color: Colors.amberAccent, fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          alignment: Alignment(0.0, 0.0),
                          child: Text(pessoa.dica, style: TextStyle(color: Colors.white, fontSize: 20, fontStyle: FontStyle.italic)),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      border: Border(
                          left: BorderSide(
                            color: Colors.indigo[100],
                            width: 10.0
                          ),
                          top: BorderSide(
                            color: Colors.indigo[100],
                            width: 4.0
                          ),
                          bottom: BorderSide(
                            color: Colors.indigo,
                            width: 8.0
                          ),
                          right: BorderSide(
                            color: Colors.deepOrangeAccent,
                            width: 4.0
                          ),
                      ),
                    )
                  )
                ], 
              )
            ).toList(),
          ),
        );
      },
    );
}

BoxDecoration decoracaoBordaCartao(){

  return BoxDecoration(
        //borderRadius: BorderRadius.circular(20.0),
        border: Border(
            left: BorderSide(
              color: Colors.indigo[200],
              width: 15.0
            ),
            top: BorderSide(
              color: Colors.deepOrangeAccent,
              width: 4.0
            ),
            right: BorderSide(
              color: Colors.deepOrangeAccent,
              width: 4.0
            ),
            bottom: BorderSide(
              color: Colors.indigo,
              width: 15.0
            )
      )
  );
}

class Pessoa {

  String nome;
  String dataNasc;
  String urlImagem;
  String dica;
  String sexo;

  Pessoa({this.nome, this.dataNasc, this.urlImagem, this.dica, this.sexo});

  factory Pessoa.fromJson(Map<String, dynamic> json) {
    return Pessoa(
      nome: json['nome'],
      dataNasc: json['dataNasc'],
      urlImagem: json['urlImagem'],
      dica: json['dica'],
      sexo: json['sexo']
    );
  }

}

Future<List<Pessoa>> obtemFamososFromApi(String url) async {
    final response = await http.post(url, headers: {"Content-Type":"application/json"});

    var body = json.decode(response.body);
    
    var resp = body["listaFamosos"] as List;

    List<Pessoa> listaFamosos = resp.map<Pessoa>((objeto) => Pessoa.fromJson(objeto)).toList();
    //print(listaFamosos.length);
    return listaFamosos;
}
