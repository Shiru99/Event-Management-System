import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Pages/Admin/AdminAddASponsor.dart';
import 'package:EventManager/Pages/Admin/AdminSponsorDetailsUpdate.dart';
import 'package:EventManager/Classes/SponsorInfo.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

// ignore: must_be_immutable
class AdminSponsorDetails extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  AdminSponsorDetails(this._user, this._postgresKonnection);

  @override
  _AdminSponsorDetailsState createState() => _AdminSponsorDetailsState();
}

class _AdminSponsorDetailsState extends State<AdminSponsorDetails> {
  var results;
  bool _isLoading = true;

  List resSponsor;
  List<SponsorInfo> _sponsorList = [];

  Future fun() async {
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();

    resSponsor = await _konnection.query('select * from sponsor');
    print(resSponsor);

    print(resSponsor.length);

    _sponsorList.clear();

    for (int i = 0; i < resSponsor.length; i++) {
      SponsorInfo _sponsorInfo = new SponsorInfo();

      _sponsorInfo.sponsor_id = resSponsor[i][0];
      _sponsorInfo.sponsor_name = resSponsor[i][1];
      _sponsorInfo.sponsor_phone = resSponsor[i][2];
      _sponsorInfo.sponsor_category = resSponsor[i][3];
      _sponsorInfo.sponsor_link = resSponsor[i][4];
      // _sponsorInfo.amount = resSponsor[i][5];
      // _eventInfo.imageURL = resSponsor[i][11];

      _sponsorList.add(_sponsorInfo);
    }

    print(_sponsorList);
    print(_sponsorList.length);

    setState(() {
      _isLoading = false;
    });

    // print(results[0]);
  }

  addASponsor() async {
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AdminAddASponsor(widget._user, widget._postgresKonnection)));
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: new Text(
                              "Sponsors",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: 42.0,
                                  color: Colors.yellow,
                                  fontFamily: "Signatra"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: new SizedBox(
                              // width: MediaQuery.of(context).size.width,
                              width: 280.0,
                              height: 45.0,
                              child: RaisedButton(
                                onPressed: () {
                                  addASponsor();
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
                                    "Add new Sponsor",
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
                                  return AdminSponsorPostUI(
                                    context,
                                    widget._user,
                                    widget._postgresKonnection,
                                    _sponsorList[index].sponsor_link,
                                    _sponsorList[index].sponsor_name,
                                    _sponsorList[index].sponsor_category,
                                    _sponsorList[index].sponsor_id,
                                    _sponsorList[index].sponsor_phone,
                                    "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png",
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
Widget AdminSponsorPostUI(
  BuildContext context,
  SaveUser _user,
  PostgresKonnection _postgresKonnection,
  // ignore: non_constant_identifier_names
  String sponsor_link,
  // ignore: non_constant_identifier_names
  String sponsor_name,
  // ignore: non_constant_identifier_names
  String sponsor_category,
  // ignore: non_constant_identifier_names
  String sponsor_id,
  // ignore: non_constant_identifier_names
  String sponsor_phone,
  String logo,
) {
  Future updateTheGuest() async {
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => AdminSponsorDetailsUpdate(
                _user, _postgresKonnection, sponsor_id)));
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
                style: new TextStyle(fontSize: 16, color: Colors.blueAccent),
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
          Image.asset(
            "assets/images/sponsor.png",
            fit: BoxFit.cover,
          ),
          // new Image.network(
          //   logo,
          //   fit: BoxFit.cover,
          // ),
          new Text(
            "sponsor ID",
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 16, color: Colors.blueAccent),
          ),
          new Text(
            sponsor_id,
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 18, color: Colors.black),
          ),
          SizedBox(height: 10),
          new Text(
            "Phone No",
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 16, color: Colors.blueAccent),
          ),
          new Text(
            sponsor_phone,
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 18, color: Colors.black),
          ),
          SizedBox(height: 10),
          new Text(
            "Website",
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 16, color: Colors.blueAccent),
          ),
          new Text(
            sponsor_link,
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 18, color: Colors.black),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: new SizedBox(
              // width: MediaQuery.of(context).size.width,
              width: 280.0,
              height: 45.0,
              child: RaisedButton(
                onPressed: () {
                  updateTheGuest();
                },
                textColor: Colors.white,
                color: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50.0))),
                elevation: 15,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
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
        ],
      ),
    ),
  );
}
