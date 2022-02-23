import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Pages/Admin/AdminInvigilatorsForEvent.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:email_validator/email_validator.dart';

// ignore: must_be_immutable
class AdminAddANewInviligator extends StatefulWidget {
  PostgresKonnection _postgresKonnection;

  // ignore: non_constant_identifier_names
  String event_id;
  SaveUser _user;
  AdminAddANewInviligator(this._user, this._postgresKonnection, this.event_id);

  @override
  _AdminAddANewInviligatorState createState() =>
      _AdminAddANewInviligatorState();
}

class _AdminAddANewInviligatorState extends State<AdminAddANewInviligator> {
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
  int k =0;

  Future fun() async {
    print(1);

    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();

    results =
        await _konnection.query('select Max(invigilator_id) from invigilator');

    guest_ID = (int.parse(results[0][0]) + 1).toString();

    print(guest_ID);
    event_ID = widget.event_id;

    setState(() {
      _isLoading = false;
      // ignore: unnecessary_statements
      k+1;
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

      toastMessage("Updating...");
      

      PostgreSQLConnection _konnection =
          await widget._postgresKonnection.getKonnection();

      try {
        await _konnection.transaction((ctx) async {

        

          print(guest_ID);

          await ctx.query('''
              INSERT INTO invigilator(invigilator_id,invigilator_name,descriptiono,invigilator_cno,invigilator_email) VALUES(@a,@b,@c,@d,@e)
            ''', substitutionValues: {
            "a": guest_ID,
            "b": _guestName.text,
            "c": _guestDescription.text,
            "d": _guestPhoneNum.text,
            "e": _guestEmail.text,
          });
          
        });

        print("1 done");
        // print();

        await _konnection.transaction((ctx) async {
            

            await ctx.query('''
              INSERT INTO appoint(invigilator_id,event_id) VALUES(@a,@b)
            ''', substitutionValues: {
              "a": guest_ID,
              "b": event_ID,
            });
          });
        
        print("2 done");

       setState(() {
        _isLoading = true;
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
              builder: (context) => InvigilatorsForEvent(
                  widget._user, widget._postgresKonnection, event_ID)));
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
                                          "Invigilator Name", "Enter the invigilator name"),
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
                                          "Invigilator Description",
                                          "Enter the invigilator description"),
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
                                    "Add",
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
