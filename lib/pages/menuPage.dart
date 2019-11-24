import 'package:flutter/material.dart';
import 'package:pucpay_prototype/pages/manageCredits.dart';
import 'insertCreditsPage.dart';
import 'paymentCadPage.dart';
import 'package:pucpay_prototype/global.dart';
import 'readBarcodePage.dart';

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
        Divider(height: 10,color: Colors.white,),
        Text('Menu PUCpay',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        Divider(height: 20,color: Colors.white),
         ButtonTheme(
               child: SizedBox(
               width: 270,
               height: 50 ,
                child: RaisedButton(
                onPressed: (){
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
                onPressed: (){
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
                onPressed: (){
                  _nextScreen(context, Barcode());
                },
                child: Text("Pagar ticket do estacionamento",style: TextStyle(color: Colors.white),),
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
                  _nextScreen(context, PaymentCad());
                },
                child: Text("Cadastrar método de Pagamento",style: TextStyle(color: Colors.white),),
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
