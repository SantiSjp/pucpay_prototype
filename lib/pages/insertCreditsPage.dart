import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("PucPay",textAlign: TextAlign.center))
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Padding(padding: const EdgeInsets.only(bottom:20,),),
          Center(
            child: Text(
              'Adicionar Créditos',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
            )
          ),
        
          Padding(padding: const EdgeInsets.only(bottom:40,),),
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
                Image.asset("assets/autopark_logo.png",width: 110.0 ,height: 60.0,),
                Padding(padding: const EdgeInsets.only(right:25,),),
                Text(
                  'Estacionamento',
                  style: TextStyle(fontSize: 20),
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
                Image.asset("assets/logo_selbetti.png",width: 120.0 ,height: 60.0,),
                Padding(padding: const EdgeInsets.only(right:20,),),
                Text(
                  'Impressao',
                  style: TextStyle(fontSize: 20),
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

          Padding(padding: const EdgeInsets.only(bottom:40,),),
          TextFormField(
            style: new TextStyle(color: Colors.black, fontSize: 15),
            decoration: InputDecoration(
              labelText: 'Digite o valor a inserir...'
            )
          ),

          Padding(padding: const EdgeInsets.only(bottom:50,),),
          
          Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(right:20,),),
              ButtonTheme(
               child: SizedBox(
               width: 130,
               height: 50 ,
                child: RaisedButton(
                onPressed: (){

                },
                child: Text("Voltar",style: TextStyle(color: Colors.white),),
                color: Color.fromRGBO(84, 84, 84, 33),
             ))),

              Padding(padding: const EdgeInsets.only(right:90,),),
              ButtonTheme(
               child: SizedBox(
               width: 130,
               height: 50 ,
                child: RaisedButton(
                onPressed: (){

                },
                child: Text("Confirmar",style: TextStyle(color: Colors.white),),
                color: Color.fromRGBO(84, 84, 84, 33),
             ))),
            ],
          )
          
        ],
      ),
     
    );
  }
}
