import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_3m/qrcode_reader.dart';
import 'package:mobile_3m/book.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'QRCode Reader Demo',
      home: new SuccessPage(),
    );
  }
}

class SuccessPage extends StatefulWidget {
  final String title;
  final String valueUserName;

  SuccessPage({Key key, this.title, this.valueUserName}) : super(key: key);

  final Map<String, dynamic> pluginParameters = {};

  @override
  _SuccessPageState createState() => new _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  Future<String> _qrcodeValue;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      appBar: new AppBar(
//        title: const Text('Success'),
//      ),

      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          new FutureBuilder<String>(
              future: _qrcodeValue,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return new Text(
                    snapshot.data != null
                        ? snapshot.data
                        : 'Your action is success',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline);
              }),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
//            MaterialPageRoute(builder: (context) => QRScanPage()),
            MaterialPageRoute(builder: (context) => QRScanPage()),
          );
        },
        tooltip: 'Next',
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
