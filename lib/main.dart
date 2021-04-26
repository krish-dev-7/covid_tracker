import 'package:covid_tracker/dashboard.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "COVID TRACKER",
      home: StartApp(),
    );
  }
}

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "COVID-TRACKER (IN)",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.lightBlueAccent,
          centerTitle: true,
        ),
        drawer: SafeArea(
            child: Drawer(
          child: Container(
            color: Colors.black,
            child: Column(
              children: <Widget>[
                SafeArea(
                    child: ListTile(
                  onTap: () {
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            color: Colors.black,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                      text: "Developer :",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.lightGreenAccent),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " Krishna Sundar\n\n",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.lightGreenAccent,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ]),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "Instagram:",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.lightGreenAccent),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " krish_krush",
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.lightGreenAccent,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  leading: Icon(
                    Icons.info,
                    color: Colors.lightGreenAccent,
                  ),
                  title: Text(
                    "About",
                    style: TextStyle(
                        backgroundColor: Colors.black,
                        color: Colors.lightGreenAccent,
                        fontSize: 20),
                  ),
                )),
              ],
            ),
          ),
        )),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/covid.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 19,
                        ),
                        Text(
                          "Swipe right",
                          style: TextStyle(
                              color: Colors.black,
                              backgroundColor: Colors.lightBlueAccent,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                        ),
                        Icon(Icons.arrow_right_alt),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "CORONA VIRUS - TRACKER",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.lightBlueAccent,
                          letterSpacing: 2),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DashBoard();
                        }));
                      },
                      color: Colors.white,
                      elevation: 400,
                      splashColor: Colors.black,
                      child: Text(
                        "ENTER",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
