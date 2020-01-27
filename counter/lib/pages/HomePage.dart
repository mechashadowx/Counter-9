import 'package:counter/backend/Auth.dart';
import 'package:counter/backend/Database.dart';
import 'package:counter/helper.dart';
import 'package:flutter/material.dart';
import '../User.dart';
import 'Add.dart';

class HomePage extends StatefulWidget {
  final String userID;

  HomePage({
    this.userID,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  logout() {
    auth.logOutGoogle();
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: black,
      body: FutureBuilder(
        future: usersRef.document(widget.userID).get(),
        builder: (context, snapshot) {
          User user = User.fromDoc(snapshot.data);
          List<String> names = List();
          user.count.forEach((k, v) {
            names.add(k);
          });
          return Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: data.size.height * 0.4),
                child: Center(
                  child: ListView.builder(
                    itemCount: user.count.length,
                    itemBuilder: (context, index) {
                      String show = user.count[names[index]]['name'];
                      bool open = user.count[names[index]]['open'];
                      return !open
                          ? GestureDetector(
                              onLongPress: () {
                                setState(() {
                                  user.count[names[index]]['name'] = 'Delete';
                                });
                                Database.updateUser(user);
                              },
                              onTap: () {
                                if (show == 'Delete') {
                                  setState(() {
                                    user.count.remove(names[index]);
                                  });
                                  Database.updateUser(user);
                                } else {
                                  setState(() {
                                    user.count[names[index]]['open'] = true;
                                  });
                                  Database.updateUser(user);
                                }
                              },
                              child: Container(
                                height: data.size.height * 0.12,
                                margin: EdgeInsets.only(
                                  left: data.size.width * 0.18,
                                  right: data.size.width * 0.18,
                                  bottom: data.size.height * 0.06,
                                ),
                                decoration: BoxDecoration(
                                  color: gray,
                                  borderRadius: BorderRadius.circular(
                                    data.size.width * 0.05,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    show,
                                    style: TextStyle(
                                      color: black,
                                      fontSize: data.size.width * 0.12,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onLongPress: () {
                                    setState(() {
                                      user.count[names[index]]['name'] =
                                          'Delete';
                                    });
                                    Database.updateUser(user);
                                  },
                                  onTap: () {
                                    if (show == 'Delete') {
                                      setState(() {
                                        user.count.remove(names[index]);
                                      });
                                      Database.updateUser(user);
                                    } else {
                                      setState(() {
                                        user.count[names[index]]['open'] =
                                            false;
                                      });
                                      Database.updateUser(user);
                                    }
                                  },
                                  child: Container(
                                    height: data.size.height * 0.12,
                                    margin: EdgeInsets.only(
                                      left: data.size.width * 0.18,
                                      right: data.size.width * 0.18,
                                      bottom: data.size.height * 0.06,
                                    ),
                                    decoration: BoxDecoration(
                                      color: red,
                                      borderRadius: BorderRadius.circular(
                                        data.size.width * 0.05,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        show,
                                        style: TextStyle(
                                          color: black,
                                          fontSize: data.size.width * 0.12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: data.size.width * 0.1,
                                    right: data.size.width * 0.1,
                                    bottom: data.size.height * 0.06,
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            if (user.count[names[index]]
                                                    ['value'] ==
                                                0) return;
                                            setState(() {
                                              user.count[names[index]]
                                                  ['value']--;
                                            });
                                            Database.updateUser(user);
                                          },
                                          child: Image.asset(
                                            'assets/minus.png',
                                            height: data.size.width * 0.14,
                                            width: data.size.width * 0.14,
                                          ),
                                        ),
                                        Container(
                                          height: data.size.width * 0.28,
                                          width: data.size.width * 0.28,
                                          decoration: BoxDecoration(
                                            color: gray,
                                            borderRadius: BorderRadius.circular(
                                              data.size.width * 0.28,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              user.count[names[index]]['value']
                                                  .toString(),
                                              style: TextStyle(
                                                color: black,
                                                fontSize:
                                                    data.size.width * 0.12,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              user.count[names[index]]
                                                  ['value']++;
                                            });
                                            Database.updateUser(user);
                                          },
                                          child: Image.asset(
                                            'assets/plus.png',
                                            height: data.size.width * 0.14,
                                            width: data.size.width * 0.14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                    },
                  ),
                ),
              ),
              Container(
                height: data.size.height * 0.35,
                width: data.size.width,
                decoration: BoxDecoration(
                  color: red,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(data.size.width * 0.1),
                    bottomRight: Radius.circular(data.size.width * 0.1),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Counter',
                    style: TextStyle(
                      color: black,
                      fontSize: data.size.width * 0.2,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Add(
                        user: user,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: data.size.height * 0.3),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/add.png',
                      height: data.size.width * 0.18,
                      width: data.size.width * 0.18,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: logout,
                child: Container(
                  margin: EdgeInsets.only(top: 30.0, right: 20.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.exit_to_app,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
