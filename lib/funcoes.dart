import 'package:pucpay_prototype/global.dart';

getCreditUser() async{
  cEst = await retornaEst();
  cImp = await retornaImp();
}

retornaEst() async{

  int valor = (await valorCreditoEst());
  print(valor);

  return (int.parse(valor.toString()));

}

retornaImp() async{

  int valor2 = await valorCreditoImp();

  return (int.parse(valor2.toString()));
}


 Future<int> valorCreditoEst() async{

  String credEst;

  credEst = getCreditos(userId,1);

  var aux = await conn.query(credEst);
  print(aux);
  var aux2 = aux['data']['cadastro'];
  print(aux2);

  var c = aux2.map<int>((m) => m['credit_est'] as int).toList();
  print("eba " + c[0].toString());

  return c[0];

}

 Future<int> valorCreditoImp() async{

  String credImp;

  credImp = getCreditos(userId,2);

  var aux = await conn.query(credImp);
  print(aux);
  var aux2 = aux['data']['cadastro'];
  print(aux2);

  var c = aux2.map<int>((m) => m['credit_imp'] as int).toList();
  print("eba " + c[0].toString());

  return c[0];

}