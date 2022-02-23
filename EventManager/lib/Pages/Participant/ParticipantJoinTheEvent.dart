import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Pages/Participant/ParticipantEachEvents.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:email_validator/email_validator.dart';

// ignore: must_be_immutable
class ParticipantJoinTheEvent extends StatefulWidget {
  PostgresKonnection _postgresKonnection;

  // ignore: non_constant_identifier_names
  String event_ID, event_name;
  // ignore: non_constant_identifier_names
  int tea_size;
  SaveUser _user;
  ParticipantJoinTheEvent(this._postgresKonnection, this._user, this.event_ID,
      this.event_name, this.tea_size);
  @override
  _ParticipantJoinTheEventState createState() =>
      _ParticipantJoinTheEventState();
}

class _ParticipantJoinTheEventState extends State<ParticipantJoinTheEvent> {
  final _registrationTeamFormKey = GlobalKey<FormState>();

  var results;
  List<TextEditingController> con2 = [];
  List<TextEditingController> con3 = [];
  List<TextEditingController> con4 = [];

  // ignore: non_constant_identifier_names
  String group_id;

  bool phoneNumValidator(String _guestPhoneNum) {
    try {
      int phoneNum = int.parse(_guestPhoneNum);

      if (phoneNum >= 1000000000 && phoneNum <= 9999999999) {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
    return true;
  }

  PostgreSQLConnection _konnection;
  int id;
  // ignore: non_constant_identifier_names
  int team_size = 2;
  bool _isLoading = true;
  int zip = 99;

  // ignore: non_constant_identifier_names
  String pat_id;
  TextEditingController _teamName = new TextEditingController();

  Future operation() async {
    _konnection = await widget._postgresKonnection.getKonnection();

    team_size = widget.tea_size;
    // await _postgresKonnection.closeKonnection();
    con2.add(TextEditingController());
    con2.add(TextEditingController());
    con2.add(TextEditingController());
    con2.add(TextEditingController());
    con2.add(TextEditingController());
    con2.add(TextEditingController());
    con3.add(TextEditingController());
    con3.add(TextEditingController());
    con3.add(TextEditingController());
    con3.add(TextEditingController());
    con3.add(TextEditingController());
    con3.add(TextEditingController());
    con4.add(TextEditingController());
    con4.add(TextEditingController());
    con4.add(TextEditingController());
    con4.add(TextEditingController());
    con4.add(TextEditingController());
    con4.add(TextEditingController());



    con2[0].text = widget._user.displayName;
    con3[0].text = widget._user.phoneNumber;
    con4[0].text = widget._user.email;


    setState(() {
      _isLoading = false;
    });
  }

  Future sum() async {

    if (_registrationTeamFormKey.currentState.validate()) {

      zip = 100;
      print("Valid");
      // ignore: await_only_futures
      await setState(() {
        _isLoading = true;
      });

      _konnection = await widget._postgresKonnection.getKonnection();

      // ignore: unused_local_variable
      int flag = 0;
      // ignore: non_constant_identifier_names
      int flag_end = 0;
    // ignore: non_constant_identifier_names
    var flag_p = new List(team_size);
    // ignore: non_constant_identifier_names
    var id_p = new List(team_size);
    var rtt = await _konnection.query(
        "select * from group_participant where group_name=@a",
        substitutionValues: {"a": _teamName.text});
    if (rtt.length != 0) {
      flag_end = 1;
    }
    if (flag_end == 0) {
      var rt = await _konnection.query(
          "select participant_id from participant order by participant_id limit 1");
      int r = int.parse(rt[0][0]);
      for (int i = 0; i < team_size; i++) {
        flag_p[i] = '0';
        id_p[i] = r.toString();
        var r1 = await _konnection.query(
            "select participant_id from participant where participant_name=@a and participant_cno=@b and participant_email=@c",
            substitutionValues: {
              "a": con2[i].text,
              "b": con3[i].text,
              "c": con4[i].text
            });
        if (r1.length == 1) {
          flag_p[i] = '1';
          id_p[i] = r1[0][0];
          var r2 = await _konnection.query(
              "select * from group_participant where participant_id=@a and event_id=@b",
              substitutionValues: {"a": id_p[i], "b": widget.event_ID});
          if (r2.length != 0) {
            flag_end = 1;
          }
        } else {
          r = r - 1;
          id_p[i] = r.toString();
        }
      }
    }
    print(flag_p);
    print(id_p);
    print(flag_end);
    if (flag_end == 0) {
      var r3 = await _konnection.query(
          "select group_id from group_participant order by group_id limit 1");
      // ignore: non_constant_identifier_names
      int g_id = int.parse(r3[0][0]) - 1;
      group_id = g_id.toString();
      print(group_id);
      print(1);

      id_p[0] = widget._user.userID;
      print(id_p[0]);

      for (int i = 0; i < team_size; i++) {

        try {

          var r10 = await _konnection.query(
              "Select participant_id from participant where participant_email = @a",
              substitutionValues: {
                "a": con4[i].text
              });
          id_p[i] = r10[0][0];
          
        } catch (e) {
          
        }
        if (flag_p[i] == '0') {
          try {
                        print("participant adding");

            // ignore: unused_local_variable
            var r4 = await _konnection.query(
              "INSERT INTO participant VALUES (@a,@b,@c,@d)",
              substitutionValues: {
                "a": id_p[i],
                "b": con2[i].text,
                "c": con3[i].text,
                "d": con4[i].text
              });
            print("participant added");
          } catch (e) {

            print(e.toString());
          }
          
        }
        try {
            print("group_participant adding");

          // ignore: unused_local_variable
          var r5 = await _konnection.query(
            "INSERT INTO group_participant VALUES (@a,@b,@c,@d,@e,@f)",
            substitutionValues: {
              "a": id_p[i],
              "b": widget.event_ID,
              "c": 0,
              "d": group_id,
              "e": _teamName.text,
              "f": "NA"
            });
            print("group_participant added");
          
        } catch (e) {
          print(e.toString());
        }
        
      }

      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ParticipantEachEvents(widget._user, widget._postgresKonnection,widget.event_ID)));
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && zip==99) {
      operation();
    }

    return Scaffold(
      appBar: _isLoading ? null : appBarMain(context),
      // resizeToAvoidBottomPadding: false,
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
                          // Form(child: null)
                          Padding(
                            padding: const EdgeInsets.only(top: 150.0),
                            child: logo(90, 280),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 50.0),
                            child: Text(
                              " A Paradigm  Shift  💫", // 💫🌠
                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                  fontFamily: "Signatra"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: new Text(
                              " Registration for",
                              style: new TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20, bottom: 30.0),
                            child: new Text(
                              widget.event_name,
                              style: new TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.yellow,
                                  fontFamily: "Signatra"),
                            ),
                          ),

                          Form(
                              key: _registrationTeamFormKey,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 0.0),
                                      child: new Text(
                                        "Team  Name",
                                        style: new TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.yellow,
                                            fontFamily: "Signatra"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 75.0, vertical: 15.0),
                                      child: new TextFormField(
                                          controller: _teamName,
                                          style: TextStyle(
                                            color: Colors.yellow,
                                          ),
                                          decoration: textInputDecoration(
                                              "Group Name",
                                              "Please Enter the group name"),
                                          textInputAction: TextInputAction.next,
                                          validator: (email) {
                                            if (email.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            return _teamName.text = value;
                                          }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 30, bottom: 0.0),
                                      child: new Text(
                                        "Team  Members",
                                        style: new TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.yellow,
                                            fontFamily: "Signatra"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 0.0),
                                      child: Container(
                                        color: Colors.black,
                                        child: new ListView.builder(
                                          padding: EdgeInsets.all(8.0),
                                          physics:
                                              const ClampingScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: team_size,
                                          itemBuilder: (_, index) {
                                            return PostUI(
                                              context,
                                              con2,
                                              index,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 30, bottom: 0.0),
                                      child: new Text(
                                        "Phone  Numbers",
                                        style: new TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.yellow,
                                            fontFamily: "Signatra"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 5.0),
                                      child: Container(
                                        color: Colors.black,
                                        child: new ListView.builder(
                                          padding: EdgeInsets.all(8.0),
                                          physics:
                                              const ClampingScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: team_size,
                                          itemBuilder: (_, index) {
                                            return PostUI2(
                                              context,
                                              con3[index],
                                              index,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 30, bottom: 0.0),
                                      child: new Text(
                                        "Emails",
                                        style: new TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.yellow,
                                            fontFamily: "Signatra"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 5.0),
                                      child: Container(
                                        color: Colors.black,
                                        child: new ListView.builder(
                                          padding: EdgeInsets.all(8.0),
                                          physics:
                                              const ClampingScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount: team_size,
                                          itemBuilder: (_, index) {
                                            return PostUI3(
                                              context,
                                              con4[index],
                                              index,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ])),

                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 100.0,
                                right: 75,
                                left: 75.0,
                                top: 30.0),
                            child: new SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                onPressed: () {
                                  sum();
                                },
                                textColor: Colors.blue,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(50.0))),
                                elevation: 15,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: new Text(
                                    " Register",
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

// ignore: non_constant_identifier_names
Widget PostUI(BuildContext context, List<TextEditingController> ck, int index) {
  return new Card(
    elevation: 20.0,
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.all(15.0),
    color: Colors.black,
    child: GestureDetector(
      child: new Container(
        padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 25.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new TextFormField(
              controller: ck[index],
              style: TextStyle(
                color: Colors.green,
              ),
              decoration: textInputDecoration(
                  "Participant - " + (index + 1).toString(),
                  "please enter name of paricipant " + (index + 1).toString()),
              textInputAction: TextInputAction.next,
              validator: (email) {
                if (email.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                return ck[index].text = value;
              },
              // onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            ),
          ],
        ),
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget PostUI2(BuildContext context, TextEditingController cc, int index) {
  bool phoneNumValidator(String _guestPhoneNum) {
    try {
      int phoneNum = int.parse(_guestPhoneNum);

      if (phoneNum >= 1000000000 && phoneNum <= 9999999999) {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
    return true;
  }

  return new Card(
    elevation: 20.0,
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.all(15.0),
    color: Colors.black,
    child: GestureDetector(
      child: new Container(
        padding: new EdgeInsets.symmetric(horizontal: 25.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new TextFormField(
              controller: cc,
              style: TextStyle(
                color: Colors.green,
              ),
              decoration: textInputDecoration(
                  "Phone number - " + (index + 1).toString(),
                  "Phone number of participant " + (index + 1).toString()),
              textInputAction: TextInputAction.next,
              validator: (email) {
                if (email.isEmpty) {
                  return 'Please enter some text';
                } else if (phoneNumValidator(email)) {
                  return 'Please enter 10 digit phone number';
                }
                return null;
              },
              onSaved: (value) {
                return cc.text = value;
              },
            ),
          ],
        ),
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget PostUI3(BuildContext context, TextEditingController cc, int index) {
  return new Card(
    elevation: 20.0,
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.all(15.0),
    color: Colors.black,
    child: GestureDetector(
      child: new Container(
        padding: new EdgeInsets.symmetric(horizontal: 25.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new TextFormField(
              controller: cc,
              style: TextStyle(
                color: Colors.green,
              ),
              decoration: textInputDecoration(
                  "Email Address - " + (index + 1).toString(),
                  "email address of participant " + (index + 1).toString()),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              validator: (email) {
                if (email.isEmpty) {
                  return 'Please enter some text';
                }
                return EmailValidator.validate(email)
                    ? null
                    : "Invalid email address";
              },
              onSaved: (value) {
                return cc.text = value;
              },
            ),
          ],
        ),
      ),
    ),
  );
}
