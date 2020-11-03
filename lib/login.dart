import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  static final id = 'login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        backgroundColor: Colors.orange[500],
        centerTitle: true,
        title: Text(
            "Login"), //* Change this to something less cliche
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoginForm(),
          SubmitButton()
        ],
      )

    );
  }
}




class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width*0.4,
      child: FlatButton(
        color: Colors.orange[700],
        child: Text("Submit"),
        onPressed: () {},
      ),
    );
  }
}





class LoginForm extends StatefulWidget {
  static final id = 'login_form';

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(const Size(200, 50)),
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your Voter ID number',
                ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
          )
        ]
      ),
    );
  }
}