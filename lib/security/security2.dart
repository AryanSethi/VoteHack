import 'package:VoteHack/security/security1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:VoteHack/variable.dart' as variable;

class Security2 extends StatefulWidget {
  @override
  _Security2 createState() => _Security2();
}

class _Security2 extends State<Security2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Security Breach 1",
          style: TextStyle(
              fontFamily: "Quicksand", color: Colors.black, fontSize: 25),
        ), //* Change this to something less cliche
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: [
            SizedBox(height: 30),
            Padding(
                padding: EdgeInsets.only(left: 80, right: 80, bottom: 30),
                child: Image.asset('assets/question.png')),
            Text(
              "1. Enter Your Favorite Fruit...?",
              style: TextStyle(fontFamily: "Quicksand", fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              "(Remember your answer)",
              style: TextStyle(fontFamily: "Quicksand", fontSize: 17),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 1,
                        color: Colors.grey,
                        style: BorderStyle.solid)),
                child: TextField(
                  controller: variable.question,
                  decoration: InputDecoration(
                      hintText: 'Answer here',
                      hintStyle: TextStyle(fontFamily: "Quicksand"),
                      contentPadding: EdgeInsets.all(15),
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(colors: variable.colorMain),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: Offset(1, 5),
                        blurRadius: 5.0,
                        spreadRadius: 1.0)
                  ],
                ),
                child: Card(
                  elevation: 0,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: IconButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => Security1()));
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_right,
                        size: 40,
                      )),
                ))
          ],
        ),
      )),
    );
  }
}
