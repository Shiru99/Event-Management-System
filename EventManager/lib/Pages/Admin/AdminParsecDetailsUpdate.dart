import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Pages/Admin/AdminParsecDetails.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

// ignore: must_be_immutable
class AdminParsecDetailsUpdate extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  AdminParsecDetailsUpdate(this._user, this._postgresKonnection);

  @override
  _AdminParsecDetailsUpdateState createState() =>
      _AdminParsecDetailsUpdateState();
}

class _AdminParsecDetailsUpdateState extends State<AdminParsecDetailsUpdate> {
  final _parsedDetailsFormKey = GlobalKey<FormState>();

  TextEditingController _festName = new TextEditingController();
  TextEditingController _collageName = new TextEditingController();
  TextEditingController _startDate = new TextEditingController();
  TextEditingController _duration = new TextEditingController();

  var results;
  bool _isLoading = true;

  Future fun() async {
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();
    results = await _konnection
        .query('select * from fest where fest_id = \'202023\'');
    print(results[0]);

    _festName.text = results[0][1].toString();
    _collageName.text = results[0][2].toString();
    _startDate.text = results[0][3].toString().split(' ')[0];
    _duration.text = results[0][4].toString().split(' ')[0];

    setState(() {
      _isLoading = false;
    });
  }

  bool validationDuration() {
    // print(_duration.);
    try {
      // ignore: unused_local_variable
      int days = int.parse(_duration.text);
      return false;
    } catch (e) {
      print(e.toString());
    }

    return true;
  }

  bool dateValidator() {
    try {
      int yyyy, mm, dd;

      yyyy = int.parse(_startDate.text.toString().split('-')[0]);
      mm = int.parse(_startDate.text.toString().split('-')[1]);
      dd = int.parse(_startDate.text.toString().split('-')[2]);

      print(yyyy);
      print(mm);
      print(dd);
      if (yyyy <= 2100 &&
          yyyy >= 1900 &&
          mm >= 1 &&
          mm <= 12 &&
          dd > 0 &&
          dd <= 31) {
        return false;
      }
    } catch (e) {
      print(1);
      print(e.toString());
    }
    return true;
  }

  update() async {
    if (_parsedDetailsFormKey.currentState.validate()) {
      print("validated");

      // print(_);
      setState(() {
        _isLoading = true;
      });

      PostgreSQLConnection _konnection =
          await widget._postgresKonnection.getKonnection();

      try {
        await _konnection.transaction((ctx) async {
          // ignore: non_constant_identifier_names
          var fest_id = '202023';
          print(fest_id);

          await ctx.query('''
              UPDATE fest
              SET fest_name = @a,
                  college_name = @b,
                  start_date = @c,
                  duration = @d
              WHERE fest_id = @e
            ''', substitutionValues: {
            "a": _festName.text,
            "b": _collageName.text,
            "c": _startDate.text,
            "d": _duration.text + " Days",
            "e": fest_id,
          });
        });
      } catch (e) {
        print(e.toString());
        toastMessage(e.toString());
      }

      toastMessage("Updated successfully");
      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AdminParsecDetails(
                  widget._user, widget._postgresKonnection)));

      //
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      fun();
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
                          Form(
                            key: _parsedDetailsFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 5.0),
                                  child: new TextFormField(
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: textInputDecoration(
                                          "Fest Name", "Enter the Fest name"),
                                      textInputAction: TextInputAction.next,
                                      controller: _festName,
                                      validator: (_festName) {
                                        if (_festName.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _festName.text = value;
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 5.0),
                                  child: new TextFormField(
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: textInputDecoration(
                                          "Collage Name",
                                          "Enter the collage name"),
                                      textInputAction: TextInputAction.next,
                                      controller: _collageName,
                                      validator: (_collageName) {
                                        if (_collageName.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _collageName.text = value;
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 5.0),
                                  child: new TextFormField(
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: textInputDecoration(
                                          "Fest Date", "format YYYY-MM-DD"),
                                      textInputAction: TextInputAction.next,
                                      controller: _startDate,
                                      validator: (_startDate) {
                                        if (_startDate.isEmpty) {
                                          return 'Please enter date';
                                        } else if (dateValidator()) {
                                          return "please use YYYY-MM-DD format";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _startDate.text = value;
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 5.0),
                                  child: new TextFormField(
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: textInputDecoration(
                                          "Duration", "number of days"),
                                      textInputAction: TextInputAction.done,
                                      controller: _duration,
                                      validator: (_duration) {
                                        if (_duration.isEmpty) {
                                          return 'Please enter some text';
                                        } else if (validationDuration()) {
                                          return 'Just enter number of days';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _duration.text = value;
                                      }),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 14.0,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 75),
                            child: new SizedBox(
                              // width: MediaQuery.of(context).size.width,
                              width: 280.0,
                              height: 45.0,
                              child: RaisedButton(
                                onPressed: () {
                                  update();
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

                          SizedBox(
                            height: 64.0,
                          ),

                          ///
                          ///
                          ///
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
