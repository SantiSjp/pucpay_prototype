import 'package:flutter/material.dart';
import 'cadCreditPage.dart';
import 'testPage.dart';

enum TipoDePgto {Paypal, Cartao}
int _tipoPagto = 0;
bool botaoCredito = false;
bool botaoPaypal = false;
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
          Padding(padding: const EdgeInsets.only(bottom:40,),),
          CheckboxListTile(
            title: Row(
              children: <Widget>[
                Image.asset("assets/card.png",width: 70.0 ,height: 60.0,),
                Padding(padding: const EdgeInsets.only(right:25,),),
                Text(
                  'Crédito',
                  style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            key: Key('Crédito'),
            value:  botaoCredito,
            activeColor: Color.fromARGB(255, 255, 0, 0),
            onChanged: (value) {
              setState((){
                _tipoPagto = TipoDePgto.Cartao.index;
                botaoCredito = value;
                botaoPaypal = false;
                });
            },
          ),
          Padding(padding: const EdgeInsets.only(bottom:20,),),
          CheckboxListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/paypal2.png",width: 70.0 ,height: 60.0,),
                Padding(padding: const EdgeInsets.only(right:25,),),
                Text(
                  'PayPal',
                  style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            key: Key('PayPal'),
            value:  botaoPaypal,
            activeColor: Color.fromARGB(255, 255, 0, 0),
            onChanged: (value) {
              setState((){
                _tipoPagto = TipoDePgto.Paypal.index;
                botaoPaypal = value;
                botaoCredito = false;
                });
            },
          ),
           Divider(height: 150,color: Colors.transparent,),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(right:10,),),
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
                  setState(() {
                    if(botaoCredito){
                      _nextScreen(context, CadCredit());
                    }

                    if(botaoPaypal){
                      String url = "https://www.paypal.com/br/signin";
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => TestPage(url)),
      );
                    }

                   botaoCredito = false;
                   botaoPaypal = false; 
                  });
                },
                child: Text("Confirmar",style: TextStyle(color: Colors.white),),
                color: Color.fromRGBO(84, 84, 84, 33),
             ))),
            ],
          )
          ],
        ),
      ),
    );
  }
}

_nextScreen(context, Widget route){
  Navigator.push(
    context, 
    new MaterialPageRoute(builder: (context) => route),
    );
}