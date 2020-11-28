import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';

class AdminListSponsors extends StatefulWidget {
  @override
  _AdminListSponsorsState createState() => _AdminListSponsorsState();
}

class _AdminListSponsorsState extends State<AdminListSponsors> {
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
                              " Sponsors List for event",
                              style: new TextStyle(
                                fontSize: 22.0,
                                color: Colors.white
                              ),
                            ),
                    ),

                    Padding(
                            padding: const EdgeInsets.only(top: 50.0),

                            child: new Text(
                              " 1st Sponsor ",
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white
                              ),
                            ),
                    ),
                    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: new Text(
                              " Sponsor Details ",
                              style: new TextStyle(
                                fontSize: 15.0,
                                color: Colors.white
                              ),
                            ),
                    ),

                    Padding(
                          padding: const EdgeInsets.only(top: 50.0),

                            child: new Text(
                              " 2nd Sponsor ",
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white
                              ),
                            ),
                    ),
                    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: new Text(
                              " Sponsor Details ",
                              style: new TextStyle(
                                fontSize: 15.0,
                                color: Colors.white
                              ),
                            ),
                    ),

                    Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: new Text(
                              " 3rd Sponsor ",
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white
                              ),
                            ),
                    ),
                    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0.0),
                            child: new Text(
                              " Sponsor Details ",
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
