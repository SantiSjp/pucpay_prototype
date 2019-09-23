import 'package:flutter/material.dart';

Widget teste(BuildContext context) {
  return Text(
    'Teste de Funcao',
    style: TextStyle(fontSize: 30)
    );
}
class InsertCredits extends StatelessWidget {

  const InsertCredits();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
        title: Center(child: Text("PucPay",textAlign: TextAlign.center))
        ),

        body: new Center(
          child: new Column(
            children: <Widget>[

              Padding(padding: const EdgeInsets.only(bottom:35,),),

              new Text(
                'Adicionar Créditos', 
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                ),

              Padding(padding: const EdgeInsets.only(bottom:60,),),

              Align(
                alignment: Alignment(-0.7, 0),
                child: new Text(
                      'Tipo de Crédito',
                      style: TextStyle(fontSize: 30)
                      ),
              ),

              Padding(padding: const EdgeInsets.only(bottom:30,),),
              Row(children: <Widget>[
                Padding(padding: const EdgeInsets.only(right: 30,),),
                createCehckBox(context),
                Padding(padding: const EdgeInsets.only(right: 30,),),
                new Text(
                  'Créditos de Impressão',
                  style: TextStyle(fontSize: 20),
                  ),
              ],),
              
              Padding(padding: const EdgeInsets.only(bottom:10,),),
              Row(children: <Widget>[
                Padding(padding: const EdgeInsets.only(right: 30,),),
                createCehckBox(context),
                Padding(padding: const EdgeInsets.only(right: 30,),),
                new Text(
                  'Créditos do Estacionamento',
                  style: TextStyle(fontSize: 20),
                  ),
              ],),

              Padding(padding: const EdgeInsets.only(bottom:30,),),
              Align(
                alignment: Alignment(-0.7,0), 
                child: new Text(
                  'Valor a inserir',
                  style: TextStyle(fontSize: 30),
                  ),
              ),

              Padding(padding: const EdgeInsets.only(bottom:20,),),
              Container(
                alignment: Alignment(-0.9,0), 
                child: TextFormField(
                  style: new TextStyle(color: Colors.black, fontSize: 15),
                  decoration: InputDecoration(
                    labelText: 'Digite o valor a inserir...'
                  ),
                ),
              ),
              
            ],
          ),
        )

     );
  }
}

Widget createCehckBox(BuildContext context) {
  return Align(
    alignment: Alignment(-0.8,0),
    child: SizedBox(
      width: 30,
      height: 30,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top:    BorderSide(width: 2.5, color: Color(0x0090000000),),
            bottom: BorderSide(width: 2.5, color: Color(0x0090000000),),
            left:   BorderSide(width: 2.5, color: Color(0x0090000000),),
            right:  BorderSide(width: 2.5, color: Color(0x0090000000),),
          ),
        ),
        child: ButtonTheme(
          buttonColor: Color.fromARGB(255, 255, 255, 255),
          child: RaisedButton(
            onPressed: () {
              //indicar qual botão foi pressionado
            },
          ),
        )
      ),
    ),
  );  
}