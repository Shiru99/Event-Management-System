import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Classes/GuestInfo.dart';
import 'package:EventManager/Classes/Teams.dart';
import 'package:EventManager/Pages/Admin/AdminAddAInvigilator.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

// ignore: must_be_immutable
class AdminRegisteredStudents extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  // ignore: non_constant_identifier_names
  String event_id;
  SaveUser _user;
  AdminRegisteredStudents(this._user, this._postgresKonnection, this.event_id);

  @override
  _AdminRegisteredStudentsState createState() =>
      _AdminRegisteredStudentsState();
}

class _AdminRegisteredStudentsState extends State<AdminRegisteredStudents> {
  var results;
  bool _isLoading = true;

  String festImageURL =
      "https://parsec.iitdh.ac.in/images/logos/logo-about.jpg";

  // List res;
  List resOfGuests;
  // List<SponsorInfo> _sponsorList = [];
  List<GuestInfo> _guestList = [];
  List<Teams> _teamList = [];

  // ignore: non_constant_identifier_names
  String event_id;

  // ignore: non_constant_identifier_names
  int total_registered = 0;
  int size = 0;

  Future fun() async {
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();

    event_id = widget.event_id;

    // ignore: non_constant_identifier_names
    var group_size = await _konnection.query(
        'select participant_limit from evento where event_id = \'$event_id\'');

    print(group_size[0][0]);
    size = group_size[0][0];
    if (group_size[0][0] == 1) {
      print("One");

      String query = '''

      SELECT * from individual_participant,participant
      WHERE event_id = \'$event_id\'
      AND individual_participant.participant_id = participant.participant_id
      ORDER BY score DESC
    ''';

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
        _guestInfo.guest_cno = resOfGuests[i][6];
        _guestInfo.guest_email = resOfGuests[i][7];
        _guestList.add(_guestInfo);
      }

      print(_guestList);
      print(_guestList.length);
    } else {
      // print("Many");

      print("Many");
      String query = '''

      SELECT * 
            from group_participant,participant

      WHERE   event_id = \'$event_id\' 
            AND group_participant.participant_id = participant.participant_id
            ORDER BY score,group_id DESC
    ''';

      print("1");
      resOfGuests = await _konnection.query(query);

      print(resOfGuests);

      print(resOfGuests.length);

      _guestList.clear();

      for (var member in resOfGuests) {
        print(member);
      }

      print("one");
      print(resOfGuests.length);
      print(group_size[0][0]);

      for (int i = 0; i < resOfGuests.length; i += group_size[0][0]) {
        print(i);
        Teams _teamInfo = new Teams();

        _teamInfo.group_id = resOfGuests[i][3];
        _teamInfo.group_name = resOfGuests[i][4];
        _teamInfo.score = resOfGuests[i][2].toString();
        _teamInfo.review = resOfGuests[i][5];
        print("J :");
        for (int j = 0; j < group_size[0][0]; j++) {
          print(j);
          print(i + j);
          _teamInfo.participant_id.add(resOfGuests[i + j][6]);
          _teamInfo.participant_name.add(resOfGuests[i + j][7]);
          _teamInfo.participant_cno.add(resOfGuests[i + j][8]);
          _teamInfo.participant_email.add(resOfGuests[i + j][9]);
        }

        _teamList.add(_teamInfo);
      }
      print("two");

      print(_teamList);
      print(_teamList.length);
      total_registered = _teamList.length;

      // await Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => AdminTeamDetails(
      //             widget._user, widget._postgresKonnection, widget.event_id)));
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future addAInvigilator() async {
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => AdminAddAInvigilator(
                widget._user, widget._postgresKonnection, widget.event_id)));
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
                                  "Registered  Students",
                                  style: new TextStyle(
                                      fontSize: 40.0,
                                      color: Colors.yellow,
                                      fontFamily: "Signatra"),
                                ),
                              ),
                              new Text(
                                "Registered  Students $total_registered",
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
                                  "Registered  Teams",
                                  style: new TextStyle(
                                      fontSize: 40.0,
                                      color: Colors.yellow,
                                      fontFamily: "Signatra"),
                                ),
                              ),
                              new Text(
                                "Registered  Teams $total_registered",
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
                                          festImageURL);
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
                )),
    );
  }
}

// ignore: non_constant_identifier_names
Widget AdminRegisteredStudentPostUI(
  BuildContext context,
  SaveUser _user,
  PostgresKonnection _postgresKonnection,
  // ignore: non_constant_identifier_names
  String guest_id,
  // ignore: non_constant_identifier_names
  String guest_name,
  String description,
  // ignore: non_constant_identifier_names
  String guest_phone_number,
  // ignore: non_constant_identifier_names
  String guest_mail_ID,
  String logo,
) {
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

Image.asset(
            "assets/images/personRegistration.jpeg",
            fit: BoxFit.cover,
          ),
          
          SizedBox(height: 10),
          // Icon(
          //   Icons.person,
          //   color: Colors.green,
          //   size: 100.0,
          // ),

          new Text(
            guest_name,
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontSize: 36.0, color: Colors.black, fontFamily: "Signatra"),
          ),
          // new Image.network(
          //   logo,
          //   fit: BoxFit.cover,
          // ),

          SizedBox(
            height: 10,
          ),

          new Text(
            "Phone No",
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 16, color: Colors.blueAccent),
          ),
          new Text(
            guest_phone_number,
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 18, color: Colors.black),
          ),
          SizedBox(height: 10),
          new Text(
            "Email ID",
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 16, color: Colors.blueAccent),
          ),
          new Text(
            guest_mail_ID,
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 18, color: Colors.black),
          ),
          SizedBox(height: 10),
        ],
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget AdminRegisteredTeamPostUI(
  BuildContext context,
  SaveUser _user,
  PostgresKonnection _postgresKonnection,
  // ignore: non_constant_identifier_names
  String group_id,
  // ignore: non_constant_identifier_names
  String group_name,
  String score,
  String review,
  // ignore: non_constant_identifier_names
  List<String> participant_id,
  // ignore: non_constant_identifier_names
  List<String> participant_name,
  // ignore: non_constant_identifier_names
  List<String> participant_cno,
  // ignore: non_constant_identifier_names
  List<String> participant_email,
  String logo,
) {
  print("101");
  String team = "";
  for (int i = 0; i < participant_id.length; i++) {
    team = team + participant_id[i] + "\t\t\t" + participant_name[i] + "\n";
  }

  print(team);
  print("1 " + participant_name[0]);

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

          Image.asset(
            "assets/images/team.png",
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10),
          // Icon(
          //   Icons.person,
          //   color: Colors.green,
          //   size: 100.0,
          // ),
          // SizedBox(height: 10),
          //   Icon(
          //     Icons.group,
          //     color: Colors.green,
          //     size: 100.0,
          //   ),

          new Text(
            team,
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ],
      ),
    ),
  );
}
