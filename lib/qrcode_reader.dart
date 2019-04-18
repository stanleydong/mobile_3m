import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

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
  QRScanPage({Key key, this.title}) : super(key: key);

  final String title;

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
          child: new FutureBuilder<String>(
              future: _qrcodeValue,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return new Text(snapshot.data != null ? snapshot.data : 'Get ready and tap Scan it');
              })),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _qrcodeValue = new QRCodeReader()
              .setAutoFocusIntervalInMs(200)
              .setForceAutoFocus(true)
              .setTorchEnabled(true)
              .setHandlePermissions(true)
              .setExecuteAfterPermissionGranted(true)
              .scan();
          Navigator.push(
              context,
              MaterialPageRoute(
//                builder: (context) => UserActionPage(qrCodeValue: this._qrcodeValue),
//                builder: (context) =>  MaterialPageRoute(builder: (context) => LendingBook()),

              ));
          },
        tooltip: 'Scan It',
        child: new Icon(Icons.camera_alt),
      ),
    );
  }
}