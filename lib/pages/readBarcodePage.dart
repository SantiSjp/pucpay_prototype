import 'package:flutter/material.dart';  
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'paymentCreditPage.dart';
import 'package:pucpay_prototype/global.dart';


class Barcode extends StatefulWidget {
  @override
  _BarcodeState createState() => _BarcodeState();
}

class _BarcodeState extends State<Barcode> {
final _scaffoldKey = GlobalKey<ScaffoldState>();

String barcode = "";  
Future scanCode() async {  
   try {  
     String barcode = await BarcodeScanner.scan();  
     setState(() => this.barcode = barcode);  
   } catch (e) {  
     if (e.code == BarcodeScanner.CameraAccessDenied) {  
       setState(() {  
         this.barcode = 'The user did not grant the camera permission!';  
       });  
     } else {  
       setState(() => this.barcode = 'Unknown error: $e');  
     }  
   }  
   print(barcode);
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text("BARCODE",textAlign: TextAlign.center))
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
             ButtonTheme(
               child: SizedBox(
               width: 270,
               height: 50 ,
                child: RaisedButton(
                onPressed: (){
                  _barcodeScan();
                },
                child: Text("SCAN",style: TextStyle(color: Colors.white),),
                //color: Colors.grey,
                color: Color.fromRGBO(84, 84, 84, 33),
             ))),
          ],
        ),
      ),
    );
  }


  _barcodeScan() async{

    try{

      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#FF0000", "Cancelar", false, ScanMode.BARCODE);

    print(barcodeScanRes);

    }catch(e){

      print(e.toString());

    }

    nextScreen(context, PaymentCredit());
  }

}