import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';

class SubEventDetails extends StatefulWidget {
  @override
  _SubEventDetailsState createState() => _SubEventDetailsState();
}

class _SubEventDetailsState extends State<SubEventDetails> {
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
                              " Sub Event Details ",
                              style: new TextStyle(
                                fontSize: 22.0,
                                color: Colors.white
                              ),
                            ),
                    ),

                    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: new Text(
                              " Detail 1 ",
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white
                              ),
                            ),
                    ),

                    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: new Text(
                              " Detail 2 ",
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white
                              ),
                            ),
                    ),

                    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: new Text(
                              " Detail 3 ",
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white
                              ),
                            ),
                    ),

                    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: new Text(
                              " Detail 4 ",
                              style: new TextStyle(
                                fontSize: 18.0,
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
