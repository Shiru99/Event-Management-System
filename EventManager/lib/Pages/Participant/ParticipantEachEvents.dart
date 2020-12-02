import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Classes/EventInfo.dart';
import 'package:EventManager/Pages/Admin/AdminScorecard.dart';
import 'package:EventManager/Pages/CommonPages/EventDetails.dart';
import 'package:EventManager/Pages/Participant/ParticipantRegistration.dart';
import 'package:EventManager/Pages/Participant/ParticipantJoinTheEvent.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

// ignore: must_be_immutable
class ParticipantEachEvents extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  // ignore: non_constant_identifier_names
  String event_ID;
  ParticipantEachEvents(this._user, this._postgresKonnection, this.event_ID);

  @override
  _ParticipantEachEventsState createState() => _ParticipantEachEventsState();
}

class _ParticipantEachEventsState extends State<ParticipantEachEvents> {
  // ignore: non_constant_identifier_names
  String event_id;

  EventInfo _eventInfo = new EventInfo();
  bool _isLoading = true;
  var results;
  String eventNAME;

  bool isRegistered = false;
  bool isJoined = false;
  int members;
  // ignore: non_constant_identifier_names
  var reg_ID;
  // ignore: non_constant_identifier_names
  var par_ID;

  Future runQuery() async {
    event_id = widget.event_ID;

    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();

    // print(_konnection);
    results = await _konnection.query(
        'select participant_limit from evento where event_id = \'$event_id\'');

    members = results[0][0];

    print("select * from evento where event_id=\'$event_id\'");

    var result000 =
        await _konnection.query('select MAX(participant_id) from participant');

    par_ID = (int.parse(result000[0][0]) + 1).toString();

    var result =
        await _konnection.query('select participant_email from participant');

    for (var resu in result) {
      if (resu[0] == widget._user.email) {
        isRegistered = true;
      }
    }

    var mail = widget._user.email;

    if (isRegistered) {
      var resul11 = await _konnection.query(
          'select participant_id from participant where participant_email= \'$mail\'');

      reg_ID = resul11[0][0];
      // print(resul11[0][0]);

      var resul99 = await _konnection.query(
          'select * from group_participant where participant_id= \'$reg_ID\' AND event_id = \'$event_id\'');

      var resul88 = await _konnection.query(
          'select * from individual_participant where participant_id= \'$reg_ID\' AND event_id = \'$event_id\'');

      print(resul99.length);
      print(resul88.length);

      if (resul99.length + resul88.length > 0) {
        isJoined = true;
      }
    }

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

    // print(results.length);

    setState(() {
      _isLoading = false;
    });
  }

  Future goToEvent() async {
    // setState(() {
    //   _isLoading = true;
    // });
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => EventDetails(
                widget._user, widget._postgresKonnection, widget.event_ID)));
  }

  Future registerStudentsForEvent() async {
    // ignore: await_only_futures
    await setState(() {
      _isLoading = true;
    });
    // if (members == 1) {
      _isLoading = true;
      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ParticipantRegistration(
                  widget._user, widget._postgresKonnection, widget.event_ID)));
    // } else {
    //   _isLoading = true;
    //   await Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => ParticipantJoinTheEvent(
    //               widget._postgresKonnection,
    //               widget._user,
    //               widget.event_ID,
    //               eventNAME,
    //               members)));
    // }
  }

  Future scoreCard() async {
    // setState(() {
    //   _isLoading = true;
    // });

    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => AdminScorecard(
                widget._user, widget._postgresKonnection, widget.event_ID)));
  }

  Future joinTheEvent() async {
    // ignore: await_only_futures
    await setState(() {
      _isLoading = true;
    });

    if (members == 1) {
      _isLoading = true;

      PostgreSQLConnection _konnection =
          await widget._postgresKonnection.getKonnection();

      // print(_konnection);
      try {
        par_ID = (int.parse(par_ID) - 1).toString();
        print(par_ID);
        print(event_id);

        print(
            'INSERT INTO individual_participant VALUES (\'$par_ID\',\'$event_id\',0,\'NA\')');

        results = await _konnection.query(
            'INSERT INTO individual_participant VALUES (\'$par_ID\',\'$event_id\',0,\'NA\')');
      } catch (e) {
        print(e.toString());
      }

      toastMessage("Added Successfully");

      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ParticipantEachEvents(
                  widget._user, widget._postgresKonnection, widget.event_ID)));
    } else {
      _isLoading = true;

      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ParticipantJoinTheEvent(
                  widget._postgresKonnection,
                  widget._user,
                  widget.event_ID,
                  eventNAME,
                  members)));
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Registered");
    print(_isLoading);
    print(isRegistered);
    print(isJoined);
    if (_isLoading) {
      runQuery();
    }
    return Scaffold(
      appBar: _isLoading ? null : appBarMain(context),
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      body: _isLoading
          ? loading()
          : (isRegistered)
              ? (isJoined)
                  ? SingleChildScrollView(
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
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 50.0),
                                    child: Text(
                                      " A Paradigm  Shift  💫", // 💫🌠
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          color: Colors.white,
                                          fontFamily: "Signatra"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50.0))),
                                        elevation: 15,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
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
                                          scoreCard();
                                        },
                                        textColor: Colors.white,
                                        color: Colors.blueAccent,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50.0))),
                                        elevation: 15,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
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
                    )
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
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 50.0),
                                    child: Text(
                                      " A Paradigm  Shift  💫", // 💫🌠
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          color: Colors.white,
                                          fontFamily: "Signatra"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50.0))),
                                        elevation: 15,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
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
                                          joinTheEvent();
                                        },
                                        textColor: Colors.blueAccent,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50.0))),
                                        elevation: 15,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: new Text(
                                            "Join This Event",
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50.0))),
                                        elevation: 15,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: new Text(
                                            "ScoreCard of Fest",
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
                    )
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
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 50.0),
                                child: Text(
                                  " A Paradigm  Shift  💫", // 💫🌠
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                      fontFamily: "Signatra"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 10.0),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50.0))),
                                    elevation: 15,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
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
                                      registerStudentsForEvent();
                                    },
                                    textColor: Colors.blueAccent,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50.0))),
                                    elevation: 15,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: new Text(
                                        "Register for Fest",
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50.0))),
                                    elevation: 15,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
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
