import 'dart:typed_data';

import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class Register extends StatefulWidget {
  PostgreSQLConnection _konnection;
  String event_id, event_name;
  Register(this._konnection, this.event_id, this.event_name);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var results;
  int id;
  String pat_id;
  TextEditingController c1 = new TextEditingController();
  TextEditingController c2 = new TextEditingController();
  TextEditingController c3 = new TextEditingController();
  TextEditingController c4 = new TextEditingController();
  Future operation() async {
    // await _postgresKonnection.closeKonnection();
  }

  Future sum() async {
    var resul = await widget._konnection.query("select * from participant");
    int flag = 0;

    for (int i = 0; i < resul.length; i++) {
      if (c1.text == resul[i][1] &&
          c2.text == resul[i][2] &&
          c3.text == resul[i][3]) {
        pat_id = resul[i][0];
        flag = 1;
        break;
      }
    }
    if (flag == 0) {
      results = await widget._konnection.query(
          "select participant_id from participant order by participant_id limit 1");

      id = int.parse(results[0][0]) - 1;
      pat_id = id.toString();
      var re = await widget._konnection.query(
          "INSERT INTO participant VALUES (@a,@b,@c,@d)",
          substitutionValues: {
            "a": pat_id,
            "b": c1.text,
            "c": c2.text,
            "d": c3.text
          });
      var re1 = await widget._konnection.query(
          "INSERT INTO individual_participant VALUES (@a,@b,@c,@d)",
          substitutionValues: {
            "a": pat_id,
            "b": widget.event_id,
            "c": 0,
            "d": "NA"
          });
    } else {
      var ree = await widget._konnection
          .query("select * from individual_participant");
      int flag1 = 0;
      for (int i = 0; i < ree.length; i++) {
        if (pat_id == ree[i][0] && widget.event_id == ree[i][1]) {
          flag1 = 1;
          break;
        }
      }
      if (flag1 == 0) {
        var re1 = await widget._konnection.query(
            "INSERT INTO individual_participant VALUES (@a,@b,@c,@d)",
            substitutionValues: {
              "a": pat_id,
              "b": widget.event_id,
              "c": 0,
              "d": "NA"
            });
      }
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
                            textInputDecoration("Name", " john.doe@gmail.com"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      child: new TextFormField(
                        controller: c2,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration:
                            textInputDecoration("Phone Number", " 9992874"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      child: new TextFormField(
                        controller: c3,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: textInputDecoration(
                            "Mail Id", " john.doe@gmail.com"),
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
