import 'package:flutter/material.dart';
import 'package:pucpay_prototype/pages/forgotPage.dart';
import 'package:pucpay_prototype/pages/menuPage.dart';
import 'package:pucpay_prototype/global.dart';
import 'package:pucpay_prototype/funcoes.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _login = TextEditingController();
  final _pass = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  _showLogo(){
  return Container(
    child: Image.asset("assets/logo_t.png",width: 1000.0 ,height: 250.0,)
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: EdgeInsets.only(
          top: 30,
          left: 30,
          right: 30
        ),
      child: isLoading ? 
      Column( 
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
         Divider(height: 10,color: Colors.transparent,),
          Text("Logando...")
        ],
      ) 
      : ListView(                      
          children: <Widget>[
            _showLogo(),
            TextFormField(
              controller: _login,
              keyboardType: TextInputType.emailAddress,
            //autofocus: true,
              style: new TextStyle(color: Colors.black, fontSize: 15),
              decoration: InputDecoration(
              labelText: 'Insira seu email'
            ),
          ),
            Divider(height: 10, color: Colors.white),
            TextFormField(
              controller: _pass,
             obscureText: true,
             style: new TextStyle(color: Colors.black, fontSize: 15),
              decoration: InputDecoration(
              labelText: 'Insira sua senha'
               ),
              ),
            Container(
              child: Row(
                children: <Widget>[
                FlatButton(
                 onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPass()));
                 },
                  child: const Text(
                  'Esqueci a senha',
                  style: TextStyle(fontSize: 10)
              ),
            ),
              SizedBox(
                width: 100,
                height: 0,
              ),
              RaisedButton(
                onPressed: (){
                  setState(() {
                    isLoading = true;
                  });
                  print("LOGIN");
                  doLogin(context, _login.text, _pass.text,_scaffoldKey);
                  },
                child: const Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 10)

                 ),
               )
                ]
              )
            )
      ]
      ),
    ),
    );
  }
}

void doLogin(BuildContext context,login,pass,_key) async{
  try{

    print('EMAIL é: $login');
    print('SENHA é: $pass');

    if(login == ""){
      throw new Exception("Empty_Mail_Error");
    }
    if(pass == ""){
      throw new Exception("Empty_pass_Error");
    }


    String userLog = getUserLog(login,pass);

    var verifyLog = await conn.query(userLog).catchError((e){
      throw new Exception("ERROR");
    });

    var dataLog = verifyLog['data']['cadastro'];

    print(dataLog);

    var uid = dataLog.map<String>((m) => m['UID'] as String).toList();
    var nome = dataLog.map<String>((m) => m['nome'] as String).toList();
    var matricula = dataLog.map<int>((m) => m['matricula'] as int).toList();

    print(uid.isEmpty);
    print(nome.isEmpty);
    print(matricula.isEmpty);


    if(uid.isEmpty || nome.isEmpty || matricula.isEmpty){
      throw new Exception("Usuario inválido");
    }

    userId = uid[0];
    nomeUser = nome[0];
    matriculaUser = matricula[0];

      _key.currentState.showSnackBar(SnackBar(
        content: Text("Logged In"),
        backgroundColor: Colors.green,
      ));

    getCreditUser();

     Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MenuScreen()),
            (Route<dynamic> route) => false,);

  } catch(e){
    print(e.toString());

    _key.currentState.showSnackBar(SnackBar(
      content: Text(e.message),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));  

    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,);
  }
  FocusScope.of(context).requestFocus(new FocusNode());
}

