
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
          //child: Image.network(pessoa.urlImagem, height: 320, width: 310, fit: BoxFit.fill),
          height: 320,
          width: 310,
          child: Center(child: Text('famoso', style: TextStyle(color: Colors.black, fontSize: 25))),
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

class PessoaDTO {

  String nome;
  String dataNasc;
  String urlImagem;
  String dica;
  String sexo;
  int idadeFamoso;
  int dicaIdadeFamosoAtual;
  int qtdTentativas;

  PessoaDTO({this.nome, this.dataNasc, this.urlImagem, this.dica, this.sexo});
  //PessoaDTO({this.idadeFamoso, this.dicaIdadeFamosoAtual, this.qtdTentativas});


}

Future<List<Pessoa>> obtemFamososFromApi(String url) async {
    final response = await http.post(url, headers: {"Content-Type":"application/json"});

    var body = json.decode(response.body);
    
    var resp = body["listaFamosos"] as List;

    List<Pessoa> listaFamosos = resp.map<Pessoa>((objeto) => Pessoa.fromJson(objeto)).toList();
    //print(listaFamosos.length);
    return listaFamosos;
}

Future<List<Pessoa>> obtemFamososFromLocal() async {
   

    var body = json.decode('{"listaFamosos":[{"nome":"Scarlett Johansson","dataNasc":"11/22/1984","urlImagem":"https://amp.insider.com/images/5c8a8141dd08611286199063-750-56.jpg","dica":"Viuva negra","sexo":"f"},{"nome":"Robert Downey, Jr.","dataNasc":"04/04/1965","urlImagem":"http://br.web.img2.acsta.net/pictures/18/06/29/00/35/0101925.jpg","dica":"Homem de ferro","sexo":"m"},{"nome":"Chris Evans","dataNasc":"06/13/1981","urlImagem":"https://www.altfg.com/film/wp-content/uploads/images/2016/05/captain-america-civil-war-chris-evans.jpg","dica":"Capitão america","sexo":"m"},{"nome":"Chris Hemsworth","dataNasc":"08/11/1983","urlImagem":"https://cdn.mamamia.com.au/wp/wp-content/uploads/2017/10/19170125/Thor-Ragnorok-Social-650x507.jpg","dica":"Thor","sexo":"m"},{"nome":"Jeremy Renner","dataNasc":"01/07/1971","urlImagem":"https://media.wired.com/photos/5d7125ee9e087200080de8f1/master/pass/Culture_Monitor_Renner-972293712.jpg","dica":"Gavião arqueiro","sexo":"m"},{"nome":"Mark Ruffalo","dataNasc":"11/22/1967","urlImagem":"https://upload.wikimedia.org/wikipedia/commons/1/11/Mark_Ruffalo_%2836201774756%29_%28cropped%29.jpg","dica":"Hulk em os vingadores","sexo":"m"},{"nome":"Tom Hiddleston","dataNasc":"02/09/1981","urlImagem":"https://i.pinimg.com/736x/d4/c7/fe/d4c7fef4d58523e144b6282ac6fe7971.jpg","dica":"Loki em os vingadores","sexo":"m"},{"nome":"Samuel L. Jackson","dataNasc":"12/21/1948","urlImagem":"https://cdn.britannica.com/77/191077-050-63262B99/Samuel-L-Jackson.jpg","dica":"Nick Fury em os vingadores","sexo":"m"},{"nome":"Paul Rudd","dataNasc":"04/06/1969","urlImagem":"https://upload.wikimedia.org/wikipedia/commons/9/92/Paul_Rudd_%28cropped%29_2.jpg","dica":"Homem-formiga","sexo":"m"},{"nome":"Tom Holland","dataNasc":"06/01/1996","urlImagem":"https://ewedit.files.wordpress.com/2018/06/tom-holland1.jpg?crop981px%2C103px%2C1010px%2C1010px&resize1200%2C1200","dica":"Homem-aranha UCM","sexo":"m"},{"nome":"Mariah Carey","dataNasc":"03/27/1970","urlImagem":"","dica":"Cantora","sexo":"f"},{"nome":"Karen Gillan","dataNasc":"11/28/1987","urlImagem":"https://gamespot1.cbsistatic.com/uploads/original/171/1712892/3360013-image.jpg","dica":"Nebulosa em os vingadores","sexo":"f"},{"nome":"Don Cheadle","dataNasc":"11/29/1964","urlImagem":"https://cdn1.thr.com/sites/default/files/imagecache/scale_crop_768_433/2019/07/gettyimages-969551878_0.jpg","dica":"War machine","sexo":"m"},{"nome":"Josh Brolin","dataNasc":"02/12/1968","urlImagem":"https://pmcvariety.files.wordpress.com/2019/02/josh-brolin.jpg?w1000","dica":"Thanos e Cable","sexo":"m"},{"nome":"Chris Pratt","dataNasc":"06/21/1979","urlImagem":"https://upload.wikimedia.org/wikipedia/commons/d/d0/Chris_Pratt_%2828046276644%29_%28cropped%29.jpg","dica":"Star Lord","sexo":"m"},{"nome":"Anthony Mackie","dataNasc":"09/23/1978","urlImagem":"https://www.indiewire.com/wp-content/uploads/2019/06/shutterstock_10216461ao.jpg","dica":"Falcão em os vingadores","sexo":"m"},{"nome":"Elizabeth Olsen","dataNasc":"02/16/1989","urlImagem":"","dica":"","sexo":"f"},{"nome":"Benedict Cumberbatch","dataNasc":"07/19/1976","urlImagem":"","dica":"Doutor Estranho","sexo":"m"},{"nome":"Sebastian Stan","dataNasc":"08/13/1982","urlImagem":"","dica":"Soldado Invernal","sexo":"m"},{"nome":"Chadwick Aaron Boseman","dataNasc":"11/29/1977","urlImagem":"","dica":"Pantera Negra","sexo":"m"},{"nome":"Dave Bautista","dataNasc":"01/18/1969","urlImagem":"","dica":"Drax","sexo":"m"},{"nome":"Benedict Wong","dataNasc":"06/03/1971","urlImagem":"","dica":"Wong em doutor estranho","sexo":"m"},{"nome":"Letitia Wright","dataNasc":"10/31/1993","urlImagem":"","dica":"Shuri em pantera negra","sexo":"f"}]}');
    
    var resp = body["listaFamosos"] as List;

    List<Pessoa> listaFamosos = resp.map<Pessoa>((objeto) => Pessoa.fromJson(objeto)).toList();
    //print(listaFamosos.length);
    return listaFamosos;
}
