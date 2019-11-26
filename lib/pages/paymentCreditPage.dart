import 'package:flutter/material.dart';
import 'package:pucpay_prototype/pages/menuPage.dart';
import 'package:pucpay_prototype/global.dart';
import 'package:pucpay_prototype/funcoes.dart';

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
  int aux = cEst-5;
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
          Text('Créditos Após o pagamento R\$ $aux,00 '),
          Divider(height: 130,color: Colors.transparent,),
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
                      verificaCredito(context,_scaffoldKey,botaoCreditApp);
                    } 
                    if(botaoCreditCard){
                      verificaCartao(context,_scaffoldKey);
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


void verificaCredito(context,_key,bool cApp) async{
  try{

    int newValor;
    String insert;

    if(cEst < 5){
      throw new Exception("Créditos insuficientes");
    }

    newValor = cEst-5;

    insert = insertCredit(userId, newValor, 1);

    var updateCredit = await conn.mutation(insert);

    print(updateCredit);

    getCreditUser();

    inserePagamento();

    exibirDialogo(context, "Concluido", "Estacionamento pago e validado com sucesso!", "Continuar", MenuScreen());


  }catch(e){
    print(e.toString());

    _key.currentState.showSnackBar(SnackBar(
      content: Text(e.message),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));

  }

}

void verificaCartao(context,_key) async{

  try{  
    String query = getCard();

    var card =await conn.query(query);
    var cardId = card['data']['cards'][0];
    print(cardId);

    String title = "Pago com sucesso!";
    String content = "Estacionamento pago e validado com sucesso";
    inserePagamento();
    exibirDialogo(context, title, content, "Ok", MenuScreen());

  }catch(e){
    print(e.toString());

    if (e.message == "Invalid value"){

      _key.currentState.showSnackBar(SnackBar(
      content: Text("Usuário nao possui cartão"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
      ));  
      String title  = "Cartão não encontrado";
      String content = "Você não possui nenhum cartão cadastrado, por favor cadastre no menu inicial";
      exibirDialogo(context,title, content, "Ok", MenuScreen());

    }else{
      _key.currentState.showSnackBar(SnackBar(
      content: Text(e.message),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
      )); 
    }

  }

}

void inserePagamento() async{

  var now = new DateTime.now();
  var data = now.year.toString() + "-" + now.month.toString() + "-" + now.day.toString(); 

  String insere = insertPagamento(5, 2, data);
  print(insere);

  var mutation = await conn.mutation(insere);
  print(mutation);

}
