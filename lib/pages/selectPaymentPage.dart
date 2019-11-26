import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:pucpay_prototype/global.dart';
import 'menuPage.dart';
import 'testPage.dart';


enum TipoDePgto {Boleto, Cartao}
int _tipoPagto = 0;
bool botaoCredito = false;
bool botaoBoleto = false;
class SelectPag extends StatefulWidget {
  final int valor;
  SelectPag(this.valor);
    @override
  _SelectPag createState() => _SelectPag();
}

class _SelectPag extends State<SelectPag> {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Divider(height: 20,color: Colors.transparent,),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Selecionar pagamento',
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
            key: Key('CreditCard'),
            value:  botaoCredito,
            activeColor: Color.fromARGB(255, 255, 0, 0),
            onChanged: (value) {
              setState((){
                _tipoPagto = TipoDePgto.Cartao.index;
                botaoCredito = value;
                botaoBoleto = false;
                });
            },
          ),
          Padding(padding: const EdgeInsets.only(bottom:20,),),
          CheckboxListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/boleto.png",width: 70.0 ,height: 60.0,),
                Padding(padding: const EdgeInsets.only(right:25,),),
                Text(
                  'Boleto',
                  style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            key: Key('Boleto'),
            value:  botaoBoleto,
            activeColor: Color.fromARGB(255, 255, 0, 0),
            onChanged: (value) {
              setState((){
                _tipoPagto = TipoDePgto.Boleto.index;
                botaoBoleto = value;
                botaoCredito = false;
                });
            },
          ),
          Text('AVISO: Valor minimo para boleto R\$5,00'),
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
                      verificaCartao(context, _scaffoldKey);
                    }

                    if(botaoBoleto){
                      var cred = widget.valor;
                      boleto(context,cred,_scaffoldKey);
                    }
                    
                   botaoCredito = false;
                   botaoBoleto = false; 
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

void boleto(context, valor, _key)async{

  try{

  var now = new DateTime.now();
  var a = now.add(new Duration(days:4));
  var data = a.year.toString() + "-" + a.month.toString() + "-" + a.day.toString(); 


  getEmail(_key);
  print(userMail);

  var body = jsonEncode({"periodicity":"monthly",
   "reference":"Pedido insercao de creditos",
   "firstDueDate":"$data",
   "numberOfPayments":1,
   "amount":"$valor.0",
   "description":"Creditos PUCpay",
   "customer":{  
      "document":{  
         "type":"CPF",
         "value":"21040572057"
      },
      "name":"$nomeUser .",
      "email":"$userMail",
      "phone":{  
         "areaCode":"41",
         "number":"32711555"
      },
      "address": {
         "postalCode": "80215901",
         "street": "Rua Imaculada Conceicao",
         "number": "1155",
         "district": "Prado Velho",
         "city": "Curitiba ",
         "state": "PR"
      }
   }});

  var url = 'https://ws.pagseguro.uol.com.br/recurring-payment/boletos?email=santisjp@live.com&token=38dca5a7-47fb-4c8e-937c-05084a917a19c6b23ea44efd8645d0352a421aeeb5b9d277-ddc1-45b0-ae21-b51d3a25e4d7';
  var response = await http.post(url, 
  body: body , 
  headers: {
  'Content-type': 'application/json;charset=ISO-8859-1',
  'Accept': 'application/json;charset=ISO-8859-1'
  });
  

  var aux = response.body;
  print(jsonDecode(aux));
  var decode = jsonDecode(aux);

  print(decode['boletos'][0]['paymentLink']);

  String linkBoleto = decode['boletos'][0]['paymentLink'];
  Navigator.pop(context);
  Navigator.pop(context);
  //launch(linkBoleto);
  Navigator.push(context, new MaterialPageRoute(builder: (context) => TestPage(linkBoleto)),
      );

  }catch(e){
    print(e.toString());
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

void getEmail(_key) async{

  String queryMail = getMail();

  try{

    var mail = await conn.query(queryMail);
    print(mail);

    var aux = mail['data']['cadastro'][0]['email'];

    print(aux);

    userMail = aux;

  }catch(e){
    print(e.toString());

    _key.currentState.showSnackBar(SnackBar(
      content: Text(e.message),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
      )); 

  }



}