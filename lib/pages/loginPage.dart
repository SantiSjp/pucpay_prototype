import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  
  _showLogo(){
  return Container(
    child: Image.asset("assets/logo_t.png",width: 1000.0 ,height: 250.0,)
  );
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            //autofocus: true,
              style: new TextStyle(color: Colors.black, fontSize: 15),
              decoration: InputDecoration(
              labelText: 'Insira seu usuário'
            ),
          ),
            Divider(height: 10, color: Colors.white),
            TextFormField(
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
                 onPressed: () {},
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
                onPressed: () {},
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