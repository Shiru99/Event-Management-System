import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

import '../../Widgets/widgets.dart';
import '../../Widgets/widgets.dart';

class AsInvigilator extends StatefulWidget {
  PostgreSQLConnection _konnection;
  String event_id, event_name;
  SaveUser _user;
  AsInvigilator(this._konnection, this.event_id, this.event_name, this._user);
  @override
  _AsInvigilatorState createState() => _AsInvigilatorState();
}

class _AsInvigilatorState extends State<AsInvigilator> {
  int not = 0;
  bool _isLoading = true;
  var id_p;
  var name_p;
  Future operation() async {
    var r5 = await widget._konnection.query(
        "select * from invigilator natural join appoint where invigilator_email=@a and event_id=@b",
        substitutionValues: {"a": widget._user.email, "b": widget.event_id});
    if (r5.length == 0) {
      not = 0;
    } else {
      var resul = await widget._konnection.query(
          "select * from individual_participant where event_id=@a",
          substitutionValues: {"a": widget.event_id});
      not = resul.length;
      id_p = new List(not);
      name_p = new List(not);
      for (int i = 0; i < not; i++) {
        id_p[i] = resul[i][0];
        var r3 = await widget._konnection.query(
            "select participant_name from participant where participant_id=@a",
            substitutionValues: {"a": id_p[i]});
        name_p[i] = r3[0][0];
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      operation();
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
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: new Text(
                              "Invigilator Score Card ",
                              style: new TextStyle(
                                  fontSize: 22.0, color: Colors.white),
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
                                itemCount: not,
                                itemBuilder: (_, index) {
                                  return PostUI(
                                    context,
                                    index,
                                    id_p[index],
                                    name_p[index],
                                    widget.event_id,
                                    widget._konnection,
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

Widget PostUI(BuildContext context, int index, String id, String nam,
    String event_i, PostgreSQLConnection _konnection) {
  TextEditingController c1 = new TextEditingController();
  TextEditingController c2 = new TextEditingController();

  Future goth() async {
    try {
      var r2 = await _konnection.query(
          "update individual_participant set score=@a, review=@b where participant_id=@c and event_id=@d",
          substitutionValues: {
            "a": c1.text,
            "b": c2.text,
            "c": id,
            "d": event_i
          });
      toastMessage("Updated Succesfully");
    } catch (e) {
      toastMessage("Not updated");
    }
  }

  return new Card(
    elevation: 20.0,
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.all(15.0),
    color: Colors.black,
    child: GestureDetector(
      child: new Container(
        padding: new EdgeInsets.all(25),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text(
              " Name : " + nam,
              style: new TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            new TextFormField(
              controller: c1,
              style: TextStyle(
                color: Colors.green,
              ),
              decoration: textInputDecoration("Marks ", " john.doe@gmail.com"),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            ),
            new TextFormField(
              controller: c2,
              style: TextStyle(
                color: Colors.green,
              ),
              decoration: textInputDecoration("Review ", " john.doe@gmail.com"),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            ),
            new SizedBox(
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                onPressed: () {
                  goth();
                },
                textColor: Colors.blue,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                elevation: 15,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: new Text(
                    " Update ",
                    style: new TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                ),
              ),
              // ],
            ),
          ],
        ),
      ),
    ),
  );
}
