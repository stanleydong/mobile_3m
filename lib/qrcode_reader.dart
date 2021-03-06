import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:mobile_3m/book.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'QRCode Reader Demo',
      home: new QRScanPage(),
    );
  }
}

class QRScanPage extends StatefulWidget {
  final String title;
  final String valueUserName;
  QRScanPage({Key key, this.title, this.valueUserName}) : super(key: key);

  final Map<String, dynamic> pluginParameters = {
  };

  @override
  _QRScanPageState createState() => new _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  Future<String> _qrcodeValue;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Get ready'),
      ),

      body: new Center(
        child: new Column(
    mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new FutureBuilder<String>(
            future: _qrcodeValue,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return new Text(snapshot.data != null ?
                snapshot.data : 'Hello Mr Donut \nGet ready and tap Scan it',
                  textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline);
          }),
        ]),
      ),
//          child: new FutureBuilder<String>(
//              future: _qrcodeValue,
//              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
////                print(controller.text);
//                return new Text(snapshot.data != null ? snapshot.data : 'Get ready and tap Scan it' );
//              })),
      floatingActionButton: new FloatingActionButton(
        onPressed: () async {
//          _qrcodeValue = new Future.value(FutureOr<String>( "-Lcj_KLDFuqdYuqdggkp" ) ;
//          _qrcodeValue = new Future<String>.value("-Lcj_KLDFuqdYuqdggkp");
//          TODO switch-on QRScanner
          _qrcodeValue = new QRCodeReader()
              .setAutoFocusIntervalInMs(200)
              .setForceAutoFocus(true)
              .setTorchEnabled(true)
              .setHandlePermissions(true)
              .setExecuteAfterPermissionGranted(true)
              .scan();
          String s= await _qrcodeValue;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LendingBook(bookId: s),
          ));
          },
        tooltip: 'Scan It',
        child: new Icon(Icons.camera_alt),
      ),
    );
  }
}