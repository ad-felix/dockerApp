import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String name, os;
  docker(x, y) async {
    print(x + y);
    var url = "http://192.168.0.108/cgi-bin/web.py?x=${x}&y=${y}";
    var response = await http.get(url);

    print(response.statusCode);

    if (response.statusCode == 200 && response.body.split(':')[0] != 'docker') {
      Fluttertoast.showToast(
        msg: "Container Launched Successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade600,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Container with same name exists!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade600,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          leading: Icon(Icons.casino),
          title: Text("DockDock"),
        ),
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                // container name
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.crop_square),
                    labelText: "Enter Name of the Container",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    name = value;
                    print(value);
                  },
                ),
              ),
              Container(
                // container os
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.all(10.0),
                child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.album),
                      labelText: "Enter Name of the OS",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      os = value;
                      print(value);
                    }),
              ),
              Container(
                // Launch Button
                margin: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: FlatButton(
                  onPressed: () {
                    print(name);
                    docker(name, os);
                  },
                  child: Text(
                    "Launch",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}
