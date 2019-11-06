import 'package:flutter/material.dart';

class PaymentCad extends StatefulWidget {
  @override
  _PaymentCadState createState() => _PaymentCadState();
}

class _PaymentCadState extends State<PaymentCad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
      title: Center(child: Text("",textAlign: TextAlign.center))
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: <Widget>[
            Divider(height: 20,color: Colors.transparent,),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Cadastrar Pagamento',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
            ],),
            Divider(height: 40,color: Colors.transparent,),
            Align(
            alignment: Alignment.center,
            child: new Text(
              'Tipo de Pagamento',
              style: TextStyle(fontSize: 26)
            ),
          ),
          ],
        ),
      ),
    );
  }
}