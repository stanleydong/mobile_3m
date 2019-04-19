import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

void main() {
  runApp(new MyApp());
}

final dummyBook = [
  {
    "status": "false",
    "id": "1",
    "title": "Hackaton",
    "bookRefId": "-Lcj_KLDFuqdYuqdggkp"
  }
];

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return new MaterialApp(
      title: 'QRCode Reader Demo',
      home: new LendingBook(),
    );
  }
}

class LendingBook extends StatefulWidget {


  LendingBook({Key key, this.title}) : super(key: key);

  final String title;

  final Map<String, dynamic> pluginParameters = {};

  @override
  _LendingBookState createState() => new _LendingBookState();
}
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
class _LendingBookState extends State<LendingBook> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Baby Name Votes')),
      body: _buildBody(context),
    );
  }
  Widget _buildBody(BuildContext context) {
    log('start query');

    Firestore.instance.runTransaction((Transaction tx)  async {
      await tx.set(
          Firestore.instance.collection("histories").document(), {
        "book": {
          "author": "Hieu Ta",
          "title": "Micro-services"
        },
        "borrowing_date": "April 11, 2019 at 12:00:00 PM UTC+7",
        "user": {
          "email": "kien.dinh@tyme.com",
          "full_name": "Kien Dinh",
          "phone_number": "0987654321"
        }
      });
    });

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('user').where("id", isEqualTo: 'HI').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          log('blank data');
          return LinearProgressIndicator();
        }
        log('Has data');
        return _buildList(context, snapshot.data.documents);
      },
    );
//    return _buildList(context, dummyBook);
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final book = Book.fromSnapshot(data);

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

}}

class Book {
  final String id;
  final String title;
  final String status;
  final DocumentReference reference;

  Book.fromMap(Map<String, dynamic> map, {this.reference} )
      : assert(map['id'] != null),
        assert(map['title'] != null),
        assert(map['status'] != null),
        id = map['id'],
        title = map['title'],
        status = map['status'];

  Book.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
  @override
  String toString() => "Book id:$id \n Title: $title \n Status: $status>";
}
