import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
            child: Icon(Icons.print, size: 50,),
          ),
          // Valor
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child:Text("VALOR", style: TextStyle(color: Color.fromARGB(255, 127, 120, 119), fontSize: 22, fontWeight: FontWeight.bold)),),
              Divider(height: 6,),
              Center(child:Text('R\$'+logList[index]['valor'], style: TextStyle(fontSize: 14),)),
            ],
          ),
          // Data
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(child:Text("DATA", style: TextStyle(color: Color.fromARGB(255, 127, 120, 119), fontSize: 22, fontWeight: FontWeight.bold)),),
              Divider(height: 6,),
              Center(child:Text(logList[index]['data'], style: TextStyle(fontSize: 14),)),
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
  @override
  void initState() {
    super.initState();
    _printLogList = fetchLogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              _printLogList.add({'valor':'3,50', 'data': '24/11/2019'});
            });
          },
        ),
        ],
      ),
      body: Column(
        children: [
          Divider(height: 40,color: Colors.transparent),
          Center(child: Text(
            'Histórico de Impressões',
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

List<Map> fetchLogs() {
  List<Map> logList;
  logList = [
    {'valor':'10,00', 'data':'22/11/1997'},
    {'valor':'20,00', 'data': '18/05/1947'}
  ];
  return logList;
}