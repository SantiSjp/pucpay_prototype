import 'package:flutter/material.dart';

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
            botao("Login",context),
            Divider(height: 40, color: Colors.transparent),
            botao("Cadastro",context),
            Divider(height: 40, color: Colors.transparent),
            botao("Pagar via scan",context)
          ],
        )
      ),
    );
  }
}


Widget botao(text,context){
  return SizedBox(
    width: 130,
      child: ButtonTheme(
        child: RaisedButton(
          onPressed: (){},
          child: Text(text, style: TextStyle(color: Colors.white)),
          color: Color.fromRGBO(104, 104, 104, 10),   //Definindo Cor para botão,
        ),
       )
   );  
}
