import 'package:counter/pages/Add.dart';
import 'package:counter/pages/HomePage.dart';
import 'package:counter/pages/LogIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Widget getFirstScreen() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage(
            userID: snapshot.data.uid,
          );
        } else {
          return LogIn();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Quicksand',
      ),
      home: getFirstScreen(),
      routes: {
        Add.id: (context) => Add(),
      },
    );
  }
}
