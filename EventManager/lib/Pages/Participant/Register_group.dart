import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

import '../../Widgets/widgets.dart';
import '../../Widgets/widgets.dart';
import '../../Widgets/widgets.dart';

class Register_group extends StatefulWidget {
  PostgreSQLConnection _konnection;
  String event_id, event_name;
  int tea_size;
  Register_group(
      this._konnection, this.event_id, this.event_name, this.tea_size);
  @override
  _Register_groupState createState() => _Register_groupState();
}

class _Register_groupState extends State<Register_group> {
  var results;
  List<TextEditingController> con2 = [];
  List<TextEditingController> con3 = [];
  List<TextEditingController> con4 = [];
  String group_id;

  int id;
  int team_size = 2;

  String pat_id;
  TextEditingController c1 = new TextEditingController();

  Future operation() async {
    team_size = widget.tea_size;
    // await _postgresKonnection.closeKonnection();
    con2.add(TextEditingController());
    con2.add(TextEditingController());
    con2.add(TextEditingController());
    con2.add(TextEditingController());
    con2.add(TextEditingController());
    con2.add(TextEditingController());
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
    con4.add(TextEditingController());
    con4.add(TextEditingController());
    con4.add(TextEditingController());
    con4.add(TextEditingController());
    con4.add(TextEditingController());
    con4.add(TextEditingController());
  }

  Future sum() async {
    int flag = 0, flag_end = 0, flag_en = 0;
    int flag_nd = 0;
    for (int i = 0; i < team_size; i++) {
      if (con2[i].text == "" || con3[i].text == "" || con4[i].text == "") {
        flag_nd = 1;
      }
    }
    if (flag_nd == 0) {
      var flag_p = new List(team_size);
      var id_p = new List(team_size);
      var rtt = await widget._konnection.query(
          "select * from group_participant where group_name=@a",
          substitutionValues: {"a": c1.text});
      if (rtt.length != 0) {
        flag_end = 1;
      }

      if (flag_end == 0) {
        var rt = await widget._konnection.query(
            "select participant_id from participant order by participant_id limit 1");
        int r = int.parse(rt[0][0]);
        for (int i = 0; i < team_size; i++) {
          flag_p[i] = '0';
          id_p[i] = r.toString();
          var r1 = await widget._konnection.query(
              "select participant_id from participant where participant_name=@a and participant_cno=@b and participant_email=@c",
              substitutionValues: {
                "a": con2[i].text,
                "b": con3[i].text,
                "c": con4[i].text
              });
          if (r1.length == 1) {
            flag_p[i] = '1';
            id_p[i] = r1[0][0];
            var r2 = await widget._konnection.query(
                "select * from group_participant where participant_id=@a and event_id=@b",
                substitutionValues: {"a": id_p[i], "b": widget.event_id});
            if (r2.length != 0) {
              flag_en = 1;
            }
          } else {
            r = r - 1;
            id_p[i] = r.toString();
          }
        }
      } else {
        toastMessage("Group Name already exists");
      }
      if (flag_en == 0) {
        var r3 = await widget._konnection.query(
            "select group_id from group_participant order by group_id limit 1");
        int g_id = int.parse(r3[0][0]) - 1;
        group_id = g_id.toString();
        for (int i = 0; i < team_size; i++) {
          if (con2[i].text == "" && con3[i].text == "" && con4[i].text == "") {
          } else {
            if (con2[i].text == "" ||
                con3[i].text == "" ||
                con4[i].text == "") {
              toastMessage("Incomplete Fields");
            } else {
              if (flag_p[i] == '0') {
                var r4 = await widget._konnection.query(
                    "INSERT INTO participant VALUES (@a,@b,@c,@d)",
                    substitutionValues: {
                      "a": id_p[i],
                      "b": con2[i].text,
                      "c": con3[i].text,
                      "d": con4[i].text
                    });
              }
              var r5 = await widget._konnection.query(
                  "INSERT INTO group_participant VALUES (@a,@b,@c,@d,@e,@f)",
                  substitutionValues: {
                    "a": id_p[i],
                    "b": widget.event_id,
                    "c": 0,
                    "d": group_id,
                    "e": c1.text,
                    "f": "NA"
                  });
            }
          }
        }
        toastMessage("Registerd Succesfully");
      } else {
        toastMessage(
            "Someone in your group is already registered in this event");
      }
    } else {
      toastMessage("Some fields are empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    operation();
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
                        " Registration for " + widget.event_name,
                        style:
                            new TextStyle(fontSize: 22.0, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      child: new TextFormField(
                        controller: c1,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration:
                            textInputDecoration("Group Name", "Group Name"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 75),
                      child: new SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {
                            sum();
                          },
                          textColor: Colors.blue,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      child: Container(
                        color: Colors.black,
                        child: new ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          physics: const ClampingScrollPhysics(),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      child: Container(
                        color: Colors.black,
                        child: new ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          physics: const ClampingScrollPhysics(),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      child: Container(
                        color: Colors.black,
                        child: new ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          physics: const ClampingScrollPhysics(),
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

Widget PostUI(BuildContext context, List<TextEditingController> ck, int index) {
  return new Card(
    elevation: 20.0,
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.all(15.0),
    color: Colors.black,
    child: GestureDetector(
      child: new Container(
        padding: new EdgeInsets.all(25.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new TextFormField(
              controller: ck[index],
              style: TextStyle(
                color: Colors.green,
              ),
              decoration: textInputDecoration(
                  "Name - " + (index + 1).toString(), "Name"),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget PostUI2(BuildContext context, TextEditingController cc, int index) {
  return new Card(
    elevation: 20.0,
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.all(15.0),
    color: Colors.black,
    child: GestureDetector(
      child: new Container(
        padding: new EdgeInsets.all(25.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new TextFormField(
              controller: cc,
              style: TextStyle(
                color: Colors.green,
              ),
              decoration: textInputDecoration(
                  "Phone number - " + (index + 1).toString(), " Number"),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget PostUI3(BuildContext context, TextEditingController cc, int index) {
  return new Card(
    elevation: 20.0,
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.all(15.0),
    color: Colors.black,
    child: GestureDetector(
      child: new Container(
        padding: new EdgeInsets.all(25.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new TextFormField(
              controller: cc,
              style: TextStyle(
                color: Colors.green,
              ),
              decoration: textInputDecoration(
                  "Mail Id - " + (index + 1).toString(), " Mail ID"),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            ),
          ],
        ),
      ),
    ),
  );
}
