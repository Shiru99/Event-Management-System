import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Classes/EventInfo.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class EventDetails extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  String event_ID;
  EventDetails(this._user, this._postgresKonnection, this.event_ID);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  String event_id;

  EventInfo _eventInfo = new EventInfo();
  bool _isLoading = true;
  var results;

  Future runQuery() async {
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();

    print(_konnection);

    event_id = widget.event_ID;
    print("select * from evento where event_id=\'$event_id\'");
    results = await _konnection
        .query("select * from evento where event_id= '$event_id'");

    _eventInfo.event_id = results[0][0];
    _eventInfo.event_name = results[0][1];
    _eventInfo.start_date_time = results[0][2];
    _eventInfo.end_date_time = results[0][3];
    _eventInfo.register_start_date_time = results[0][4];
    _eventInfo.register_end_date_time = results[0][5];
    _eventInfo.place = results[0][6];
    _eventInfo.description = results[0][7];
    _eventInfo.price = results[0][8];
    // _eventInfo.imageURL = results[0][9];

    print(results.length);

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
      appBar: appBarMain(context),
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 10.0),
                      child: Container(
                        color: Colors.black,
                        child: new ListView(
                          padding: EdgeInsets.all(8.0),
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: [
                            SizedBox(height: 20.0),
                            DatailTitle("Event  Name"),
                            DetailDescription(_eventInfo.event_name.toString()),
                            DetailImage(_eventInfo.imageURL.toString()),
                            SizedBox(height: 20.0),
                            DatailTitle("Event  Time"),
                            DetailDescription("From\n" +
                                _eventInfo.start_date_time.toString() +
                                "\n\nTo\n" +
                                _eventInfo.end_date_time.toString()),
                            SizedBox(height: 20.0),
                            DatailTitle("Registration  Date"),
                            DetailDescription("From\n" +
                                _eventInfo.register_start_date_time.toString() +
                                "\n\nTo\n" +
                                _eventInfo.register_end_date_time.toString()),
                            SizedBox(height: 20.0),
                            DatailTitle("Location"),
                            DetailDescription(_eventInfo.place.toString()),
                            SizedBox(height: 20.0),
                            DatailTitle("Event  Description"),
                            DetailDescription(
                                _eventInfo.description.toString()),
                            SizedBox(height: 20.0),
                            DatailTitle("Price"),
                            DetailDescription(_eventInfo.price.toString()),
                            SizedBox(height: 20.0),
                          ],
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