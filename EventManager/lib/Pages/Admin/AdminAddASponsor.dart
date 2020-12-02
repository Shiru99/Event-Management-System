import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Pages/Admin/AdminSponsorDetails.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

// ignore: must_be_immutable
class AdminAddASponsor extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  AdminAddASponsor(this._user, this._postgresKonnection);

  @override
  _AdminAddASponsorState createState() => _AdminAddASponsorState();
}

class _AdminAddASponsorState extends State<AdminAddASponsor> {
  final _sponsorDetailsFormKey = GlobalKey<FormState>();

  var dropdownValue;

  TextEditingController _sponsorName = new TextEditingController();
  TextEditingController _sponsorPhone = new TextEditingController();
  // ignore: unused_field
  TextEditingController _sponsorCategory = new TextEditingController();
  TextEditingController _sponsorLink = new TextEditingController();

  var results;
  // ignore: non_constant_identifier_names
  List<String> sponsor_category = [];
  bool _isLoading = true;

  // ignore: non_constant_identifier_names
  var sponsor_id;
  Future fun() async {
    // sponsor_id = widget.sponsor_id;
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();
    results = await _konnection.query('select Max(sponsor_id) from sponsor');
    print(results[0]);

    sponsor_id = (int.parse(results[0][0]) + 1).toString();

    var categories = await _konnection
        .query('select Distinct(sponsor_category) from sponsor ');

    for (var cat in categories) {
      sponsor_category.add(cat[0].toString());
    }
    print(sponsor_category);

    dropdownValue = sponsor_category[0];

    setState(() {
      _isLoading = false;
    });
  }



  bool phoneNumValidator() {
    try {
      int phoneNum = int.parse(_sponsorPhone.text);

      if (phoneNum >= 1000000000 && phoneNum <= 9999999999) {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
    return true;
  }

  insertThis() async {
    if (_sponsorDetailsFormKey.currentState.validate()) {
      print("validated");

      // setState(() {
      //   _isLoading = true;
      // });

      PostgreSQLConnection _konnection =
          await widget._postgresKonnection.getKonnection();

      try {
        await _konnection.transaction((ctx) async {
          print(sponsor_id);

          // INSERT INTO sponsor(sponsor_id,sponsor_name,sponsor_cno,sponsor_category,sponsor_link) VALUES ('Hello', '9933993399', 'GOLD', 'www.google.com');

          await ctx.query('''
              INSERT INTO sponsor(sponsor_id,sponsor_name,sponsor_cno,sponsor_category,sponsor_link) VALUES(@a,@b,@c,@d,@e)
            ''', substitutionValues: {
            "a": sponsor_id,
            "b": _sponsorName.text,
            "c": _sponsorPhone.text,
            "d": dropdownValue,
            "e": _sponsorLink.text,
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
              builder: (context) => AdminSponsorDetails(
                  widget._user, widget._postgresKonnection)));
    }
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
                            key: _sponsorDetailsFormKey,
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
                                          "Sponsor Name",
                                          "Enter the sponsor name"),
                                      textInputAction: TextInputAction.next,
                                      controller: _sponsorName,
                                      validator: (_sponsorName) {
                                        if (_sponsorName.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _sponsorName.text = value;
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
                                          "Contact Number",
                                          "10 digit mobile number"),
                                      textInputAction: TextInputAction.next,
                                      controller: _sponsorPhone,
                                      validator: (_sponsorPhone) {
                                        if (_sponsorPhone.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        if (phoneNumValidator()) {
                                          return 'Enter valid mobile number';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _sponsorPhone.text = value;
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
                                          "Sponsor Website :", ""),
                                      textInputAction: TextInputAction.done,
                                      controller: _sponsorLink,
                                      validator: (_sponsorLink) {
                                        if (_sponsorLink.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        return _sponsorLink.text = value;
                                      }),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    new Text(
                                      "Sponsor Category",
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                          fontSize: 17, color: Colors.yellow),
                                    ),
                                  ],
                                ),
                                DropdownButton<String>(
                                  value: dropdownValue,
                                  dropdownColor: Colors.black,
                                  elevation: 26,
                                  // controller: _sponsorCategory,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    // fontFamily: "Signatra"
                                    fontStyle: FontStyle.italic,
                                  ),
                                  underline: Container(
                                    height: 1,
                                    color: Colors.white,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                  items: sponsor_category
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
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
                                  insertThis();
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
