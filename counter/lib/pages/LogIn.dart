import 'package:counter/backend/Auth.dart';
import 'package:counter/helper.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  login() {
    auth.signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  'Counter',
                  style: TextStyle(
                    color: red,
                    fontSize: data.size.width * 0.2,
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child: GestureDetector(
                  onTap: login,
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    color: gray,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
