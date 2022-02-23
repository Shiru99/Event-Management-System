import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Pages/Admin/AdminEachEventDetails.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

// ignore: must_be_immutable
class AdminEventDetailsUpdate extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  // ignore: non_constant_identifier_names
  String event_ID;
  AdminEventDetailsUpdate(this._user, this._postgresKonnection, this.event_ID);

  @override
  _AdminEventDetailsUpdateState createState() =>
      _AdminEventDetailsUpdateState();
}

class _AdminEventDetailsUpdateState extends State<AdminEventDetailsUpdate> {
  final _addEventFormKey = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names
  TextEditingController _event_name = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController _start_date_time = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController _end_date_time = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController _register_start_date_time = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController _register_end_date_time = new TextEditingController();
  TextEditingController _place = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController _short_description = new TextEditingController();
  TextEditingController _description = new TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController _participant_limit = new TextEditingController();
  TextEditingController _price = new TextEditingController();

  var results;
  bool _isLoading = true;

  // ignore: non_constant_identifier_names
  var event_id;

  Future fun() async {
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();

    event_id = widget.event_ID;

    print(event_id);

    results = await _konnection
        .query('select * from evento where event_id = \'$event_id\'');

    _event_name.text = results[0][1].toString();
    _start_date_time.text = results[0][2].toString().split(' ')[0];
    _end_date_time.text = results[0][3].toString().split(' ')[0];
    _register_start_date_time.text = results[0][4].toString().split(' ')[0];
    _register_end_date_time.text = results[0][5].toString().split(' ')[0];
    _place.text = results[0][6].toString();
    _short_description.text = results[0][7].toString();
    _description.text = results[0][8].toString();
    _participant_limit.text = results[0][9].toString();
    _price.text = results[0][10].toString();

    // print(event_id);

    setState(() {
      _isLoading = false;
    });
  }

  // ignore: missing_return
  bool isValidNumber(var number) {
    try {
      int a = int.parse(number);
      if (a > 0) return false;
    } catch (e) {
      return true;
    }
  }

  bool dateValidator(var date) {
    try {
      print(date);
      int yyyy, mm, dd;

      yyyy = int.parse(date.split('-')[0]);
      mm = int.parse(date.split('-')[1]);
      dd = int.parse(date.split('-')[2]);

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

  updateAEvent() async {
    if (_addEventFormKey.currentState.validate()) {
      print("validated");

      setState(() {
        _isLoading = true;
      });

      PostgreSQLConnection _konnection =
          await widget._postgresKonnection.getKonnection();

      try {
        await _konnection.transaction((ctx) async {
          print(event_id);

          await ctx.query('''
              UPDATE evento 
              SET 
                  event_name = @b,
                  start_date_time = @c,
                  end_date_time = @d,
                  register_start_date_time = @e,
                  register_end_date_time =@f,
                  place = @g,
                  short_description=@h,
                  description = @i,
                  participant_limit = @j,
                  price=@k
              WHERE 
                event_id = @a
            ''', substitutionValues: {
            "a": event_id.toString(),
            "b": _event_name.text,
            "c": _start_date_time.text,
            "d": _end_date_time.text,
            "e": _register_start_date_time.text,
            "f": _register_end_date_time.text,
            "g": _place.text,
            "h": _short_description.text,
            "i": _description.text,
            "j": int.parse(_participant_limit.text),
            "k": _price.text,
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
              builder: (context) => AdminEachEventDetails(
                  widget._user, widget._postgresKonnection, event_id)));
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
                            key: _addEventFormKey,
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
                                          "Event Name", "Enter the event name"),
                                      textInputAction: TextInputAction.next,
                                      controller: _event_name,
                                      // ignore: non_constant_identifier_names
                                      validator: (_event_name) {
                                        if (_event_name.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _event_name.text = value;
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
                                          "Fest Starts on",
                                          "format YYYY-MM-DD"),
                                      textInputAction: TextInputAction.next,
                                      controller: _start_date_time,
                                      // ignore: non_constant_identifier_names
                                      validator: (_start_date_time) {
                                        if (_start_date_time.isEmpty) {
                                          return 'Please enter date';
                                        } else if (dateValidator(
                                            _start_date_time)) {
                                          return "please use YYYY-MM-DD format";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _start_date_time.text = value;
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
                                          "Event Ends on", "format YYYY-MM-DD"),
                                      textInputAction: TextInputAction.next,
                                      controller: _end_date_time,
                                      // ignore: non_constant_identifier_names
                                      validator: (_end_date_time) {
                                        if (_end_date_time.isEmpty) {
                                          return 'Please enter date';
                                        } else if (dateValidator(
                                            _end_date_time)) {
                                          return "please use YYYY-MM-DD format";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _end_date_time.text = value;
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
                                          "Fest Registrations starts on",
                                          "format YYYY-MM-DD"),
                                      textInputAction: TextInputAction.next,
                                      controller: _register_start_date_time,
                                      // ignore: non_constant_identifier_names
                                      validator: (_register_start_date_time) {
                                        if (_register_start_date_time.isEmpty) {
                                          return 'Please enter date';
                                        } else if (dateValidator(
                                            _register_start_date_time)) {
                                          return "please use YYYY-MM-DD format";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _register_start_date_time.text =
                                            value;
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
                                          "Fest Registraion ends on",
                                          "format YYYY-MM-DD"),
                                      textInputAction: TextInputAction.next,
                                      controller: _register_end_date_time,
                                      // ignore: non_constant_identifier_names
                                      validator: (_register_end_date_time) {
                                        if (_register_end_date_time.isEmpty) {
                                          return 'Please enter date';
                                        } else if (dateValidator(
                                            _register_end_date_time)) {
                                          return "please use YYYY-MM-DD format";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _register_end_date_time.text =
                                            value;
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
                                          "Place", "Enter the event location"),
                                      textInputAction: TextInputAction.next,
                                      controller: _place,
                                      validator: (_place) {
                                        if (_place.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _place.text = value;
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
                                          "Short Description",
                                          "Enter the short description of event"),
                                      textInputAction: TextInputAction.next,
                                      controller: _short_description,
                                      // ignore: non_constant_identifier_names
                                      validator: (_short_description) {
                                        if (_short_description.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _short_description.text = value;
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
                                          "Description",
                                          "Add description of event"),
                                      textInputAction: TextInputAction.next,
                                      controller: _description,
                                      validator: (_description) {
                                        if (_description.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _description.text = value;
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
                                          "Winning Price", "₹ 2,50,000"),
                                      textInputAction: TextInputAction.next,
                                      controller: _price,
                                      validator: (_price) {
                                        if (_price.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _price.text = value;
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
                                          "Team size limit", "4"),
                                      textInputAction: TextInputAction.done,
                                      controller: _participant_limit,
                                      // ignore: non_constant_identifier_names
                                      validator: (_participant_limit) {
                                        if (_participant_limit.isEmpty) {
                                          return 'Please enter some text';
                                        } else if (isValidNumber(
                                            _participant_limit)) {
                                          return 'please add valid number';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _participant_limit.text = value;
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
                                  updateAEvent();
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
                                    "Update Event details",
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
