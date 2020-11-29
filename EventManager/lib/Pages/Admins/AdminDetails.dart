import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';

class AdminDetails extends StatefulWidget {

  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  AdminDetails(this._user, this._postgresKonnection);
  
  @override
  _AdminDetailsState createState() => _AdminDetailsState();
}

class _AdminDetailsState extends State<AdminDetails> {
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
                              "Update Details about Parsec & Sub-Events",
                              style: new TextStyle(
                                fontSize: 22.0,
                                color: Colors.white
                              ),
                            ),
                          ),

                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 60.0, left: 75, right: 75),
                      child: new SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {},
                          textColor: Colors.blue,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: new Text(
                              "UPDATE ?",
                              style: new TextStyle(
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                        ),
                        // ],
                      ),
                    ),


                    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: new Text(
                              "All Details about Parsec & Sub-Events",
                              style: new TextStyle(
                                fontSize: 22.0,
                                color: Colors.white
                              ),
                            ),
                          ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 75),
                      child: new SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {},
                          textColor: Colors.blue,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: new Text(
                              " Parsec Details ",
                              style: new TextStyle(
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                        ),
                        // ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 75),
                      child: new SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {},
                          textColor: Colors.blue,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: new Text(
                              " sub Event 1",
                              style: new TextStyle(
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                        ),
                        // ],
                      ),
                    ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 75),
                      child: new SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {},
                          textColor: Colors.blue,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: new Text(
                              " sub Event 2 ",
                              style: new TextStyle(
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                        ),
                        // ],
                      ),
                    ),

                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 75),
                      child: new SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {},
                          textColor: Colors.blue,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: new Text(
                              " sub Event 4 ",
                              style: new TextStyle(
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                        ),
                        // ],
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
