import 'package:hasura_connect/hasura_connect.dart';

String url = 'https://puc-pay.herokuapp.com/v1/graphql';
String error;
HasuraConnect conn = HasuraConnect(url);

String cad(var mail, var login, var mat, var name, var pass){
String insertCad = """
  mutation {
  insert_cadastro(objects: {email: "$mail", login: "$login", matricula: "$mat", nome: "$name", senha: "$pass"}) {
    affected_rows
  }
}
""";
  return insertCad;
 }
 
