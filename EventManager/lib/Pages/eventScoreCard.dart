import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class eventScoreCard extends StatefulWidget {
  @override
  _eventScoreCardState createState() => _eventScoreCardState();
}

// ignore: camel_case_types
class _eventScoreCardState extends State<eventScoreCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: new Text(
                              " Sub Event ScoreCard ",
                              style: new TextStyle(
                                fontSize: 22.0,
                                color: Colors.white
                              ),
                            ),
                    ),

                    Padding(
                            padding: const EdgeInsets.only(top: 50.0),

                            child: new Text(
                              " 1st Postion ",
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white
                              ),
                            ),
                    ),
                    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: new Text(
                              " Team Name ",
                              style: new TextStyle(
                                fontSize: 15.0,
                                color: Colors.white
                              ),
                            ),
                    ),

                    Padding(
                          padding: const EdgeInsets.only(top: 50.0),

                            child: new Text(
                              " 2nd Postion ",
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white
                              ),
                            ),
                    ),
                    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: new Text(
                              " Team Name ",
                              style: new TextStyle(
                                fontSize: 15.0,
                                color: Colors.white
                              ),
                            ),
                    ),

                    Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: new Text(
                              " 3rd Postion ",
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white
                              ),
                            ),
                    ),
                    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: new Text(
                              " Team Name ",
                              style: new TextStyle(
                                fontSize: 15.0,
                                color: Colors.white
                              ),
                            ),
                    ),
                    
                    
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
