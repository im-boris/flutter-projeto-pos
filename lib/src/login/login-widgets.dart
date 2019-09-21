import 'package:flutter/material.dart';
import 'package:quiz_v1/src/login/login-view.dart';

Container criaImagemTopApp(String logoUrl, double paddingTop) {
  return Container(
      //color: Colors.red,
      padding: EdgeInsets.fromLTRB(0, paddingTop, 0, 0),
      width: double.infinity,
      height: 125,
      child: Image.network(logoUrl,fit: BoxFit.fill));
}

Container criaTexto(String textoBoasVindas, Color cor, double tamanhoFonte, FontStyle estiloFonte, FontWeight fontWeight, double marginTop) {
  return Container(
    margin: EdgeInsets.only(top: marginTop),
    child: Text(textoBoasVindas,
        style: TextStyle(
          color: cor, 
          fontSize: tamanhoFonte, 
          fontStyle: estiloFonte,
          fontWeight: fontWeight)
    )
  );
}

Container criaBotao(String textoBotao, double tamBotao, Color cor, VoidCallback funcaoCallBack, double marginLeft, double margingRight, double marginTop) {
  return Container(
      width: tamBotao,
      height: 45,
      //color: cor,
      margin: EdgeInsets.only(top: marginTop, left:marginLeft, right: margingRight),
      child : RaisedButton(
          child: Text(textoBotao, style: TextStyle(color: Colors.white)),
          color: cor,
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
          onPressed: funcaoCallBack
      )
  );

}

Container criaCampoEntrada(String textoCampo, TextInputType tipoEntradaTeclado, bool entradaTipoSenha, IconData iconeCampo, Color corIcone){
  return Container (
      width: 330,
      height: 50,
      margin: EdgeInsets.only(top: 15),
      child: new TextFormField(
              obscureText: entradaTipoSenha,
              decoration: new InputDecoration(
                suffixIcon: Icon(iconeCampo, color: corIcone),
                labelText: textoCampo,
                border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0)
                ),
              ),
              style: new TextStyle(
                    fontFamily: "Poppins",
              ),
              keyboardType: tipoEntradaTeclado,
      ),
  );
}

