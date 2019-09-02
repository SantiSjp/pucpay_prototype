import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showLogo(){
  return Container(
    child: Image.asset("assets/logo_t.png",width: 1000.0 ,height: 200.0,)
    );
  }

  final _name = TextEditingController();
  final _mat = TextEditingController();
  final _login = TextEditingController();
  final _mail = TextEditingController();
  final _pass = TextEditingController();
  
  
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

void signUp(BuildContext context,name,mat,login,mail,pass,_key) async{
  try{
    FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword( 
      email: mail,
      password: pass 
      )).user;
    print('EMAIL é: $mail');
    print('SENHA é: $pass');
    print('NOME é: $name');
    print('Matricula é: $mat');
    print('Login é: $login');
    
    Firestore.instance.collection('users').document("$login").setData({
      'user': mail,'pass':pass,'nome': name,'matricula':mat,'login':login});

      _key.currentState.showSnackBar(SnackBar(
        content: Text("Signup Success"),
        backgroundColor: Colors.green,
      ));
  }catch(e){
    print("Error: ${e.toString()}");

    _key.currentState.showSnackBar(SnackBar(
        content: Text("ERRO Verefique seus dados"),
        backgroundColor: Colors.redAccent,
      ));
  }
}