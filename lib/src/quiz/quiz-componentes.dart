
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:clippy_flutter/clippy_flutter.dart';




class SliderIdadeFamosos extends StatefulWidget {

  double idade;
  final ValueChanged<double> definirChuteValorIdade;

  SliderIdadeFamosos({
    this.idade,
    this.definirChuteValorIdade
  });


  @override
  _SliderIdadeFamososState createState() => _SliderIdadeFamososState();

}

class _SliderIdadeFamososState extends State<SliderIdadeFamosos> {



  @override
  Widget build(BuildContext context) { 
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
          criaSliderIdadeFamosos(), 
          criaLabelIdadeFamoso(widget.idade.toInt())
      ],
    ); 
  }

  Container criaSliderIdadeFamosos(){
    

    return Container(
        width: 240,
        height: 70,
        //color: Colors.grey,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Slider(
          min: 18.0,
          max: 90.0,
          value: widget.idade,
          onChanged: mudandoValorIdade,
          onChangeEnd: widget.definirChuteValorIdade
        ),
    );

  }

  mudandoValorIdade(double valorSelecionado){
    setState(() {
        widget.idade = valorSelecionado;
    });
  }
}

Star criaLabelIdadeFamoso(int idadePalpite){

    return Star(
         numberOfPoints: 5,
         child: Container(
           width: 90,
           height: 90,
           color: Colors.deepOrangeAccent,
           child: Center(
             child: Text('$idadePalpite', style: TextStyle(color: Colors.black, fontSize: 25)),
           ),
         ),
    );

}

Column criaColunaImagemEDescricaoFamoso(Pessoa pessoa){
  return  Column(
      children: <Widget>[
        Container(
          child: Image.network(pessoa.urlImagem, height: 320, width: 310, fit: BoxFit.fill),
          decoration: decoracaoBordaCartao()
        ),
        criaLabelDescricaoFamoso(pessoa.nome, pessoa.dica)
      ], 
  );
}


Container criaLabelDescricaoFamoso (String nomeFamoso, String dica) {
  return  Container(
            margin: EdgeInsets.only(top: 5),
            height: 60,
            width: 330,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment(0.0, 0.0),
                  child: Text(nomeFamoso, style: TextStyle(color: Colors.amberAccent, fontSize: 20, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                ),
                Container(
                  alignment: Alignment(0.0, 0.0),
                  child: Text(dica, style: TextStyle(color: Colors.white, fontSize: 20, fontStyle: FontStyle.italic)),
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

Column criaBotaoCarousel(Color cor, double larguraBotao, String txtBotao, IconData icone, VoidCallback funcaoBotao) {

  return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20),
            width: larguraBotao,
            height: 90,
            color: cor,
            child: FlatButton(
                onPressed: funcaoBotao,
                child: Column(
                  children: <Widget>[
                    Icon(icone,size: 35.0,),
                    Text(txtBotao, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold))
                  ],
                ),
            ),
          ),

      ],
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
