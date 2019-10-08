import 'package:flutter/material.dart';
import 'package:pucpay_prototype/global.dart';

enum TipoDeCredito {Impressao, Estacionamento}
int _tipoCredito = 0;
bool botaoEstacionamento = false;
bool botaoImpressao = false;
class InsertCredits extends StatefulWidget {
  InsertCredits();

  @override
  _InsertCreditsState createState() => _InsertCreditsState();
}

class _InsertCreditsState extends State<InsertCredits> {
final _credito = TextEditingController();
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
        
          //Padding(padding: const EdgeInsets.only(bottom:40,),),
          Divider(height: 40,color: Colors.transparent,),
          Align(
            alignment: Alignment.bottomLeft,
            child: new Text(
              'Tipo de Crédito',
              style: TextStyle(fontSize: 26)
            ),
          ),

          Padding(padding: const EdgeInsets.only(bottom:40,),),
          CheckboxListTile(
            title: Row(
              children: <Widget>[
                Image.asset("assets/autopark_logo.png",width: 70.0 ,height: 60.0,),
                Padding(padding: const EdgeInsets.only(right:25,),),
                Text(
                  'Estacionamento',
                  style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            key: Key('Estacionamento'),
            value:  botaoEstacionamento,
            activeColor: Color.fromARGB(255, 255, 0, 0),
            onChanged: (value) {
              setState((){
                _tipoCredito = TipoDeCredito.Estacionamento.index;
                botaoEstacionamento = value;
                botaoImpressao = false;
                });
            },
  
          ),

          CheckboxListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/logo_selbetti.png",width: 70.0 ,height: 60.0,),
                Padding(padding: const EdgeInsets.only(right:25,),),
                Text(
                  'Impressão',
                  style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            key: Key('Impressao'),
            value:  botaoImpressao,
            activeColor: Color.fromARGB(255, 255, 0, 0),
            onChanged: (value) {
              setState((){
                _tipoCredito = TipoDeCredito.Impressao.index;
                botaoImpressao = value;
                botaoEstacionamento = false;
                });
            },
          ),       

          //Padding(padding: const EdgeInsets.only(bottom:40,),),
          Divider(height: 40,color: Colors.transparent,),
          TextFormField(
            controller: _credito,
            style: new TextStyle(color: Colors.black, fontSize: 15),
            decoration: InputDecoration(
              labelText: 'Digite o valor a inserir...'
            )
          ),

          //Padding(padding: const EdgeInsets.only(bottom:50,),),
          Divider(height: 50,color: Colors.transparent,),
          
          Row(
            children: <Widget>[
              //Padding(padding: const EdgeInsets.only(right:10,),),
              ButtonTheme(
               child: SizedBox(
               width: 130,
               height: 50 ,
                child: RaisedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Voltar",style: TextStyle(color: Colors.white),),
                color: Color.fromRGBO(84, 84, 84, 33),
             ))),

              Padding(padding: const EdgeInsets.only(right:40,),),
              ButtonTheme(
               child: SizedBox(
               width: 130,
               height: 50 ,
                child: RaisedButton(
                onPressed: (){
                  insertCredits(_credito.text);
                  setState(() {
                   botaoEstacionamento = false;
                   botaoImpressao = false; 
                  });
                  _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text("Creditos Inseridos"),
                  backgroundColor: Colors.green,
                ));
                },
                child: Text("Confirmar",style: TextStyle(color: Colors.white),),
                color: Color.fromRGBO(84, 84, 84, 33),
             ))),
            ],
          )
          
        ],
      ),
      ) 

    );
  }
}


void insertCredits(credito) async{

  String insert;

  if(botaoEstacionamento){
    insert = insertCredit(userId, credito, 1);
    print('1');
  }
  if(botaoImpressao){
      insert = insertCredit(userId, credito, 2);
      print('2');
  }

  try {

    var aux = await conn.mutation(insert);
    print(aux);

   //Navigator.pop(context);   
  }catch (e) {
    print(e);
  }
  
}