import 'dart:convert';
import 'package:covid_tracker/countries.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String cont;

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class Covid {
  final int cases;
  final int deaths;
  final int recovered;
  final int active;
  final int updated;

  Covid({this.cases, this.deaths, this.recovered, this.active, this.updated});

  factory Covid.fromJson(Map<String, dynamic> jsno) {
    return Covid(
      cases: jsno['cases'],
      deaths: jsno['deaths'],
      recovered: jsno['recovered'],
      active: jsno['active'],
      updated: jsno['updated'],
    );
  }
}

class _DashBoardState extends State<DashBoard> {
  String cont;
  Future<Covid> co;
  String country = 'india';

  Future<Covid> fetchData() async {
    final response = await http
        .get('https://corona.lmao.ninja/v2/countries/$country?yesterday=false');
    if (response.statusCode == 200) {
      return Covid.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Covid...\nCHECK INTERNET CONNECTIVITY');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    co = fetchData();
    super.initState();
  }

  String time(var t) {
    var date = DateTime.fromMillisecondsSinceEpoch(t);
    var fd = DateFormat("dd/MM/yyyy hh:mm:ss").format(date);
    return fd.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            country,
            style: TextStyle(
                color: Color(0xFFE50914),
                fontWeight: FontWeight.bold,
                fontSize: 35),
          ),
          centerTitle: true,
          shadowColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.location_pin,
                size: 30,
                color: Color(0xFFE50914),
              ),
              onPressed: () async {
                var cc = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return Countries();
                }));
                if (cc.toString().isNotEmpty) {
                  print("cc-->${cc.toString()}");
                  setState(() {
                    country = cc;
                  });
                  initState();
                }
              },
            )
          ],
        ),
        body: FutureBuilder<Covid>(
            future: co,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 400,
                        width: 400,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/covid.jpg"))),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            initState();
                          });
                        },
                        icon: Icon(Icons.refresh),
                      ),
                      Card(
                        child: Text(
                          "cases : ${snapshot.data.cases}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.lightBlueAccent,
                              letterSpacing: 2),
                        ),
                        color: Colors.red,
                      ),
                      Card(
                        child: Text(
                          "Active : ${snapshot.data.active}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.lightBlueAccent,
                              letterSpacing: 2),
                        ),
                      ),
                      Card(
                        child: Text(
                          "Death : ${snapshot.data.deaths}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.lightBlueAccent,
                              letterSpacing: 2),
                        ),
                      ),
                      Card(
                        child: Text(
                          "Recovered : ${snapshot.data.recovered}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.lightBlueAccent,
                              letterSpacing: 2),
                        ),
                      ),
                      Card(
                        child: Text(
                          "Updated : ${time(snapshot.data.updated)}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              backgroundColor: Colors.lightBlueAccent,
                              letterSpacing: 2),
                        ),
                      ),
                    ]);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Fetching ....",
                      style: TextStyle(
                          fontSize: 20,
                          backgroundColor: Colors.lightBlueAccent,
                          color: Colors.black),
                    ),
                  ),
                ],
              );
            }));
  }
}
