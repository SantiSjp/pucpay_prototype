import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'loginPage.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen(this.log);

  final String log;

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

    //Navigator.pushReplacementNamed(context, "/menu");
    //Navigator.popUntil(context, ModalRoute.withName('/login'));
    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
}

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
        title: Center(child: Text("PucPAY",textAlign: TextAlign.center)
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
                '$log',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Matrícula: xxxxx',
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
        Text('Menu PucPAY',
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
                onPressed: (){},
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
                onPressed: (){},
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

  CollectionReference col = Firestore.instance.collection("users");

  Query nameQuery = col.where('nome', isEqualTo:'gabriel');

  Query valorNameQuery = nameQuery.where('login', isEqualTo: 'gab.b');

  print(valorNameQuery);

   Firestore.instance
        .collection('users')
        .document('gab.b')
        .get()
        .then((DocumentSnapshot ds) {
      // use ds as a snapshots
        dynamic a = (ds.data.values.toList());
        print(a);
    });
 
}