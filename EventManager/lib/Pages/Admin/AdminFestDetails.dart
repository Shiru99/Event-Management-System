import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Classes/EventInfo.dart';
import 'package:EventManager/Classes/SponsorInfo.dart';
import 'package:EventManager/Pages/Admin/AdminEventDetails.dart';
import 'package:EventManager/Pages/Admin/AdminGuestDetails.dart';
import 'package:EventManager/Pages/Admin/AdminParsecDetails.dart';
import 'package:EventManager/Pages/Admin/AdminSponsorDetails.dart';
import 'package:EventManager/Pages/CommonPages/EventDetails.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

// ignore: must_be_immutable
class AdminFestDetails extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  AdminFestDetails(this._user, this._postgresKonnection);

  @override
  _AdminFestDetailsState createState() => _AdminFestDetailsState();
}

class _AdminFestDetailsState extends State<AdminFestDetails> {
  bool _isLoading = true;

  List<EventInfo> _eventList = [];
  List results;

  List<SponsorInfo> _sponsorList = [];
  String festImageURL =
      "https://parsec.iitdh.ac.in/images/logos/logo-about.jpg";

  List res;

  Future runQuery() async {
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();

    print(_konnection);

    results = await _konnection.query('select * from evento');
    print(results);

    print(results.length);

    _eventList.clear();

    for (int i = 0; i < results.length; i++) {
      EventInfo _eventInfo = new EventInfo();

      _eventInfo.event_id = results[i][0];
      _eventInfo.event_name = results[i][1];
      _eventInfo.start_date_time = results[i][2];
      _eventInfo.end_date_time = results[i][3];
      _eventInfo.register_start_date_time = results[i][4];
      _eventInfo.register_end_date_time = results[i][5];
      _eventInfo.place = results[i][6];
      _eventInfo.short_description = results[i][7];
      _eventInfo.description = results[i][8];
      _eventInfo.price = results[i][10];
      // _eventInfo.imageURL = results[i][11];

      _eventList.add(_eventInfo);
    }

    print(_eventList);
    print(_eventList.length);

    res = await _konnection.query('select * from sponsor');
    print(res);

    print(res.length);

    _sponsorList.clear();

    for (int i = 0; i < res.length; i++) {
      SponsorInfo _sponsorInfo = new SponsorInfo();

      _sponsorInfo.sponsor_id = res[i][0];
      _sponsorInfo.sponsor_name = res[i][1];
      _sponsorInfo.sponsor_phone = res[i][2];
      _sponsorInfo.sponsor_category = res[i][3];
      _sponsorInfo.sponsor_link = res[i][4];
      // _sponsorInfo.amount = res[i][5];
      // _eventInfo.imageURL = res[i][11];

      _sponsorList.add(_sponsorInfo);
    }

    print(_sponsorList);
    print(_sponsorList.length);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      runQuery();
    }
    // runQuery();

    Future parsecDetails() async {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AdminParsecDetails(
                  widget._user, widget._postgresKonnection)));
    }

    Future eventDetails() async {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AdminEventDetails(widget._user, widget._postgresKonnection)));
    }

    Future sponsorDetails() async {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AdminSponsorDetails(
                  widget._user, widget._postgresKonnection)));
    }

    Future guestDetails() async {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AdminGuestDetails(widget._user, widget._postgresKonnection)));
    }

    // AdminSponsorDetails // AdminGuestDetails // AdminEventDetails
    return Scaffold(
      appBar: _isLoading ? null : appBarMain(context),
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      body: _isLoading
          ? loading()
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 40),
                        GestureDetector(
                          onTap: () {
                            parsecDetails();
                          },
                          child: new Card(
                            elevation: 20.0,
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.all(15.0),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              side: BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            child: new Container(
                              color: Colors.black,
                              padding: new EdgeInsets.all(15.0),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 50),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        new Text(
                                          "Details About",
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.yellow),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Text(
                                      "P A R S E C",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 50.0,
                                          color: Colors.white,
                                          // fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Signatra"),
                                    ),
                                  ),
                                  new Image.asset(
                                    "assets/images/ParsecDetails.png",
                                    fit: BoxFit.cover,
                                  ),
                                  // assets/images/tech.jpg
                                  
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      " A Paradigm  Shift  💫", // 💫🌠
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          color: Colors.white,
                                          fontFamily: "Signatra"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 40),
                        GestureDetector(
                          onTap: () {
                            eventDetails();
                          },
                          child: new Card(
                            elevation: 20.0,
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.all(15.0),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              side: BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            child: new Container(
                              color: Colors.black,
                              padding: new EdgeInsets.all(15.0),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 50),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        new Text(
                                          "Details About",
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.yellow),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Text(
                                      "Events",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 50.0,
                                          color: Colors.white,
                                          // fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Signatra"),
                                    ),
                                  ),
                                  new Image.asset(
                                    "assets/images/tech.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                  // assets/images/tech.jpg
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      " Parsec  💫", // 💫🌠
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          color: Colors.white,
                                          fontFamily: "Signatra"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 40),
                        GestureDetector(
                          onTap: () {
                            sponsorDetails();
                          },
                          child: new Card(
                            elevation: 20.0,
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.all(15.0),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              side: BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            child: new Container(
                              color: Colors.black,
                              padding: new EdgeInsets.all(15.0),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 50),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        new Text(
                                          "Details About",
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.yellow),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Text(
                                      "Sponsors",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 50.0,
                                          color: Colors.white,
                                          // fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Signatra"),
                                    ),
                                  ),
                                   new Image.asset(
                                    "assets/images/sponsors.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                  // assets/images/tech.jpg
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      " Parsec  💫", // 💫🌠
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          color: Colors.white,
                                          fontFamily: "Signatra"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 40),
                        GestureDetector(
                          onTap: () {
                            guestDetails();
                          },
                          child: new Card(
                            elevation: 20.0,
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.all(15.0),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              side: BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            child: new Container(
                              color: Colors.black,
                              padding: new EdgeInsets.all(15.0),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 50),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        new Text(
                                          "Details About",
                                          textAlign: TextAlign.center,
                                          style: new TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.yellow),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Text(
                                      "Guests",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 50.0,
                                          color: Colors.white,
                                          // fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Signatra"),
                                    ),
                                  ),
                                   new Image.asset(
                                    "assets/images/guests.jpg",
                                    fit: BoxFit.cover,
                                  ),
                                  // assets/images/tech.jpg
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      " Parsec  💫", // 💫🌠
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          color: Colors.white,
                                          fontFamily: "Signatra"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       vertical: 10.0, horizontal: 75),
                        //   child: new SizedBox(
                        //     // width: MediaQuery.of(context).size.width,
                        //     width: 280.0,
                        //     height: 45.0,
                        //     child: RaisedButton(
                        //       onPressed: () {},
                        //       textColor: Colors.white,
                        //       color: Colors.blueAccent,
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(50.0))),
                        //       elevation: 15,
                        //       child: Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(vertical: 10.0),
                        //         child: new Text(
                        //           "Events",
                        //           style: new TextStyle(
                        //             fontSize: 22.0,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     // ],
                        //   ),
                        // ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       vertical: 10.0, horizontal: 75),
                        //   child: new SizedBox(
                        //     // width: MediaQuery.of(context).size.width,
                        //     width: 280.0,
                        //     height: 45.0,
                        //     child: RaisedButton(
                        //       onPressed: () {},
                        //       textColor: Colors.white,
                        //       color: Colors.blueAccent,
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(50.0))),
                        //       elevation: 15,
                        //       child: Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(vertical: 10.0),
                        //         child: new Text(
                        //           "Guests",
                        //           style: new TextStyle(
                        //             fontSize: 22.0,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     // ],
                        //   ),
                        // ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       vertical: 10.0, horizontal: 75),
                        //   child: new SizedBox(
                        //     // width: MediaQuery.of(context).size.width,
                        //     width: 280.0,
                        //     height: 45.0,
                        //     child: RaisedButton(
                        //       onPressed: () {},
                        //       textColor: Colors.white,
                        //       color: Colors.blueAccent,
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(50.0))),
                        //       elevation: 15,
                        //       child: Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(vertical: 10.0),
                        //         child: new Text(
                        //           "Sponsors",
                        //           style: new TextStyle(
                        //             fontSize: 22.0,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     // ],
                        //   ),
                        // ),

                        // Padding(
                        //   padding:
                        //       const EdgeInsets.only(top: 50.0, bottom: 10.0),
                        //   child: new Text(
                        //     "Differnt Events",
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
                        //       itemCount: _eventList.length,
                        //       itemBuilder: (_, index) {
                        //         return PostUI(
                        //           context,
                        //           widget._user,
                        //           widget._postgresKonnection,
                        //           _eventList[index].event_id,
                        //           _eventList[index].imageURL,
                        //           _eventList[index].event_name,
                        //           _eventList[index].description,
                        //           _eventList[index].short_description,
                        //         );
                        //       },
                        //     ),
                        //   ),
                        // ),

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
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget PostUI(
  BuildContext context,
  SaveUser _user,
  PostgresKonnection _postgresKonnection,
  // ignore: non_constant_identifier_names
  String event_ID,
  String image,
  // ignore: non_constant_identifier_names
  String event_name,
  String description,
  // ignore: non_constant_identifier_names
  String short_description,
) {
  Future goToEvent() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EventDetails(_user, _postgresKonnection, event_ID)));
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
    child: GestureDetector(
      onTap: () {
        goToEvent();
        print("clicked on event $event_ID");
      },
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
                  short_description,
                  textAlign: TextAlign.center,
                  style: new TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                new Text(
                  event_name,
                  textAlign: TextAlign.center,
                  style: new TextStyle(fontSize: 16.0, color: Colors.black),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            new Image.network(
              image,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10.0,
            ),
            new Text(
              description,
              textAlign: TextAlign.center,
              style: new TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    ),
  );
}
