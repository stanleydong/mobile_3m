/*
import 'package:flutter/material.dart';
import 'package:mobile_3m/main.dart';


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
    return Scaffold(
      appBar: AppBar(
//        TODO ___ this first !!!!!!!!!!!
        title: Text("Got QR: " + ""),
      ),
      body: Center(
        child: Column(

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO should return list of borrowing book.
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        },
        tooltip: 'Get It',
        child: Icon(Icons.send),
      ),
    );
  }

  Widget _buildScannedBook(BuildContext context, Map data) {
    final book = Book.fromMap(data);

    return Padding(
      key: ValueKey(book.title),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(book.title),
          trailing: Text(book.status),
          onTap: () => print(book),
        ),
      ),
    );
  }
}

class Book {
  final String id;
  final String title;
  final String status;

  Book.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['title'] != null),
        id = map['id'],
        title = map['title'],
        status = map['status'];

  Book.withID(Future<String> id)
      :
//      TODO reload with real data
        id = "-Lcj_KLDFuqdYuqdggkp",
        title = "Hackaton",
        status = "false";

  @override
  String toString() => "Book id:$id \n Title: $title \n Status: $status>";

}

final dummyBook = [
  {
    "status": "false",
    "id": "1",
    "title": "Hackaton",
    "bookRefId": "-Lcj_KLDFuqdYuqdggkp"
  }
];*/
