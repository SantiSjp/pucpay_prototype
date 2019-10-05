import 'package:flutter/material.dart';
import 'package:pucpay_prototype/global.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final _login = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showLogo(){
  return Container(
    child: Image.asset("assets/logo_t.png",width: 1000.0 ,height: 250.0,)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
    body: Padding(
        padding: EdgeInsets.only(
          top: 30,
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
              labelText: 'Insira seu email'
            ),
          ),
            Divider(height: 10, color: Colors.white,),

            Container(
              child: Column(
                children: <Widget>[
                Divider( color: Colors.white,),
              RaisedButton(
                onPressed: () {
                  forgot(_login.text,_scaffoldKey);
                },
                child: const Text(
                  'Recuperar a Senha',
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

void forgot(_login,_key) async{
  try{
    
    _key.currentState.showSnackBar(SnackBar(
        content: Text("Email enviado"),
        backgroundColor: Colors.blueAccent,
      ));
  }catch(e){
   print("Error: ${e.toString()}");
   _key.currentState.showSnackBar(SnackBar(
        content: Text("ERRO Verefique seu Login"),
        backgroundColor: Colors.redAccent,
      ));
  }
}