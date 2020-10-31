import 'package:VoteHack/screens/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComingSoon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          SizedBox(height: 80),
          Padding(
              padding: EdgeInsets.all(30),
              child: Container(
                child: Image.asset("assets/no_data.png"),
              )),
          SizedBox(height: 30),
          Text(
            "No Election Yet!!!",
            style: TextStyle(fontSize: 40),
          )
        ],
      )),
    );
  }
}
