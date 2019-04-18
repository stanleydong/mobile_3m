import 'package:flutter/material.dart';
import 'package:mobile_3m/qrcode_reader.dart';

class UserActionPage extends StatefulWidget {
  UserActionPage({Key key, @required this.qrCodeValue}) : super(key: key);
  final Future<String> qrCodeValue;

  @override
  _UserActionPageState createState() => _UserActionPageState();
}

class _UserActionPageState extends State<UserActionPage> {
  void _userTakeAction() {
    setState(() {
      // TODO do something
    });
  }

  @override
  Widget build(BuildContext context) {
//    TODO implement this
//    return Scaffold(
//      appBar: AppBar(
//        title: Future<Text>(build (widget.qrCodeValue)),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'Hi @user\nYou have logged in', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => QRScanPage()),
//          );
//        },
//        tooltip: 'Next',
//        child: Icon(Icons.forward),
//      ),
//    );
  }
}
