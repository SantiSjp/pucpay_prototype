import 'package:hasura_connect/hasura_connect.dart';

String url = 'https://puc-pay.herokuapp.com/v1/graphql';
String error;
HasuraConnect conn = HasuraConnect(url);

var user_id;

String cad(var mail, var login, var mat, var name, var pass){
String insertCad = """
  mutation {
  insert_cadastro(objects: {UID: "",email: "$mail", login: "$login", matricula: "$mat", nome: "$name", senha: "$pass"}) {
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

  
 