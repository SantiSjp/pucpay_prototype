import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pucpay_prototype/pages/forgotPage.dart';

class LoginPage extends StatefulWidget {
  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showLogo(){
  return Container(
    child: Image.asset("assets/logo_t.png",width: 1000.0 ,height: 250.0,)
  );
}

final _login = TextEditingController();
final _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: EdgeInsets.only(
          top: 60,
          left: 30,
          right: 30
        ),
      child: ListView(                      
          children: <Widget>[
            _showLogo(),
            TextFormField(
              controller: _login,
            //autofocus: true,
              style: new TextStyle(color: Colors.black, fontSize: 15),
              decoration: InputDecoration(
              labelText: 'Insira seu usuário'
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
                onPressed: () {
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
      )
    ),
    );
  }
}

void doLogin(BuildContext context,login,pass,_key) async{
  try{

    print('EMAIL é: $login');
    print('SENHA é: $pass');
    FirebaseUser user = (await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: login, password: pass)).user;

      /*if(user != null){
        _pass.text = '';
        Navigator.pop(context);
      }*/

      print('Signed In: ${user.uid}');
      _key.currentState.showSnackBar(SnackBar(
        content: Text("Logged In"),
        backgroundColor: Colors.green,
      ));

  } catch(e){
    print("Error: ${e.toString()}");
    _key.currentState.showSnackBar(SnackBar(
        content: Text("ERRO Verefique seu Login"),
        backgroundColor: Colors.redAccent,
      ));
     //Navigator.pop(context);    
  }
  FocusScope.of(context).requestFocus(new FocusNode());
}