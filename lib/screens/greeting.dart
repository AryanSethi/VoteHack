import 'package:flutter/material.dart';

class Greeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          SizedBox(height: 50),
          Padding(
            padding: EdgeInsets.all(30),
            child: Image.asset('assets/happy.png'),
          ),
          Text(
            "Thank You for Your Vote",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40),
          )
        ],
      )),
    );
  }
}
