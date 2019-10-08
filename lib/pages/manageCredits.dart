import 'package:flutter/material.dart';
import 'package:pucpay_prototype/global.dart';

class ManageCredits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("",textAlign: TextAlign.center))
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
              Text('R\$ 10,00 ',
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
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500))
            ],
          ),
          Divider(height: 25,color: Colors.transparent,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('R\$ 10,00 ',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500))
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


 dynamic getCreditoEst() async{

  String query = getCreditos(userId,1);
    var aux = await conn.query(query);
    print(aux);
    var aux2 = aux['data'];
    print(aux2);
    var aux3 = aux2['cadastro'];
    print(aux3);

    var c = aux3.map<int>((m) => m['credit_est'] as int).toList();
    print(c[0]);

    return c[0];

}