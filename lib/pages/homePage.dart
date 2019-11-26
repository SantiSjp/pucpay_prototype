import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:pucpay_prototype/pages/paymentCadPage.dart';
import 'loginPage.dart';
import 'signupPage.dart';
import 'testPage.dart';
import 'cadCreditMain.dart';
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
           SizedBox(
            width: 130,
              child: ButtonTheme(
                child: RaisedButton(
                  onPressed: (){
                    barcodeScan(context);
                  },
                  child: Text("Pagar via Scan", style: TextStyle(color: Colors.white)),
                  color: Color.fromRGBO(104, 104, 104, 10),   //Definindo Cor para botão,
                ),
              )
          ),
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

 barcodeScan(context) async{

    try{

      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#FF0000", "Cancelar", false, ScanMode.QR);

      print(barcodeScanRes);

    if(barcodeScanRes != "-1"){
    exibirDialogoScan2(context, "Ticket escaneado", "Prosseguir para pagamento com cartão de crédito?", "Sim","Não");
    }

    }catch(e){

      print(e.toString());

    }

  }

  void exibirDialogoScan2(context, String title, String content, String button1, String button2){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            child: Text(button2),
            onPressed: (){
              print(button2);
              Navigator.pop(context);
              //Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MenuScreen()),
              //(Route<dynamic> route) => false,);
            },
          ),
          FlatButton(
            child: Text(button1),
            onPressed: (){
              print(button1);
              //Navigator.pop(context);
              Navigator.push(
              context, 
              new MaterialPageRoute(builder: (context) => CadCreditMain()),
              );
            },
          )
        ],
      );
    }
  );
}

