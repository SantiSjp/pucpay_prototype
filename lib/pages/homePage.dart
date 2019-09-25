import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'signupPage.dart';
import 'package:pucpay_prototype/global.dart';

class Homepage extends StatelessWidget {
 
  _showLogo(){
  return Container(
    child: Image.asset("assets/logo_t.png",width: 1000.0 ,height: 250.0,)
  );
  }

  @override
 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Divider(height: 60, color: Colors.transparent),
            _showLogo(),
            botao("Login",context,LoginPage()),
            Divider(height: 40, color: Colors.transparent),
            botao("Cadastro",context,Signup()),
            Divider(height: 40, color: Colors.transparent),
            botao("Pagar via scan",context,LoginPage()),
          ],
        )
      ),
    );
  }
}


Widget botao(text,context,route){
  return SizedBox(
    width: 130,
      child: ButtonTheme(
        child: RaisedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => route));
          },
          child: Text(text, style: TextStyle(color: Colors.white)),
          color: Color.fromRGBO(104, 104, 104, 10),   //Definindo Cor para botão,
        ),
       )
   );  
}
