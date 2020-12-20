import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Classes/GuestInfo.dart';
import 'package:EventManager/Classes/SponsorInfo.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

// ignore: must_be_immutable
class ParsecDetails extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  // ignore: unused_field
  SaveUser _user;
  ParsecDetails(this._user, this._postgresKonnection);

  @override
  _ParsecDetailsState createState() => _ParsecDetailsState();
}

class _ParsecDetailsState extends State<ParsecDetails> {
  var results;
  bool _isLoading = true;

  String festImageURL =
      "https://parsec.iitdh.ac.in/images/logos/logo-about.jpg";

  List res;
  List resOfGuests;
  List<SponsorInfo> _sponsorList = [];
  List<GuestInfo> _guestList = [];

  Future fun() async {
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();
    results = await _konnection.query('select * from fest');
    print(results);

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

    resOfGuests = await _konnection.query('select * from guest');
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
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  "Anual tech fest of",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontSize: 20.0, color: Colors.yellow),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: new Text(
                              results[0][2].toString(),
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: 42.0,
                                  color: Colors.white,
                                  fontFamily: "Signatra"),
                            ),
                          ),

                          new Text(
                            "_____",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontSize: 32.0,
                              color: Colors.yellow,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                                right: 50, left: 50, top: 30),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Text(
                                  "Starting From",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontSize: 18.0, color: Colors.yellow),
                                ),
                                new Text(
                                  results[0][3].toString().split(' ')[0],
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontSize: 36.0,
                                      color: Colors.white,
                                      fontFamily: "Signatra"),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                                right: 50, left: 50, top: 10),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Text(
                                  "For next",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontSize: 18.0, color: Colors.yellow),
                                ),
                                new Text(
                                  results[0][4].toString(),
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontSize: 36.0,
                                      color: Colors.white,
                                      fontFamily: "Signatra"),
                                ),
                              ],
                            ),
                          ),

                          new Text(
                            "_____",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontSize: 32.0,
                              color: Colors.yellow,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                                top: 30.0, bottom: 8.0, left: 50, right: 50.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  "Fest Website",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontSize: 20.0, color: Colors.yellow),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: new Text(
                              "https://parsec.iitdh.ac.in",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: 36.0,
                                  color: Colors.white,
                                  fontFamily: "Signatra"),
                            ),
                          ),

                          new Text(
                            "_____",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontSize: 32.0,
                              color: Colors.yellow,
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 50),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Text(
                                  "Contact Details",
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontSize: 20.0, color: Colors.yellow),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: new Text(
                              "+91  9916228725",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: 36.0,
                                  color: Colors.white,
                                  fontFamily: "Signatra"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: new Text(
                              "support.parsec@iitdh.ac.in",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: 36.0,
                                  color: Colors.white,
                                  fontFamily: "Signatra"),
                            ),
                          ),

                          new Text(
                            "_______________",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontSize: 32.0,
                              color: Colors.yellow,
                            ),
                          ),

                          SizedBox(height: 20),

                          Padding(
                            padding:
                                const EdgeInsets.only(top: 50.0, bottom: 10.0),
                            child: new Text(
                              "Sponsors",
                              style: new TextStyle(
                                  fontSize: 48.0,
                                  color: Colors.yellow,
                                  fontFamily: "Signatra"),
                            ),
                          ),
                          SizedBox(height: 20),
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
                                itemCount: _sponsorList.length,
                                itemBuilder: (_, index) {
                                  return SponsorPostUI(
                                    _sponsorList[index].sponsor_link,
                                    _sponsorList[index].sponsor_name,
                                    _sponsorList[index].sponsor_category,
                                    "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png",
                                  );
                                },
                              ),
                            ),
                          ),

                          new Text(
                            "_______________",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontSize: 32.0,
                              color: Colors.yellow,
                            ),
                          ),

                          SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 50.0, bottom: 10.0),
                            child: new Text(
                              "Guests",
                              style: new TextStyle(
                                  fontSize: 48.0,
                                  color: Colors.yellow,
                                  fontFamily: "Signatra"),
                            ),
                          ),
                          SizedBox(height: 20),
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
                                  return SponsorPostUIGUEST(
                                    _guestList[index].description,
                                    _guestList[index].guest_name,
                                    "",
                                    _guestList[index].imageURL,
                                  );
                                },
                              ),
                            ),
                          ),
                          new Text(
                            "_______________",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontSize: 32.0,
                              color: Colors.yellow,
                            ),
                          ),
                          SizedBox(height: 40.0),
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
