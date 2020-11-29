import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Classes/EventInfo.dart';
import 'package:EventManager/Pages/ParsecDetails.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class FestDetails extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  FestDetails(this._user, this._postgresKonnection);

  @override
  _FestDetailsState createState() => _FestDetailsState();
}

class _FestDetailsState extends State<FestDetails> {
  bool _isLoading = true;
  List<EventInfo> _eventList = [];

  List results;

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
      _eventInfo.description = results[i][7];
      _eventInfo.price = results[i][8];

      _eventList.add(_eventInfo);
    }

    print(_eventList);
    print(_eventList.length);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_isLoading){
      runQuery();
    }
    // runQuery();

    Future sum() async {
      await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ParsecDetails(widget._user, widget._postgresKonnection)));
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
                            "All Details about Parsec & Sub-Events",
                            style: new TextStyle(
                                fontSize: 22.0, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 75),
                          child: new SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              onPressed: () {
                                sum();
                              },
                              textColor: Colors.blue,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0))),
                              elevation: 15,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: new Text(
                                  "Parsec Details",
                                  style: new TextStyle(
                                    fontSize: 22.0,
                                  ),
                                ),
                              ),
                            ),
                            // ],
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0, bottom: 10.0),
                          child: new Text(
                            "Differnt Events",
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
                              itemCount: _eventList.length,
                              itemBuilder: (_, index) {
                                return PostUI(
                                  _eventList[index].imageURL,
                                  _eventList[index].description,
                                  _eventList[index].event_name,
                                  
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
