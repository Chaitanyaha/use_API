import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RandomUser extends StatefulWidget {
  @override
  _RandomUserState createState() => _RandomUserState();
}

class _RandomUserState extends State<RandomUser> {
  List userData;
  bool isLoading = true;
  final String url = 'https://randomuser.me/api/?results=50';

  Future getData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});

    List data = jsonDecode(response.body)['results'];
    setState(() {
      userData = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random User'),
      ),
      body: Container(
        child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: userData == null ? 0 : userData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(15),
                              child: Image(
                                width: 70,
                                height: 70,
                                //fit: BoxFit.contain,
                                image: NetworkImage(
                                    userData[index]['picture']['medium']),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    userData[index]['name']['first'] +
                                        userData[index]['name']['last'],
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(userData[index]['phone']),
                                  Text(userData[index]['gender']),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )),
      ),
    );
  }
}
