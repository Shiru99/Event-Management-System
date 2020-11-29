import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Classes/EventInfo.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

// ignore: camel_case_types
class eventScoreCard extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  String event_ID;
  eventScoreCard(this._user, this._postgresKonnection, this.event_ID);
  @override
  _eventScoreCardState createState() => _eventScoreCardState();
}

// ignore: camel_case_types
class _eventScoreCardState extends State<eventScoreCard> {
  String event_id;

  bool _isLoading = true;
  List<EventInfo> _eventList = [];
  List<EventInfo> _groupList = [];

  List results;
  List groupresults;

  Future runQuery() async {
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();

    print(_konnection);
    event_id = widget.event_ID;

    print(
        "select * from individual_participant,participant where individual_participant.participant_id=participant.participant_id AND individual_participant.event_id= '$event_id'");
    results = await _konnection.query(
        "select * from individual_participant,participant where individual_participant.participant_id=participant.participant_id AND individual_participant.event_id= '$event_id'");

    groupresults = await _konnection.query(
        "select DISTINCT group_id, group_name,score,review from group_participant where event_id= '$event_id'");
    _eventList.clear();

    for (int i = 0; i < results.length; i++) {
      EventInfo _eventInfo = new EventInfo();

      _eventInfo.participant_id = results[i][0];
      _eventInfo.participant_name = results[i][5];
      _eventInfo.score = results[i][2];
      _eventInfo.review = results[i][3];
      _eventList.add(_eventInfo);
    }
    _groupList.clear();
    for (int i = 0; i < groupresults.length; i++) {
      EventInfo _groupinfo = new EventInfo();
      _groupinfo.group_id = groupresults[i][0];
      _groupinfo.group_name = groupresults[i][1];
      _groupinfo.score = groupresults[i][2];
      _groupinfo.review = groupresults[i][3];
      _groupList.add(_groupinfo);
    }

    print(_eventList);
    print(_eventList.length);

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
                            "Scorecard",
                            style: new TextStyle(
                                fontSize: 22.0, color: Colors.white),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       vertical: 20.0, horizontal: 75),
                        //   child: new SizedBox(
                        //     width: MediaQuery.of(context).size.width,
                        //     child: RaisedButton(
                        //       onPressed: () {
                        //         sum();
                        //       },
                        //       textColor: Colors.blue,
                        //       color: Colors.white,
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(50.0))),
                        //       elevation: 15,
                        //       child: Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(vertical: 10.0),
                        //         child: new Text(
                        //           "Parsec Details",
                        //           style: new TextStyle(
                        //             fontSize: 22.0,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     // ],
                        //   ),
                        // ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 50.0, bottom: 10.0),
                          child: new Text(
                            "Individual participant scorecard",
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
                                  context,
                                  widget._user,
                                  widget._postgresKonnection,
                                  _eventList[index].participant_id,
                                  _eventList[index].participant_name,
                                  _eventList[index].score,
                                  _eventList[index].review,
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 50.0, bottom: 10.0),
                          child: new Text(
                            "Group participant scorecard",
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
                              itemCount: _groupList.length,
                              itemBuilder: (_, index) {
                                return PostUIgroup(
                                  context,
                                  widget._user,
                                  widget._postgresKonnection,
                                  _groupList[index].group_id,
                                  _groupList[index].group_name,
                                  _groupList[index].score,
                                  _groupList[index].review,
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
    String participant_id,
    String participant_name,
    String score,
    String review) {
  // Future goToEvent() async {
  //   await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //               eventScoreCard(_user, _postgresKonnection, event_ID)));
  // }

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
                new Text(
                  participant_name,
                  // style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                  // style: TextStyle(
                  //   color: Colors.white,
                  // ),
                ),
                // new Text(
                //   "time",
                //   // style: Theme.of(context).textTheme.subtitle2,
                //   textAlign: TextAlign.center,
                //   // style: TextStyle(
                //   //   color: Colors.white,
                //   // ),
                // )
              ],
            ),
            // SizedBox(
            //   height: 10.0,
            // ),
            // new Image.network(
            //   image,
            //   fit: BoxFit.cover,
            // ),
            SizedBox(
              height: 10.0,
            ),
            new Text(
              score,
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
              review,
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

Widget PostUIgroup(
    BuildContext context,
    SaveUser _user,
    PostgresKonnection _postgresKonnection,
    String group_id,
    String group_name,
    String score,
    String review) {
  // Future goToEvent() async {
  //   await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //               eventScoreCard(_user, _postgresKonnection, event_ID)));
  // }

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
                new Text(
                  group_name,
                  // style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                  // style: TextStyle(
                  //   color: Colors.white,
                  // ),
                ),
                // new Text(
                //   "time",
                //   // style: Theme.of(context).textTheme.subtitle2,
                //   textAlign: TextAlign.center,
                //   // style: TextStyle(
                //   //   color: Colors.white,
                //   // ),
                // )
              ],
            ),
            // SizedBox(
            //   height: 10.0,
            // ),
            // new Image.network(
            //   image,
            //   fit: BoxFit.cover,
            // ),
            SizedBox(
              height: 10.0,
            ),
            new Text(
              score,
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
              review,
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
