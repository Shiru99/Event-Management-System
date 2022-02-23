import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Pages/Admin/AdminInvigilatorsForEvent.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:email_validator/email_validator.dart';

// ignore: must_be_immutable
class AdminInvigilatorDetailsUpdate extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  // ignore: non_constant_identifier_names
  String guest_id;
  // ignore: non_constant_identifier_names
  String event_id;
  SaveUser _user;
  AdminInvigilatorDetailsUpdate(this._user, this._postgresKonnection, this.guest_id,this.event_id);

  @override
  _AdminInvigilatorDetailsUpdateState createState() =>
      _AdminInvigilatorDetailsUpdateState();
}

class _AdminInvigilatorDetailsUpdateState extends State<AdminInvigilatorDetailsUpdate> {
  final _guestDetailsFormKey = GlobalKey<FormState>();

  TextEditingController _guestName = new TextEditingController();
  TextEditingController _guestDescription = new TextEditingController();
  TextEditingController _guestPhoneNum = new TextEditingController();
  TextEditingController _guestEmail = new TextEditingController();

  var results;
  bool _isLoading = true;

  // ignore: non_constant_identifier_names
  String guest_ID;
  // ignore: non_constant_identifier_names
  String event_ID;

  Future fun() async {
    print(1);

    guest_ID = widget.guest_id;
    event_ID = widget.event_id;

    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();
    print(2);

    results = await _konnection
        .query('select * from invigilator where invigilator_id =\'$guest_ID\'');
    print(3);
    print(results);
    print("works");
    print(results);

    _guestName.text = results[0][1].toString();
    _guestDescription.text = results[0][2].toString();
    _guestPhoneNum.text = results[0][3].toString();
    _guestEmail.text = results[0][4].toString();

    setState(() {
      _isLoading = false;
    });
  }

  bool phoneNumValidator() {
    try {
      int phoneNum = int.parse(_guestPhoneNum.text);

      if (phoneNum >= 1000000000 && phoneNum <= 9999999999) {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
    return true;
  }

  update() async {
    // print(00);
    if (_guestDetailsFormKey.currentState.validate()) {
      print("validated");

      setState(() {
        _isLoading = true;
      });

      PostgreSQLConnection _konnection =
          await widget._postgresKonnection.getKonnection();

      try {
        await _konnection.transaction((ctx) async {
          print(guest_ID);

          await ctx.query('''
              UPDATE invigilator
              SET invigilator_name = @a,
                  descriptiono = @b,
                  invigilator_cno = @c,
                  invigilator_email = @d
              WHERE invigilator_id = @e
            ''', substitutionValues: {
            "a": _guestName.text,
            "b": _guestDescription.text,
            "c": _guestPhoneNum.text,
            "d": _guestEmail.text,
            "e": guest_ID,
          });
        });
        toastMessage("Updated successfully");
      } catch (e) {
        print(e.toString());
        toastMessage(e.toString());
      }

      // try {
      //   await _konnection.transaction((ctx) async {
      //     print(guest_ID);

      //     await ctx.query('''
      //         INSERT INTO appoint(invigilator_id,event_id) VALUES(@a,@b)
      //       ''', substitutionValues: {
      //       "a": guest_ID,
      //       "b": event_ID,
      //     });
      //   });

        
      // } catch (e) {
      //   print(e.toString());
      //   toastMessage(e.toString());
      // }

      

      
      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  InvigilatorsForEvent(widget._user, widget._postgresKonnection,event_ID)));
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
                            key: _guestDetailsFormKey,
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
                                          "Guest Name", "Enter the guest name"),
                                      textInputAction: TextInputAction.next,
                                      controller: _guestName,
                                      validator: (_guestName) {
                                        if (_guestName.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _guestName.text = value;
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
                                          "Guest Description",
                                          "Enter the guest description"),
                                      textInputAction: TextInputAction.next,
                                      controller: _guestDescription,
                                      validator: (_guestDescription) {
                                        if (_guestDescription.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _guestDescription.text = value;
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
                                          "Contact No.",
                                          "10 digit mobile number"),
                                      textInputAction: TextInputAction.next,
                                      controller: _guestPhoneNum,
                                      validator: (_guestPhoneNum) {
                                        if (_guestPhoneNum.isEmpty) {
                                          return 'Please enter some text';
                                        } else if (phoneNumValidator()) {
                                          return "please enter valid mobile number ";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _guestPhoneNum.text = value;
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
                                          "Email", "john.doe@fun.kt"),
                                      textInputAction: TextInputAction.done,
                                      controller: _guestEmail,
                                      validator: (_guestEmail) {
                                        if (_guestEmail.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return EmailValidator.validate(
                                                _guestEmail)
                                            ? null
                                            : "Invalid email address";
                                      },
                                      onSaved: (value) {
                                        return _guestEmail.text = value;
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
