import 'package:flutter/material.dart';

class SelectPag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Center(child: Text("",textAlign: TextAlign.center))
      ),
      body: Container(
         padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
          Padding(padding: const EdgeInsets.only(bottom:40,),),
          
          ],
        ),
      ),
    );
  }
}