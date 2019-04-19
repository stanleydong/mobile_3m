import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:mobile_3m/success.dart';

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
    return new MaterialApp(
      title: 'QRCode Reader Demo',
      home: new LendingBook(),
    );
  }
}

class LendingBook extends StatefulWidget {
  LendingBook({Key key, @required this.bookId}) : super(key: key);

  final String bookId;

  final Map<String, dynamic> pluginParameters = {};

  Book ourbook;

  @override
  _LendingBookState createState() => new _LendingBookState();
}

class _LendingBookState extends State<LendingBook> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text("Proccess screen")),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    log('start query');

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('items')
          .where("id", isEqualTo: widget.bookId)
          .snapshots(),
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
    DocumentSnapshot thisbook = snapshot.removeLast();
    _buildListItem(context, thisbook);
    Book newbook = widget.ourbook;
    if (newbook.type.contains("shirt")) {
      return new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              _buildListItem(context, thisbook),
              new FlatButton(
                  onPressed: () {
                    processItem("take");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuccessPage(),
                        ));
                  },
                  child: new Text('Take'))
            ],
          ),
        ),
      );
    } else {
      return new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              _buildListItem(context, thisbook),
              //dart treates everything as objects so we pass a function in onPressed value
              new FlatButton(
                  onPressed: () {
                    processItem("borrow");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuccessPage(),
                        ));
                  },
                  child: new Text('Borrow')),
              new FlatButton(
                onPressed: () {
                  processItem("return");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessPage(),
                      ));
                },
                child: new Text('Return'),
              )
            ],
          ),
        ),
      );
    }
    ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  void calculateWindow() {}

  void processItem(String type) {
    var now = new DateTime.now();
    Book book = this.widget.ourbook;
    Firestore.instance.runTransaction((Transaction tx) async {
      await tx.set(Firestore.instance.collection("histories").document(), {
        "user": {
          "email": "test_user@tyme.com",
          "id": 1,
          "fullName": "Mr Donut",
          "phoneNumber": "0987654321"
        },
        "id": 2,
        "item": {
          "id": book.id,
          "name": book.name,
          "type": book.type,
          "author": book.author,
          "size": book.size,
          "ownable": book.ownable
        },
        "action": type,
        "createdDate": now,
        "user_id": 1,
        "item_id": book.id
      });
    });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final book = Book.fromSnapshot(data);
    widget.ourbook = book;
    return Text(book.toString());
    /*
     ListView(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      children: <Widget>[
        new ListTile(
          title: new RaisedButton(
              child: new Text("Borrow"),
              onPressed: (){
                processItem("borrow",book);
              }),
        ),
      ],
    );*/
  }
}

class Book {
  final String id;
  final String name;
  final String type;
  final String author;
  final String size;
  final bool ownable;
  final DocumentReference reference;

  Book.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['id'] != null),
        assert(map['name'] != null),
        assert(map['type'] != null),
        assert(map['author'] != null),
        assert(map['size'] != null),
        assert(map['ownable'] != null),
        id = map['id'],
        name = map['name'],
        type = map['type'],
        author = map['author'],
        size = map['size'],
        ownable = map['ownable'];

  Book.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() {
    String s = "";
    if (name != "") s = s + "\n Name: " + name;
    if (type != "") s = s + "\n Type: " + type;
    if (author != "") s = s + "\n Author: " + author;
    if (size != "") s = s + "\n Size: " + size;
    return s;
  }
}
