import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Classes/GuestInfo.dart';
import 'package:EventManager/Pages/Admin/AdminAddAGuest.dart';
import 'package:EventManager/Pages/Admin/AdminGuestDetailsUpdate.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

// ignore: must_be_immutable
class AdminGuestDetails extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  AdminGuestDetails(this._user, this._postgresKonnection);

  @override
  _AdminGuestDetailsState createState() => _AdminGuestDetailsState();
}

class _AdminGuestDetailsState extends State<AdminGuestDetails> {
  var results;
  bool _isLoading = true;

  List resOfGuests;
  List<GuestInfo> _guestList = [];

  Future fun() async {
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();

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
  }

  addAGuest() async {
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AdminAddAGuest(widget._user, widget._postgresKonnection)));
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
                              "Guests",
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
                                  addAGuest();
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
                                    "Add new Guest",
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
                                itemCount: _guestList.length,
                                itemBuilder: (_, index) {
                                  return AdminGuestPostUI(

                                    context,
                                    widget._user,
                                    widget._postgresKonnection,
                                    _guestList[index].guest_id,
                                    _guestList[index].guest_name,
                                    _guestList[index].description,
                                    _guestList[index].guest_cno,
                                    _guestList[index].guest_email,
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
Widget AdminGuestPostUI(
  BuildContext context,
  SaveUser _user,
  PostgresKonnection _postgresKonnection,
  // ignore: non_constant_identifier_names
  String guest_id,
  // ignore: non_constant_identifier_names
  String guest_name,
  String description,
  // ignore: non_constant_identifier_names
  String guest_phone_number,
  // ignore: non_constant_identifier_names
  String guest_mail_ID,
  String logo,
) {
  Future updateTheGuest() async {
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => AdminGuestDetailsUpadate(
                _user, _postgresKonnection,guest_id)));
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
          new Text(
            guest_name,
            textAlign: TextAlign.center,
            style: new TextStyle(
                fontSize: 36.0, color: Colors.black, fontFamily: "Signatra"),
          ),
          Image.asset(
            "assets/images/Guest.png",
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
            "Guest ID",
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 16, color: Colors.blueAccent),
          ),
          new Text(
            guest_id,
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
            guest_phone_number,
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 18, color: Colors.black),
          ),
          SizedBox(height: 10),
          new Text(
            "Email ID",
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 16, color: Colors.blueAccent),
          ),
          new Text(
            guest_mail_ID,
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 18, color: Colors.black),
          ),
          SizedBox(height: 10),
          new Text(
            "About Guest",
            textAlign: TextAlign.center,
            style: new TextStyle(fontSize: 16, color: Colors.blueAccent),
          ),
          new Text(
            description,
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
