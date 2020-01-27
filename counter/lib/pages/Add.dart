import 'package:counter/Thing.dart';
import 'package:counter/User.dart';
import 'package:counter/backend/Database.dart';
import 'package:counter/helper.dart';
import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  static final String id = 'Add';

  final User user;

  Add({
    this.user,
  });

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final formKey = GlobalKey<FormState>();
  String input;

  @override
  void initState() {
    super.initState();
    input = '';
  }

  add() {
    if (input.length == 0) return;
    Thing thing = Thing(input, input, 0, false);
    User user = widget.user;
    user.count[input] = thing.toMap();
    Database.updateUser(user);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: black,
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: data.size.height * 0.1,
          horizontal: data.size.width * 0.1,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: gray,
                          width: 2,
                        ),
                        borderRadius:
                            BorderRadius.circular(data.size.width * 0.05),
                      ),
                      child: Center(
                        child: TextFormField(
                          onChanged: (input) {
                            this.input = input;
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: gray,
                            fontSize: data.size.width * 0.06,
                            fontWeight: FontWeight.w600,
                          ),
                          cursorColor: gray,
                          maxLines: 1,
                          decoration: InputDecoration.collapsed(
                            border: InputBorder.none,
                            hintText: 'count something',
                            hintStyle: TextStyle(
                              color: lightGray,
                              fontSize: data.size.width * 0.06,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: add,
                child: Container(
                  child: Center(
                    child: Image.asset(
                      'assets/add.png',
                      height: data.size.width * 0.18,
                      width: data.size.width * 0.18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
