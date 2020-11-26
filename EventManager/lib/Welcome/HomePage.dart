import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  SaveUser _user;
  HomePage(this._user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 150.0, bottom: 10.0),
                      //   child: logo(90, 280),
                      // ),

                      Container(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60.0, vertical: 10),
                          child: Text(
                            " A Paradigm  Shift  💫", // 💫🌠
                            style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
                                fontFamily: "Signatra"),
                          ),
                        ),
                      ),

                      Container(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70.0, vertical: 10),
                          child: Text(
                            "14th-16th Feb, 2020", // 💫🌠
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontStyle: FontStyle.italic // "Signatra"
                                ),
                          ),
                        ),
                      ),
                      
                      Container(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 70.0, vertical: 10),
                          child: Text(
                            widget._user.email, 
                            style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontStyle: FontStyle.italic // "Signatra"
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
