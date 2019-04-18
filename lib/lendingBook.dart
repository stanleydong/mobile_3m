import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

void main() {
  runApp(new MyApp());
}

final dummyBook = [
  {
    "status": false,
    "id": 1,
    "title": "Hackaton",
    "bookRefId": "-Lcj_KLDFuqdYuqdggkp"
  }
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

class _LendingBookState extends State<LendingBook> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Baby Name Votes')),
      body: _buildBody(context),
    );
  }
  Widget _buildBody(BuildContext context) {
    // TODO: get actual snapshot from Cloud Firestore
    return _buildList(context, dummyBook);
  }

  Widget _buildList(BuildContext context, List<Map> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, Map data) {
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

}}

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

  @override
  String toString() => "Book id:$id \n Title: $title \n Status: $status>";
}
