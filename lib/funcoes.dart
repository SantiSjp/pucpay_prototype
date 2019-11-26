import 'package:pucpay_prototype/global.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';


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


void retornaTela(context,page){
  
   Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => page),
              (Route<dynamic> route) => false,);
}

criaLoading(context){
  ProgressDialog pr;
  pr = new ProgressDialog(context);
  
  style(pr);
  pr.show();

 

  return pr;
}

void style(pr){

  pr.style(
    message: 'Carregando...',
    borderRadius: 1.0,
    backgroundColor: Colors.white,
    progressWidget: CircularProgressIndicator(),
    elevation: 1.0,
    insetAnimCurve: Curves.easeInOut,
    progress: 0.0,
    maxProgress: 99.0,
    progressTextStyle: TextStyle(
      color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
    messageTextStyle: TextStyle(
      color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
  );


}