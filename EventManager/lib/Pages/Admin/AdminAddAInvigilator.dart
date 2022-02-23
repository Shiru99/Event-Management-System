import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Classes/GuestInfo.dart';
import 'package:EventManager/Pages/Admin/AdminAddANewInvigilator.dart';
import 'package:EventManager/Pages/Admin/AdminInvigilatorDetailsUpdate.dart';
import 'package:EventManager/Pages/Admin/AdminInvigilatorsForEvent.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

// ignore: must_be_immutable
class AdminAddAInvigilator extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  // ignore: non_constant_identifier_names
  String event_id;
  SaveUser _user;
  AdminAddAInvigilator(this._user, this._postgresKonnection, this.event_id);

  @override
  _AdminAddAInvigilatorState createState() => _AdminAddAInvigilatorState();
}

class _AdminAddAInvigilatorState extends State<AdminAddAInvigilator> {
  var results;
  bool _isLoading = true;

  String festImageURL =
      "https://parsec.iitdh.ac.in/images/logos/logo-about.jpg";

  // List res;
  List resOfGuests;
  // List<SponsorInfo> _sponsorList = [];
  List<GuestInfo> _guestList = [];

  Future fun() async {
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();
    results = await _konnection.query('select * from fest');
    print(results);

    // ignore: non_constant_identifier_names
    String event_id = widget.event_id;
    print(event_id);

    String query = '''

    select * from invigilator where invigilator_id not in (select Distinct(invigilator.invigilator_id) from 
                      invigilator,appoint
        where 
              invigilator.invigilator_id = appoint.invigilator_id AND 
              event_id = \'$event_id\'

        )
    ''';

    resOfGuests = await _konnection.query(query);

    // resOfGuests = await _konnection.query('select * from guest');

    print(resOfGuests);

    print(resOfGuests.length);

    _guestList.clear();

    for (int i = 0; i < resOfGuests.length; i++) {
      GuestInfo _guestInfo = new GuestInfo();

      _guestInfo.guest_id = resOfGuests[i][0];
      _guestInfo.guest_name = resOfGuests[i][1];
      _guestInfo.description = resOfGuests[i][2];
      _guestInfo.guest_cno = resOfGuests[i][3];
      _guestInfo.guest_email = resOfGuests[i][4];
      _guestList.add(_guestInfo);
    }

    print(_guestList);
    print(_guestList.length);

    setState(() {
      _isLoading = false;
    });

    print(results[0]);
  }

  Future addANewInvigilator() async {
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => AdminAddANewInviligator(
                widget._user, widget._postgresKonnection, widget.event_id)));
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

                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 50.0),
                          //   child: new Text(
                          //     results[0][1].toString(),
                          //     style: new TextStyle(
                          //         fontSize: 22.0, color: Colors.white),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 50),
                            child: new Text(
                              "Invigilators  For  Event",
                              style: new TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.yellow,
                                  fontFamily: "Signatra"),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15),
                            child: new SizedBox(
                              // width: MediaQuery.of(context).size.width,
                              width: 280.0,
                              height: 45.0,
                              child: RaisedButton(
                                onPressed: () {
                                  addANewInvigilator();
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
                                    "Add New Invigilator",
                                    style: new TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              // ],
                            ),
                          ),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(top: 50.0, bottom: 10.0),
                          //   child: new Text(
                          //     "Sponsors",
                          //     style: new TextStyle(
                          //         fontSize: 22.0, color: Colors.white),
                          //   ),
                          // ),

                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //       horizontal: 24.0, vertical: 10.0),
                          //   child: Container(
                          //     color: Colors.black,
                          //     child: new ListView.builder(
                          //       padding: EdgeInsets.all(8.0),
                          //       physics: const ClampingScrollPhysics(),
                          //       scrollDirection: Axis.vertical,
                          //       shrinkWrap: true,
                          //       itemCount: _sponsorList.length,
                          //       itemBuilder: (_, index) {
                          //         return SponsorPostUI(
                          //           _sponsorList[index].sponsor_link,
                          //           _sponsorList[index].sponsor_name,
                          //           _sponsorList[index].sponsor_category,
                          //           "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png",
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // ),

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
                                  return AdminInvigilatorPostUI(
                                    context,
                                    widget._user,
                                    widget._postgresKonnection,
                                    widget.event_id,
                                    _guestList[index].guest_id,
                                    _guestList[index].description,
                                    _guestList[index].guest_name,
                                    "",
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
            ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget AdminInvigilatorPostUI(
  BuildContext context,
  SaveUser _user,
  PostgresKonnection _postgresKonnection,
  // ignore: non_constant_identifier_names
  String event_id,
  // ignore: non_constant_identifier_names
  String guest_id,
  // ignore: non_constant_identifier_names
  String sponsor_link,
  // ignore: non_constant_identifier_names
  String sponsor_name,
  // ignore: non_constant_identifier_names
  String sponsor_category,
  String logo,
) {
  Future updateInvigilatorDetails() async {
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => AdminInvigilatorDetailsUpdate(
                _user, _postgresKonnection, guest_id, event_id)));
  }

  Future addThisInviligator() async {
    toastMessage("Adding...");
    PostgreSQLConnection _konnection =
        await _postgresKonnection.getKonnection();

    try {
      await _konnection.transaction((ctx) async {
        await ctx.query('''
              INSERT INTO appoint(invigilator_id,event_id) VALUES(@a,@b)
            ''', substitutionValues: {
          "a": guest_id,
          "b": event_id,
        });
      });

      print(" Added invigilator");
      toastMessage("Added successfully");
    } catch (e) {
      print(e.toString());
      toastMessage(e.toString());
    }

    print(guest_id);
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => InvigilatorsForEvent(
                _user, _postgresKonnection, event_id)));
  }
  
  

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
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Text(
                sponsor_category,
                textAlign: TextAlign.center,
                style: new TextStyle(fontSize: 20.0, color: Colors.indigo),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          new Text(
            sponsor_name,
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontSize: 36.0, color: Colors.black, fontFamily: "Signatra"),
          ),
          new Image.asset(
              "assets/images/invigilator.jpg",
              fit: BoxFit.cover,
            ),
          // new Image.network(
          //   logo,
          //   fit: BoxFit.cover,
          // ),
          SizedBox(
            height: 10.0,
          ),
          new Text(
            sponsor_link,
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 16.0, color: Colors.black),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            child: new SizedBox(
              // width: MediaQuery.of(context).size.width,
              width: 280.0,
              height: 45.0,
              child: RaisedButton(
                onPressed: () {
                  updateInvigilatorDetails();
                },
                textColor: Colors.blueAccent,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                elevation: 15,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: new Text(
                    "Edit Details",
                    style: new TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              // ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            child: new SizedBox(
              // width: MediaQuery.of(context).size.width,
              width: 280.0,
              height: 45.0,
              child: RaisedButton(
                onPressed: () {
                  addThisInviligator();
                },
                textColor: Colors.white,
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                elevation: 15,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: new Text(
                    "Add this Invigilator",
                    style: new TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              // ],
            ),
          ),
        ],
      ),
    ),
  );
}
