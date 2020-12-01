import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Classes/EventInfo.dart';
import 'package:EventManager/Classes/GuestInfo.dart';
import 'package:EventManager/Classes/Teams.dart';
import 'package:EventManager/Pages/Admin/AdminEventDetailsUpdate.dart';
import 'package:EventManager/Pages/Admin/AdminInvigilatorsForEvent.dart';
import 'package:EventManager/Pages/Admin/AdminRegisteredStudents.dart';
import 'package:EventManager/Pages/Admin/AdminScorecard.dart';
import 'package:EventManager/Pages/CommonPages/EventDetails.dart';
import 'package:EventManager/Pages/Invigilator/InvigilatorEachEvent.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class InvigilatorScoring extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  String event_ID;
  InvigilatorScoring(this._user, this._postgresKonnection, this.event_ID);

  @override
  _InvigilatorScoringState createState() => _InvigilatorScoringState();
}

class _InvigilatorScoringState extends State<InvigilatorScoring> {
  var results;
  bool _isLoading = true;

  String festImageURL =
      "https://parsec.iitdh.ac.in/images/logos/logo-about.jpg";

  // List res;
  List resOfGuests;
  // List<SponsorInfo> _sponsorList = [];
  List<GuestInfo> _guestList = [];
  List<Teams> _teamList = [];

  String event_id;
  int total_registered = 0;
  int size = 0;

  Future fun() async {
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();

    event_id = widget.event_ID;

    var group_size = await _konnection.query(
        'select participant_limit from evento where event_id = \'$event_id\'');

    print(group_size[0][0]);
    size = group_size[0][0];
    print("Size :");
    print(size);

    if (group_size[0][0] == 1) {
      print("One");

      String query = '''

      SELECT * from individual_participant,participant
      WHERE event_id = \'$event_id\'
      AND individual_participant.participant_id = participant.participant_id
      ORDER BY score DESC
    ''';

      //  SELECT * from individual_participant,participant  WHERE event_id = '20202303' AND individual_participant.participant_id = participant.participant_id ORDER BY score DESC

      resOfGuests = await _konnection.query(query);

      print(resOfGuests);

      print(resOfGuests.length);
      total_registered = resOfGuests.length;

      _guestList.clear();

      for (int i = 0; i < resOfGuests.length; i++) {
        GuestInfo _guestInfo = new GuestInfo();

        _guestInfo.guest_id = resOfGuests[i][4];
        _guestInfo.guest_name = resOfGuests[i][5];
        _guestInfo.description = "";
        _guestInfo.guest_cno = resOfGuests[i][2].toString();
        _guestInfo.guest_email = resOfGuests[i][3];
        _guestList.add(_guestInfo);
      }

      print(_guestList);
      print(_guestList.length);
    } else {
      print("Many");
      String query = '''

      SELECT * 
            from group_participant,participant

      WHERE   event_id = \'$event_id\' 
            AND group_participant.participant_id = participant.participant_id
            ORDER BY score DESC,group_id ASC
    ''';
// DESC
      print("1");
      resOfGuests = await _konnection.query(query);

      print(resOfGuests);

      print(resOfGuests.length);

      total_registered = resOfGuests.length;

      _guestList.clear();

      for (var member in resOfGuests) {
        print(member);
      }

      for (int i = 0; i < resOfGuests.length; i += group_size[0][0]) {
        Teams _teamInfo = new Teams();

        _teamInfo.group_id = resOfGuests[i][3];
        _teamInfo.group_name = resOfGuests[i][4];
        _teamInfo.score = resOfGuests[i][2].toString();
        _teamInfo.review = resOfGuests[i][5];

        for (int j = 0; j < group_size[0][0]; j++) {
          _teamInfo.participant_id.add(resOfGuests[i + j][6]);
          _teamInfo.participant_name.add(resOfGuests[i + j][7]);
          _teamInfo.participant_cno.add(resOfGuests[i + j][8]);
          _teamInfo.participant_email.add(resOfGuests[i + j][9]);
        }

        _teamList.add(_teamInfo);
      }

      print(_teamList);
      print(_teamList.length);

      total_registered = _teamList.length;
      size = _teamList.length;
    }

    setState(() {
      _isLoading = false;
    });

    print("Working here");
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      fun();
    }

    return Scaffold(
        appBar: _isLoading ? null : appBarMain(context),
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body: _isLoading
            ? loading()
            : ((size == 1)
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 50),
                                  child: new Text(
                                    "Scorecard",
                                    style: new TextStyle(
                                        fontSize: 40.0,
                                        color: Colors.yellow,
                                        fontFamily: "Signatra"),
                                  ),
                                ),
                                new Text(
                                  "Total  participants $total_registered",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0, vertical: 10.0),
                                  child: Container(
                                    color: Colors.black,
                                    child: new ListView.builder(
                                      padding: EdgeInsets.all(8.0),
                                      physics: const ClampingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: _guestList.length,
                                      itemBuilder: (_, index) {
                                        return AdminRegisteredStudentPostUI(
                                          context,
                                          widget._user,
                                          widget._postgresKonnection,
                                          _guestList[index].guest_id,
                                          _guestList[index].guest_name,
                                          _guestList[index].description,
                                          _guestList[index].guest_cno,
                                          _guestList[index].guest_email,
                                          _guestList[index].imageURL,
                                          widget.event_ID
                                        );
                                      },
                                    ),
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 50),
                                  child: new Text(
                                    "Scorecard",
                                    style: new TextStyle(
                                        fontSize: 40.0,
                                        color: Colors.yellow,
                                        fontFamily: "Signatra"),
                                  ),
                                ),
                                new Text(
                                  "Total  Teams $total_registered",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0, vertical: 10.0),
                                  child: Container(
                                    color: Colors.black,
                                    child: new ListView.builder(
                                      padding: EdgeInsets.all(8.0),
                                      physics: const ClampingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: _teamList.length,
                                      itemBuilder: (_, index) {
                                        return AdminRegisteredTeamPostUI(
                                            context,
                                            widget._user,
                                            widget._postgresKonnection,
                                            _teamList[index].group_id,
                                            _teamList[index].group_name,
                                            _teamList[index].score,
                                            _teamList[index].review,
                                            _teamList[index].participant_id,
                                            _teamList[index].participant_name,
                                            _teamList[index].participant_cno,
                                            _teamList[index].participant_email,
                                            festImageURL,
                                            widget.event_ID
                                            )
                                            ;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )));
  }
}

Widget AdminRegisteredStudentPostUI(
  BuildContext context,
  SaveUser _user,
  PostgresKonnection _postgresKonnection,
  String guest_id,
  String guest_name,
  String description,
  String guest_phone_number,
  String guest_mail_ID,
  String logo,
  String event_ID
) {

  final _signInFormKey = GlobalKey<FormState>();

  TextEditingController _marks = new TextEditingController();
  TextEditingController _remark = new TextEditingController();

  _marks.text = guest_mail_ID;
  _remark.text =  guest_phone_number;


  bool validateMarks(var email){
    try {
      int.parse(email);
    } catch (e) {
      return true;
    }
    return false;
  }
  updateScore() async {
    if (_signInFormKey.currentState.validate()) {
      print("validated");


      PostgreSQLConnection _konnection =
          await _postgresKonnection.getKonnection();

      try {
        await _konnection.transaction((ctx) async {
          print(event_ID);

          await ctx.query('''

          UPDATE individual_participant
          SET score = @a, review= @b
          WHERE participant_id = @c
            ''', substitutionValues: {
            "a": int.parse(_remark.text),
            "b": _marks.text,
            "c": guest_id,
          });

        });
      toastMessage("Updated successfully");

      } catch (e) {
        print(e.toString());
        toastMessage(e.toString());
      }

      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  InvigilatorEachEvent(_user, _postgresKonnection,event_ID)));
    }
  }



  return new Card(
    elevation: 20.0,
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.all(15.0),
    color: Colors.red,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40.0),
      side: BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
    ),
    child: new Container(
      color: Colors.white,
      padding: new EdgeInsets.all(25.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Text(
                "Student ID",
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
              new Text(
                guest_id,
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),

          SizedBox(height: 10),
          Icon(
            Icons.emoji_events_rounded,
            color: Colors.yellow,
            size: 100.0,
          ),

          new Text(
            guest_name,
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontSize: 36.0, color: Colors.black, fontFamily: "Signatra"),
          ),


          SizedBox(
            height: 10,
          ),

          Form(
            key: _signInFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 5.0),
                  child: new TextFormField(
                      // cursorColor: ,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: new InputDecoration(
                        labelText: "Marks",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        hintText: "Interger number only",
                        hintStyle: TextStyle(
                        ),
                        fillColor: Colors.black,

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        //
                      ),

                      textInputAction: TextInputAction.next,
                      controller: _remark,
                      validator: (remark) {
                        if (remark.isEmpty) {
                          return 'Please enter some text';
                        }else if(validateMarks(remark)){
                          return 'Please enter interger number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        return _remark.text = value;
                      }),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 5.0),
                  child: new TextFormField(
                      // cursorColor: ,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: new InputDecoration(
                        labelText: "Remark",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        hintText: "Nicely Done !",
                        hintStyle: TextStyle(
                          // color: Colors.black,
                        ),
                        fillColor: Colors.black,

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        //
                      ),

                      textInputAction: TextInputAction.next,
                      controller: _marks,
                      validator: (email) {
                        if (email.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        return _marks.text = value;
                      }),
                ),


                
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 75),
            child: new SizedBox(
              // width: MediaQuery.of(context).size.width,
              width: 280.0,
              height: 45.0,
              child: RaisedButton(
                onPressed: () {
                  // signInTheUserGP();
                  updateScore();
                },
                textColor: Colors.white,
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                elevation: 15,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: new Text(
                    "Update",
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
    ),
  );
}

Widget AdminRegisteredTeamPostUI(
  BuildContext context,
  SaveUser _user,
  PostgresKonnection _postgresKonnection,
  String group_id,
  String group_name,
  String score,
  String review,
  List<String> participant_id,
  List<String> participant_name,
  List<String> participant_cno,
  List<String> participant_email,
  String logo,
  String event_ID
) {
  String team = "";
  for (int i = 0; i < participant_id.length; i++) {
    team = team + participant_id[i] + "\t\t" + participant_name[i] + "\n";
  }

  print(team);

  final _signInFormKey = GlobalKey<FormState>();

  TextEditingController _marks = new TextEditingController();
  TextEditingController _remark = new TextEditingController();

  _marks.text = review;
  _remark.text = score;


  bool validateMarks(var email){
    try {
      int.parse(email);
    } catch (e) {
      return true;
    }
    return false;
  }
  updateScore() async {
    if (_signInFormKey.currentState.validate()) {
      print("validated");


      PostgreSQLConnection _konnection =
          await _postgresKonnection.getKonnection();

      try {
        await _konnection.transaction((ctx) async {
          print(event_ID);

          await ctx.query('''

          UPDATE group_participant
          SET score = @a, review= @b
          WHERE group_id = @c
            ''', substitutionValues: {
            "a": int.parse(_remark.text),
            "b": _marks.text,
            "c": group_id,
          });

        });
      toastMessage("Updated successfully");

      } catch (e) {
        print(e.toString());
        toastMessage(e.toString());
      }

      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  InvigilatorEachEvent(_user, _postgresKonnection,event_ID)));
    }
  }

  return new Card(
    elevation: 20.0,
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.all(15.0),
    color: Colors.red,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40.0),
      side: BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
    ),
    child: new Container(
      color: Colors.white,
      padding: new EdgeInsets.all(25.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              new Text(
                "Team ID",
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),
              new Text(
                group_id,
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: 10),
          new Text(
            group_name,
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontSize: 36.0, color: Colors.black, fontFamily: "Signatra"),
          ),
          SizedBox(height: 10),
          Icon(
            Icons.emoji_events_rounded,
            color: Colors.yellow,
            size: 100.0,
          ),
          new Text(
            team,
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 18.0, color: Colors.black),
          ),
          Form(
            key: _signInFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 5.0),
                  child: new TextFormField(
                      // cursorColor: ,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: new InputDecoration(
                        labelText: "Marks",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        hintText: "Interger number only",
                        hintStyle: TextStyle(
                        ),
                        fillColor: Colors.black,

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        //
                      ),

                      textInputAction: TextInputAction.next,
                      controller: _remark,
                      validator: (remark) {
                        if (remark.isEmpty) {
                          return 'Please enter some text';
                        }else if(validateMarks(remark)){
                          return 'Please enter interger number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        return _remark.text = value;
                      }),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 5.0),
                  child: new TextFormField(
                      // cursorColor: ,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: new InputDecoration(
                        labelText: "Remark",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        hintText: "Nicely Done !",
                        hintStyle: TextStyle(
                          // color: Colors.black,
                        ),
                        fillColor: Colors.black,

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        //
                      ),

                      textInputAction: TextInputAction.next,
                      controller: _marks,
                      validator: (email) {
                        if (email.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        return _marks.text = value;
                      }),
                ),


                
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 75),
            child: new SizedBox(
              // width: MediaQuery.of(context).size.width,
              width: 280.0,
              height: 45.0,
              child: RaisedButton(
                onPressed: () {
                  // signInTheUserGP();
                  updateScore();
                },
                textColor: Colors.white,
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                elevation: 15,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: new Text(
                    "Update",
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
    ),
  );
}
