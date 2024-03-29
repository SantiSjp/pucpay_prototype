import 'package:flutter/material.dart';
import 'package:pucpay_prototype/global.dart';
import 'package:pucpay_prototype/funcoes.dart';

class ManageCredits extends StatefulWidget {
  @override
  _ManageCreditsState createState() => _ManageCreditsState(); 
}

class _ManageCreditsState extends State<ManageCredits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("",textAlign: TextAlign.center)),
        actions: <Widget>[
           IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                getCreditUser();
              });
           }
          )
        ],
      ),
      body: Container(
      padding: EdgeInsets.all(25) ,
      child: Column(
        children: <Widget>[
          Divider(height: 20,color: Colors.transparent,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Saldo de Créditos',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
            ],
          ),
          Divider(height: 50,color: Colors.transparent,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Créditos de Impressão',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500))
            ],
          ),
          Divider(height: 25,color: Colors.transparent,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('R\$ $cImp,00 ',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500))
            ],
          ),
          Divider(height: 10,color: Colors.transparent,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/logo_selbetti.png",width: 120.0 ,height: 60.0,),
                Padding(padding: const EdgeInsets.only(right:0,),),
            ],
          ), 
          Divider(height: 10,color: Colors.transparent,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Créditos de Estacionamento',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500)),
              
            ],
          ),
          Divider(height: 25,color: Colors.transparent,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('R\$ $cEst,00 ',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),

            ],
          ),
          Divider(height: 10,color: Colors.transparent,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/autopark_logo.png",width: 120.0 ,height: 60.0,),
                Padding(padding: const EdgeInsets.only(left:0,),),
            ],
          ),
          Divider(height: 20,color: Colors.transparent,),
              SizedBox(
              width: 100,
                child: ButtonTheme(
                  padding: EdgeInsets.only(left: 0),
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.pop(context);
                      //getCreditoEst();
                    },
                    child: Text('Voltar', style: TextStyle(color: Colors.white)),
                    color: Color.fromRGBO(104, 104, 104, 10),   //Definindo Cor para botão,
                  ),
                )
            )
        ],
      ),
    )
    );
  }
}
