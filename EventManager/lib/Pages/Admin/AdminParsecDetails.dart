import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Pages/Admin/AdminParsecDetailsUpdate.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

// ignore: must_be_immutable
class AdminParsecDetails extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  AdminParsecDetails(this._user, this._postgresKonnection);

  @override
  _AdminParsecDetailsState createState() => _AdminParsecDetailsState();
}

class _AdminParsecDetailsState extends State<AdminParsecDetails> {
  var results;
  bool _isLoading = true;

  Future fun() async {
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();
    results = await _konnection.query('select * from fest where fest_id = \'202023\'');
    print(results);

    setState(() {
      _isLoading = false;
    });


  }

  update() async {
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AdminParsecDetailsUpdate(widget._user, widget._postgresKonnection)));
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

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 50.0, horizontal: 75),
                            child: new SizedBox(
                              // width: MediaQuery.of(context).size.width,
                              width: 280.0,
                              height: 45.0,
                              child: RaisedButton(
                                onPressed: () {
                                  update();
                                  // signInTheUserGP();
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
                                    "Update the fest details",
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

                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(top: 50.0, bottom: 10.0),
                          //   child: new Text(
                          //     "Guests",
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
                          //       itemCount: _guestList.length,
                          //       itemBuilder: (_, index) {
                          //         return SponsorPostUI(
                          //           _guestList[index].description,
                          //           _guestList[index].guest_name,
                          //           "",
                          //           _guestList[index].imageURL,
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
            ),
    );
  }
}
