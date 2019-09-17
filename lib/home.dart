import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, @required this.title}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = 'https://api.github.com/users';
  List data;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    this.getjsondata();
  }

  Future<String> getjsondata() async {
    var response = await http.get(
      Uri.encodeFull(url),
    );
    setState(() {
      var convertDatatoJson = json.decode(response.body);

      data = convertDatatoJson;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Name'),
              accountEmail: Text('Name1@gmail.co.m'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Text('NM'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            ListTile(
              title: Text('Home'),
              trailing: Icon(Icons.home),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            ListTile(
              title: Text('Get Random User'),
              trailing: Icon(Icons.supervised_user_circle),
              onTap: () => Navigator.of(context).pushNamed('/a'),
            ),
          ],
        )
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.person_outline,
                      color: Colors.red,
                    ),
                    title: Text(
                      data[index]['login'],
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      data[index]['url'],
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
