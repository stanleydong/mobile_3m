import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Admin Page Demo',
      home: new AdminPage(),
    );
  }
}

class AdminPage extends StatefulWidget {
  final String title;
  final String valueUserName;
  AdminPage({Key key, this.title, this.valueUserName}) : super(key: key);

  final Map<String, dynamic> pluginParameters = {
  };

  @override
  _AdminPageState createState() => new _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.book)),
                Tab(icon: Icon(Icons.bookmark)),
                Tab(icon: Icon(Icons.bookmark_border)),
              ],
            ),
            title: Text('Admin Page'),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.book),
              Icon(Icons.bookmark),
              Icon(Icons.bookmark_border),
            ],
          ),
        ),
      ),
    );
  }
}