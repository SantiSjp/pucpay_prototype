import 'package:flutter/material.dart';
import 'package:pucpay_prototype/pages/loginPage.dart';
import 'package:pucpay_prototype/global.dart';
import 'package:uuid/uuid.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _login = TextEditingController();
  final _mail = TextEditingController();
  final _mat = TextEditingController();
  final _name = TextEditingController();
  final _pass = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showLogo(){
  return Container(
    child: Image.asset("assets/logo_t.png",width: 1000.0 ,height: 200.0,)
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
          right: 30,
          ),
          child: ListView(
            children: <Widget>[
              _showLogo(),
              TextFormField(
                controller: _name,
                style: new TextStyle(color: Colors.black, fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Insira seu Nome'
                )
              ),
              //Divider(height: 5, color: Colors.white),
              TextFormField(
                controller: _mat,
                keyboardType: TextInputType.number,
                style: new TextStyle(color: Colors.black, fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Insira sua Matricula'
                )
              ),
              //Divider(height: 5, color: Colors.white),
              TextFormField(
                controller: _login,
                style: new TextStyle(color: Colors.black, fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Insira seu Login (intranet)'
                )
              ),
              //Divider(height: 5, color: Colors.white),
              TextFormField(
                controller: _mail,
                 keyboardType: TextInputType.emailAddress,
                style: new TextStyle(color: Colors.black, fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Insira seu email'
                )
              ),
              //Divider(height: 0, color: Colors.white),
              TextFormField(
                controller: _pass,
                obscureText: true,
                style: new TextStyle(color: Colors.black, fontSize: 15),
                decoration: InputDecoration(
                  labelText: 'Insira sua senha'
                )
              ),
              Divider(height: 10, color: Colors.transparent),
              Row(
                children: <Widget>[
                  RaisedButton(
                 onPressed: () {
                  
                 },
                  child: const Text(
                  'Cancelar',
                  style: TextStyle(fontSize: 10)
              ),
            ),
              SizedBox(
                width: 100,
                height: 0,
              ),
              RaisedButton(
                onPressed: () {
                  signUp(context, _name.text, _mat.text, _login.text, _mail.text, _pass.text,_scaffoldKey);
                },
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(fontSize: 10)

                 ),
               )
                ],
              )
            ],
          ),
        ),
      );
    }
}

void signUp(BuildContext context, name, mat, login, mail, pass, _key) async {
  try{

    String userDataLog = getUserData("login",login);
    String userDataMail = getUserData("email", mail);
    String userDataMat = getUserData("matricula", mat);
 
    var verifyLog = await conn.query(userDataLog);
    var verifyMail = await conn.query(userDataMail);
    var verifyMat = await conn.query(userDataMat);
    
    var dataLog = verifyLog['data']['cadastro'];
    var dataMail = verifyMail['data']['cadastro']; 
    var dataMat = verifyMat['data']['cadastro']; 

    var log = dataLog.map<String>((m) => m['login'] as String);
    var email = dataMail.map<String>((m) => m['email'] as String);
    var matricula = dataMat.map<int>((m) => m['matricula'] as int);
    
    print("Login is unique: " + log.isEmpty.toString()); 
    print("Email is unique: " + email.isEmpty.toString());
    print("Matricula is unique: " + matricula.isEmpty.toString());

    if( (!log.isEmpty)) {
      throw new Exception("Login_Unique_Violation");
    }else if(!email.isEmpty) {
      throw new Exception("Mail_Unique_Violation");
    }else if(!matricula.isEmpty) {
      throw new Exception("Mat_Unique_Violation");
    }

    var uuid = new Uuid();
    userId = uuid.v1();
    print(userId);

    String docInsert = cadUser(userId, mail, login, mat, name, pass);
    var r = await conn.mutation(docInsert);
    print(r);

    _key.currentState.showSnackBar(SnackBar(
      content: Text("Signup Success"),
      backgroundColor: Colors.green,
    ));

    exibirDialogo(context,"Cadastro Realizado","Deseja prosseguir para o Login?","OK", LoginPage());

  }catch(e) {
    print(e.toString());

    _key.currentState.showSnackBar(SnackBar(
      content: Text(e.message),
      backgroundColor: Colors.redAccent,
    ));

  }
}

