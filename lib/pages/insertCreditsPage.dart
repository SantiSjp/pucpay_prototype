import 'package:flutter/material.dart';
import 'package:pucpay_prototype/global.dart';
import 'selectPaymentPage.dart';
import 'package:pucpay_prototype/funcoes.dart';

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
            keyboardType: TextInputType.number,
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
                  criaLoading(context, false);
                  insertCredits(_credito.text, _scaffoldKey,botaoEstacionamento,botaoImpressao, context);
                  setState(() {
                   botaoEstacionamento = false;
                   botaoImpressao = false; 
                  });
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


void insertCredits(credito, _key, bEstacionamento,bImpressao, context) async{

  String insert;
  var valor;
  int newValor;
  int valorBoleto;
  print("aqui");

  try {

    valor = await _getCredito(bEstacionamento,bImpressao);
    print("here: " + valor.toString());


    newValor = int.parse(credito);
    valorBoleto = int.parse(credito);


    if(newValor<=0){
      throw new Exception("O valor do crédito não pode ser negativo");
    }

    newValor += valor;

    if(!bEstacionamento && !bImpressao){
      throw new Exception("Selecione um tipo de credito");
    }
    
    if(bEstacionamento){
      insert = insertCredit(userId, newValor, 1);
      //_nextScreen(context, PaymentCredit());
    }
    if(bImpressao){
        insert = insertCredit(userId, newValor, 2);
    }

      var aux2 = await conn.mutation(insert);
      print("insert: " + aux2.toString());

      _key.currentState.showSnackBar(SnackBar(
      content: Text("Creditos Inseridos"),
      backgroundColor: Colors.green,
      ));


      Navigator.push(
      context, 
      new MaterialPageRoute(builder: (context) => SelectPag(valorBoleto)),
      );

     

    //Navigator.pop(context);   
    }catch (e) {
      print(e);

      _key.currentState.showSnackBar(SnackBar(
        content: Text(e.message),
        backgroundColor: Colors.redAccent,
      ));
    }
  
}

Future<int> _getCredito(bEstacionamento,bImpressao) async{

  
  String credEst;
  String credImp;
  int value = 0;
  
  try {

    if(bEstacionamento){

      credEst = getCreditos(userId, 1);

      var aux = await conn.query(credEst);
      print("have: " + aux.toString());

      var a = aux['data']['cadastro'];
      print(a);

      var b = a.map<int>((m) => m['credit_est'] as int).toList();
      print(b[0]);
      value = b[0];

    }
    if(bImpressao){
      credImp = getCreditos(userId, 2);

      var aux = await conn.query(credImp);
      print("have: " + aux.toString());

      var a = aux['data']['cadastro'];
      print(a);

      var b = a.map<int>((m) => m['credit_imp'] as int).toList();
      print(b[0]);
      value = b[0];

    }
    
  } catch (e) {

    print(e);

  }
  return value;
}
