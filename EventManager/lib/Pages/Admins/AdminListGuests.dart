import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Classes/EventInfo.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class AdminListGuests extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  AdminListGuests(this._user, this._postgresKonnection);
  @override
  _AdminListGuestsState createState() => _AdminListGuestsState();
}

class _AdminListGuestsState extends State<AdminListGuests> {
  bool _isLoading = true;
  List<EventInfo> _guestList = [];

  List results;

  Future runQuery() async {
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();

    print(_konnection);

    results = await _konnection.query('select * from guest');
    print(results);

    print(results.length);

    _guestList.clear();

    for (int i = 0; i < results.length; i++) {
      EventInfo _guestInfo = new EventInfo();

      _guestInfo.guest_id = results[i][0];
      _guestInfo.guest_name = results[i][1];
      _guestInfo.description = results[i][2];
      _guestInfo.guestCno = results[i][3];
      _guestInfo.guestEmail = results[i][4];

      _guestList.add(_guestInfo);
    }

    print(_guestList);
    print(_guestList.length);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      runQuery();
    }
    return Scaffold(
      appBar: _isLoading ? null : appBarMain(context),
      resizeToAvoidBottomPadding: false,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50.0),
                          child: new Text(
                            "Guests",
                            style: new TextStyle(
                                fontSize: 22.0, color: Colors.white),
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
                                return PostUI(
                                  context,
                                  widget._user,
                                  widget._postgresKonnection,
                                  _guestList[index].guest_name,
                                  _guestList[index].description,
                                  _guestList[index].guestCno,
                                  _guestList[index].guestEmail,
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
    );
  }
}

Widget PostUI(
    BuildContext context,
    SaveUser _user,
    PostgresKonnection _postgresKonnection,
    String guestName,
    String description,
    String guestCno,
    String guestEmail) {
  return new Card(
    elevation: 20.0,
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.all(15.0),
    color: Colors.red,

    // shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //         bottomRight: Radius.circular(50)),
    //     side: BorderSide(width: 1, color: Colors.black)
    // ),

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40.0),
      side: BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
    ),
    child: GestureDetector(
      // onTap: () {
      //   goToEvent();
      //   print("clicked on event $event_ID");
      // },
      child: new Container(
        color: Colors.white,
        padding: new EdgeInsets.all(25.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // new Text(
                //   guestName,
                //   // style: Theme.of(context).textTheme.subtitle2,
                //   textAlign: TextAlign.center,
                //   // style: TextStyle(
                //   //   color: Colors.white,
                //   // ),
                // ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            new Text(
              guestName,
              // style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
              // style: TextStyle(
              //   color: Colors.white,
              // ),
            ),
            SizedBox(
              height: 18.0,
            ),
            new Text(
              description,
              // style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
              // style: TextStyle(
              //   color: Colors.white,
              // ),
            ),
            SizedBox(
              height: 10.0,
            ),
            new Text(
              guestCno,
              // style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
              // style: TextStyle(
              //   color: Colors.white,
              // ),
            ),
            SizedBox(
              height: 10.0,
            ),
            new Text(
              guestEmail,
              // style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
              // style: TextStyle(
              //   color: Colors.white,
              // ),
            ),
            SizedBox(
              height: 10.0,
              // child:Colors.black,
            ),
          ],
        ),
      ),
    ),
  );
}
