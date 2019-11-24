import 'package:flutter/material.dart';

class PaymentCredit extends StatefulWidget {
  @override
  _PaymentCreditState createState() => _PaymentCreditState();
}

class _PaymentCreditState extends State<PaymentCredit> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text("PucPay",textAlign: TextAlign.center))
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Padding(padding: const EdgeInsets.only(bottom:20,),),
            Center(
              child: Text(
              'Adicionar Créditos',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
              )
            ),
          ],
        ),
      ),
    );
  }

  

}
