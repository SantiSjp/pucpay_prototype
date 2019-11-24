import 'package:hasura_connect/hasura_connect.dart';
import 'package:flutter/material.dart';

String url = 'https://puc-pay.herokuapp.com/v1/graphql';
String error;
HasuraConnect conn = HasuraConnect(url); 

var userId;
var nomeUser;
var matriculaUser;
int cEst;
int cImp;

String cadUser(var uid, var mail, var login, var mat, var name, var pass){
String insertCad = """
  mutation {
  insert_cadastro(objects: {UID: "$uid",email: "$mail", login: "$login", matricula: "$mat", nome: "$name", senha: "$pass"}) {
    affected_rows
  }
}
""";
return insertCad;
}



String insertUid(var uid, var mail){
String updateUid = """
  mutation {
  update_cadastro(where: {email: {_eq: "$mail"}}, _set: {UID: "$uid"}) {
    affected_rows
    returning {
      email
      UID
    }
  }
}

""";
return updateUid;
}

String insertCredit(uid,credito, tipoCredito){


  String insertCredits;
  if(tipoCredito == 1){
    insertCredits = """
  mutation {
  update_cadastro(where: {UID: {_eq: "$uid"}}, _set: {credit_est: "$credito"}) {
    returning {
      email
      credit_est
    }
  }
}
""";
  }

  if(tipoCredito == 2){
    insertCredits = """
  mutation {
  update_cadastro(where: {UID: {_eq: "$uid"}}, _set: {credit_imp: "$credito"}) {
    returning {
      email
      credit_imp
    }
  }
}
""";
  }

return insertCredits;
}


String getUserId(var mail){
  String getUserID = """
  query {
  cadastro(where: {email: {_eq: "$mail"}}) {
    id
  }
}
""";
return getUserID;
}

String getUserData(field, data) {
  String getUserDATA= """
  query{
  cadastro(where: {$field: {_eq: "$data"}}) {
    email
    login
    matricula
  }
}
  """;

  return getUserDATA;
}


String getCreditos(uid, tipoCredito){

  String creditos;

  if(tipoCredito == 1){
  creditos = """
  query {
  cadastro(where: {UID: {_eq: "$uid"}}) {
    credit_est
  }
}
""";
}

  if(tipoCredito == 2){
    creditos = """
  query {
  cadastro(where: {UID: {_eq: "$uid"}}) {
    credit_imp
  }
}
""";
  }

  return creditos;
}

String getUserLog(mail, pass) {
  String getUserLog= """
  query{
  cadastro(where: {email: {_eq: "$mail"}, _and: {senha: {_eq: "$pass"}}}) {
    UID
    nome
    matricula
  }
}
  """;

  return getUserLog;
}

String insertCard(var uid, var cardNumber, var cvv, var nome, var validade){

  String _insertCard = """
  mutation {
  insert_cards(objects: {UID_PK: "$uid", cvv: "$cvv", nome: "$nome", numero: "$cardNumber", validade: "$validade"}) {
    affected_rows
  }
}
   """;

   return _insertCard;
}

String getPagamento() {
  return """ query { pagamentos(where: {UID_PK: {_eq: "$userId"}}) { data valor } } """;
}


void exibirDialogo(context, String title, String content, String button, page){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            child: Text(button),
            onPressed: (){
              print(button);
              //Navigator.pop(context);
              Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => page),
              (Route<dynamic> route) => false,);
            },
          )
        ],
      );
    }
  );
}
  
 