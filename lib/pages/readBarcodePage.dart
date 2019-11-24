import 'package:flutter/material.dart';  
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


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
               FloatingActionButton(  
                onPressed: scanCode,  
                tooltip: 'Scan',  
                child: Icon(Icons.scanner),  
              ),  
          ],
        ),
      ),
    );
  }


  _barcodeScan() async{

    try{

      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#9400D3", "CANCEL", false, ScanMode.QR);

    print(barcodeScanRes);

    }catch(e){
      print(e.toString());
    }
  }


}