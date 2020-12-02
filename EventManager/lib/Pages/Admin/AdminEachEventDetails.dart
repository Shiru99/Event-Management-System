import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Classes/EventInfo.dart';
import 'package:EventManager/Pages/Admin/AdminEventDetailsUpdate.dart';
import 'package:EventManager/Pages/Admin/AdminInvigilatorsForEvent.dart';
import 'package:EventManager/Pages/Admin/AdminRegisteredStudents.dart';
import 'package:EventManager/Pages/Admin/AdminScorecard.dart';
import 'package:EventManager/Pages/CommonPages/EventDetails.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

// ignore: must_be_immutable
class AdminEachEventDetails extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  // ignore: non_constant_identifier_names
  String event_ID;
  AdminEachEventDetails(this._user, this._postgresKonnection, this.event_ID);

  @override
  _AdminEachEventDetailsState createState() => _AdminEachEventDetailsState();
}

class _AdminEachEventDetailsState extends State<AdminEachEventDetails> {
  // ignore: non_constant_identifier_names
  String event_id;

  EventInfo _eventInfo = new EventInfo();
  bool _isLoading = true;
  var results;
  String eventNAME;

  Future runQuery() async {
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();

    print(_konnection);

    event_id = widget.event_ID;
    print("select * from evento where event_id=\'$event_id\'");
    results = await _konnection
        .query("select * from evento where event_id= '$event_id'");

    _eventInfo.event_id = results[0][0];
    _eventInfo.event_name = results[0][1];
    _eventInfo.start_date_time = results[0][2];
    _eventInfo.end_date_time = results[0][3];
    _eventInfo.register_start_date_time = results[0][4];
    _eventInfo.register_end_date_time = results[0][5];
    _eventInfo.place = results[0][6];
    _eventInfo.short_description = results[0][7];
    _eventInfo.description = results[0][8];
    _eventInfo.price = results[0][10];
    // _eventInfo.imageURL = results[0][11];

    eventNAME = results[0][1];

    print(results.length);

    setState(() {
      _isLoading = false;
    });
  }

  Future goToEvent() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EventDetails(widget._user, widget._postgresKonnection,widget. event_ID)));
  }

  Future editEventDetails() async {
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AdminEventDetailsUpdate(widget._user, widget._postgresKonnection,widget. event_ID)));
  }

    Future invigilatoresForEvent() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                InvigilatorsForEvent(widget._user, widget._postgresKonnection,widget. event_ID)));
  }

  Future registeredStudentsForEvent() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AdminRegisteredStudents(widget._user, widget._postgresKonnection,widget. event_ID)));
  }

  // AdminScorecard

  Future scoreCard() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AdminScorecard(widget._user, widget._postgresKonnection,widget. event_ID)));
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      runQuery();
    }
    return Scaffold(
      appBar: _isLoading ? null : appBarMain(context),
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      body: _isLoading
          ? loading()
          : SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 150.0),
                      child: logo(90, 280),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 50.0),
                      child: Text(
                        " A Paradigm  Shift  💫", // 💫🌠
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontFamily: "Signatra"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: new Text(
                        eventNAME,
                        style: new TextStyle(
                            fontSize: 48.0,
                            color: Colors.yellow,
                            fontFamily: "Signatra"),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 75),
                      child: new SizedBox(
                        // width: MediaQuery.of(context).size.width,
                        width: 280.0,
                        height: 45.0,
                        child: RaisedButton(
                          onPressed: () {
                            goToEvent();
                          },
                          textColor: Colors.white,
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: new Text(
                              "Event Details",
                              style: new TextStyle(
                                fontSize: 20.0,
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
                        // width: MediaQuery.of(context).size.width,
                        width: 280.0,
                        height: 45.0,
                        child: RaisedButton(
                          onPressed: () {
                            editEventDetails();
                          },
                          textColor: Colors.blueAccent,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: new Text(
                              "Edit Event Details",
                              style: new TextStyle(
                                fontSize: 20.0,
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
                        // width: MediaQuery.of(context).size.width,
                        width: 280.0,
                        height: 45.0,
                        child: RaisedButton(
                          onPressed: () {
                            invigilatoresForEvent();

                          },
                          textColor: Colors.white,
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: new Text(
                              "Invigilators for event",
                              style: new TextStyle(
                                fontSize: 20.0,
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
                        // width: MediaQuery.of(context).size.width,
                        width: 280.0,
                        height: 45.0,
                        child: RaisedButton(
                          onPressed: () {
                            registeredStudentsForEvent();
                          },
                          textColor: Colors.blueAccent,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: new Text(
                              "Registered Students",
                              style: new TextStyle(
                                fontSize: 20.0,
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
                        // width: MediaQuery.of(context).size.width,
                        width: 280.0,
                        height: 45.0,
                        child: RaisedButton(
                          onPressed: () {
                            scoreCard();
                          },
                          textColor: Colors.white,
                          color: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: new Text(
                              "ScoreCard of event",
                              style: new TextStyle(
                                fontSize: 20.0,
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
