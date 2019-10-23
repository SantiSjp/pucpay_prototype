import 'package:flutter/material.dart';
import 'package:pucpay_prototype/pages/manageCredits.dart';
import 'insertCreditsPage.dart';
import 'package:pucpay_prototype/global.dart';
//import 'loginPage.dart';

class MenuScreen extends StatelessWidget {

  _show(){                                //Método Privado para exibir o logo da PucPAY
    return Container(
       alignment : Alignment(7,1),
       child: Image.asset("assets/logo_t.png", width: 100.0, height: 70.0,), 
     
      );
 }

 _showB(){                                //Método Privado para exibir o logo da PucPAY
  return Container(
       alignment : Alignment(7,1),
       child: Image.asset("assets/tt.png", width: 60.0, height: 70.0,), 
     
      );
 }

_navigateToInitialPage(context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
}

_nextScreen(context, Widget route){
  Navigator.push(
    context, 
    new MaterialPageRoute(builder: (context) => route),
    );
}

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
        title: Center(child: Text("PUCpay",textAlign: TextAlign.center)
        ),
      ),
  body: Container(
    padding: const EdgeInsets.all(25),
    child: Column(
      children: <Widget>[
        Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Aluno: $nomeUser',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Matrícula: $matriculaUser',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
              ],
            ),
            Column( children: <Widget>[_showB()]),
            _show()
          ],
        ),
        Divider(height: 20,color: Colors.white,),
        Text('Menu PUCpay',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        Divider(height: 20,color: Colors.white),
         ButtonTheme(
               child: SizedBox(
               width: 270,
               height: 50 ,
                child: RaisedButton(
                onPressed: (){
                  getData();
                },
                child: Text("Visualizar histórico de pagamento",style: TextStyle(color: Colors.white),),
                //color: Colors.grey,
                color: Color.fromRGBO(84, 84, 84, 33),
             ))),
             Divider(height: 20,color: Colors.white),
          ButtonTheme(
               child: SizedBox(
               width: 270,
               height: 50 ,
                child: RaisedButton(
                onPressed: () async {
                  cEst = await retornaEst();
                  cImp = await retornaImp();
                  _nextScreen(context, ManageCredits());
                },
                child: Text("Visualizar crédito da carteirinha",style: TextStyle(color: Colors.white),),
                //color: Colors.grey,
                color: Color.fromRGBO(84, 84, 84, 33),
             ))),
              Divider(height: 20,color: Colors.white),
             ButtonTheme(
               child: SizedBox(
               width: 270,
               height:50 ,
                child: RaisedButton(
                onPressed: (){
                  _nextScreen(context, InsertCredits());
                },
                child: Text("Inserir créditos na carteirinha",style: TextStyle(color: Colors.white),),
                //color: Colors.grey,
                color: Color.fromRGBO(84, 84, 84, 33),
             ))),
              Divider(height: 20,color: Colors.white),
             ButtonTheme(
               child: SizedBox(
               width: 270,
               height:50 ,
                child: RaisedButton(
                onPressed: (){},
                child: Text("Pagar ticket do estacionamento",style: TextStyle(color: Colors.white),),
                //color: Colors.grey,
                color: Color.fromRGBO(84, 84, 84, 33),
             ))),
             Divider(height: 20,color: Colors.white),
             ButtonTheme(
               child: SizedBox(
               width: 270,
               height:50 ,
                child: FlatButton(
                onPressed: (){
                  userId = 0;
                  nomeUser = '';
                  matriculaUser = 0;
                  cEst = 0; cImp = 0;
                  print(userId);
                  _navigateToInitialPage(context);
                },
                child: Text("Logout",style: TextStyle(color: Colors.white),),
                //color: Colors.grey,
                color: Color.fromRGBO(84, 84, 84, 33),
             )))
              
      ],
    ),
  ),
);
}
}

 getData(){

//var a = Firestore.instance.collection('users').where('login',isEqualTo:'santi').snapshots()

 
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