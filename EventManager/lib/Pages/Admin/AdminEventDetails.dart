import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Classes/EventInfo.dart';
import 'package:EventManager/Pages/Admin/AdminAddAEvent.dart';
import 'package:EventManager/Pages/Admin/AdminEachEventDetails.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

// ignore: must_be_immutable
class AdminEventDetails extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  AdminEventDetails(this._user, this._postgresKonnection);

  @override
  _AdminEventDetailsState createState() => _AdminEventDetailsState();
}

class _AdminEventDetailsState extends State<AdminEventDetails> {
  bool _isLoading = true;

  List<EventInfo> _eventList = [];
  List results;


  Future fun() async {
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();

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

    // resOfGuests = await _konnection.query('select * from guest');
    // print(resOfGuests);

    // print(resOfGuests.length);

    // _guestList.clear();

    // for (int i = 0; i < resOfGuests.length; i++) {
    //   GuestInfo _guestInfo = new GuestInfo();

    //   _guestInfo.guest_id = resOfGuests[i][0];
    //   _guestInfo.guest_name = resOfGuests[i][1];
    //   _guestInfo.description = resOfGuests[i][2];
    //   _guestInfo.guest_cno = resOfGuests[i][3];
    //   _guestInfo.guest_email = resOfGuests[i][4];
    //   _guestList.add(_guestInfo);
    // }

    // print(_guestList);
    // print(_guestList.length);

    setState(() {
      _isLoading = false;
    });
  }

  addAEvent() async {
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AdminAddAEvent(widget._user, widget._postgresKonnection)));
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
                              "Events",
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
                                  addAEvent();
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
                                    "Add new Event",
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
                                itemCount: _eventList.length,
                                itemBuilder: (_, index) {
                                  return AdminPostUI(
                                    context,
                                    widget._user,
                                    widget._postgresKonnection,
                                    _eventList[index].event_id,
                                    _eventList[index].imageURL,
                                    _eventList[index].event_name,
                                    _eventList[index].description,
                                    _eventList[index].short_description,
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
Widget AdminPostUI(
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
                AdminEachEventDetails(_user, _postgresKonnection, event_ID)));
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
