import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pucpay_prototype/global.dart';
import 'package:date_format/date_format.dart';

class LogInput extends StatelessWidget {
  final List<Map> logList;
  LogInput(this.logList);
  Widget _buildLogInput(BuildContext context, int index) {
    print(logList[index]);
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Logo
          Container(
            padding: EdgeInsets.all(5),
            child: Icon(logList[index]['tipo'] == 1 ? Icons.print : Icons.directions_car, size: 50,),
          ),
          // Valor
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child:Text("VALOR", style: TextStyle(color: Color.fromARGB(255, 127, 120, 119), fontSize: 22, fontWeight: FontWeight.bold)),),
              Divider(height: 6,),
              Center(child:Text('R\$'+logList[index]['valor'].toString(), style: TextStyle(fontSize: 14),)),
            ],
          ),
          // Data
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child:Text("DATA", style: TextStyle(color: Color.fromARGB(255, 127, 120, 119), fontSize: 22, fontWeight: FontWeight.bold)),),
              Divider(height: 6,),
              Center(child:Text(logList[index]['data'].toString(), style: TextStyle(fontSize: 14),)),
            ],
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    var listView = ListView.builder(
      itemBuilder: _buildLogInput,
      itemCount: logList.length,
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      shrinkWrap: true,
      itemExtent: 80,
    );
    return listView;
  }
}


class PrintingLog extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
    return _PrintingLogState();
  }
}

class _PrintingLogState extends State<PrintingLog> {
  List<Map> _printLogList;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _printLogList = new List<Map>();
    fetchLogs(_scaffoldKey).then((result) {
      setState(() {
        _printLogList = result;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: _isLoading ? 
      Column( 
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
         Divider(height: 10,color: Colors.transparent,),
          Text("Carregando Dados...")
        ],
      ) 
      : Column(
        children: [
          Divider(height: 40,color: Colors.transparent),
          Center(child: Text(
            'Histórico de Pagamentos',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
            )),
          Divider(height: 40,color: Colors.transparent),
          Container(
            child: Expanded(child: LogInput(_printLogList),),),
        ],
      )
    );
  }
}


Future<List<Map>> fetchLogs(_scaffoldKey) async {
  List<Map> logList = new List<Map>();
  try {
    
    String queryPagamento = getPagamento();
    var pagamentos = await conn.query(queryPagamento).catchError((e){
      throw new Exception("ERROR while fetching logs");
      });

    var map = pagamentos['data']['pagamentos'];
    for(var item in map) {
      var date = DateTime.parse(item['data'].toString());
      logList.add({'data':formatDate(date,[dd,'/',mm,'/',yyyy]), 'valor':item['valor'], 'tipo':item['tipo']});
    }
    
    print(logList);

  } catch(e){
    print(e.toString());

    _scaffoldKey.currentState.showSnackBar(SnackBar(
    content: Text(e.message),
    backgroundColor: Colors.redAccent,
    duration: Duration(seconds: 2),
  )); 
  }

  return logList;
}