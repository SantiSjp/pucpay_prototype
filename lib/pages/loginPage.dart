import 'package:flutter/material.dart';
import 'package:pucpay_prototype/pages/forgotPage.dart';
import 'package:pucpay_prototype/pages/menuPage.dart';
import 'package:pucpay_prototype/global.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _login = TextEditingController();
  final _pass = TextEditingController();
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
                onPressed: () async {
                  print("LOGIN");
                 //doLogin(context, _login.text, _pass.text,_scaffoldKey);
                  /*try{
                    var r = await conn.mutation(docInsert);
                    print(r['data']);
                    var a = (r['data']);
                    print(a['insert_teste']);
                    var b = a['insert_teste'];
                    var c = b.map<int>((m) => m['id'] as int).toList();
                    var d = b.map<String>((m) => m['name'] as String).toList();
                    print(c);
                    print(d);
                    if(c != []){print("SDSDAS");}
                    //var b =(a['teste']) as String;
                    //print(b);

                  }catch(e){
                    print(e);
                  }*/
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



      _key.currentState.showSnackBar(SnackBar(
        content: Text("Logged In"),
        backgroundColor: Colors.green,
      ));

  } catch(e){
    print("Error: ${e.code}");
    _key.currentState.showSnackBar(SnackBar(
        content: Text(error),
        backgroundColor: Colors.redAccent,
      ));
     //Navigator.pop(context);    
  }
  FocusScope.of(context).requestFocus(new FocusNode());
}