import 'package:flutter/material.dart';
import 'package:pucpay_prototype/pages/menuPage.dart';
import 'package:pucpay_prototype/global.dart';

enum TipoDePgto {Paypal, Cartao}
int _tipoPagto = 0;
bool botaoCreditApp = false;
bool botaoCreditCard = false;
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
              Text('Pagar Estacionamento',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
            ],),
            Divider(height: 40,color: Colors.transparent,),
            Align(
            alignment: Alignment.center,
            child: new Text(
              'Método de Pagamento',
              style: TextStyle(fontSize: 26)
            ),
          ),
          Padding(padding: const EdgeInsets.only(bottom:40,),),
          CheckboxListTile(
            title: Row(
              children: <Widget>[
                Image.asset("assets/card.png",width: 70.0 ,height: 60.0,),
                Padding(padding: const EdgeInsets.only(right:20,),),
                Text(
                  'Cartão de Crédito',
                  style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            key: Key('Crédito'),
            value:  botaoCreditCard,
            activeColor: Color.fromARGB(255, 255, 0, 0),
            onChanged: (value) {
              setState((){
                _tipoPagto = TipoDePgto.Cartao.index;
                botaoCreditApp = false;
                botaoCreditCard = value;
                });
            },
          ),
          Padding(padding: const EdgeInsets.only(bottom:20,),),
          CheckboxListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/logo_t.png",width: 70.0 ,height: 60.0,),
                Padding(padding: const EdgeInsets.only(right:25,),),
                Text(
                  'Créditos App',
                  style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            key: Key('App'),
            value:  botaoCreditApp,
            activeColor: Color.fromARGB(255, 255, 0, 0),
            onChanged: (value) {
              setState((){
                _tipoPagto = TipoDePgto.Paypal.index;
                botaoCreditCard = false;
                botaoCreditApp = value;
                });
            },
          ),
          Text('Créditos Disponiveis R\$ $cEst,00 '),
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
                    if(botaoCreditApp){
                      verificaCredito(_scaffoldKey,botaoCreditApp);
                    } 

                   botaoCreditApp = false;
                   botaoCreditCard = false; 
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


void verificaCredito(_key,bool cApp){

  try{

    if(cEst < 5){
      throw new Exception("Créditos insuficientes");
    }


  }catch(e){
    print(e.toString());

    _key.currentState.showSnackBar(SnackBar(
      content: Text(e.message),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));

  }

}


void _nextScreen(context, Widget route){
  Navigator.push(
    context, 
    new MaterialPageRoute(builder: (context) => route),
    );
}
