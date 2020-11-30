import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Classes/EventInfo.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class AdminListRegisteredStudents extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  AdminListRegisteredStudents(this._user, this._postgresKonnection);
  @override
  _AdminListRegisteredStudentsState createState() =>
      _AdminListRegisteredStudentsState();
}

class _AdminListRegisteredStudentsState
    extends State<AdminListRegisteredStudents> {
  bool _isLoading = true;
  List<EventInfo> _participantList = [];

  List results;

  Future runQuery() async {
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();

    print(_konnection);

    results = await _konnection.query('select * from participant');
    print(results);

    print(results.length);

    _participantList.clear();

    for (int i = 0; i < results.length; i++) {
      EventInfo _participantInfo = new EventInfo();

      _participantInfo.participantId = results[i][0];
      _participantInfo.participantName = results[i][1];
      _participantInfo.participantCno = results[i][2];
      _participantInfo.participantEmail = results[i][3];

      _participantList.add(_participantInfo);
    }

    print(_participantList);
    print(_participantList.length);

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
                            "Registed student detailed list",
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
                              itemCount: _participantList.length,
                              itemBuilder: (_, index) {
                                return PostUI(
                                  context,
                                  widget._user,
                                  widget._postgresKonnection,
                                  _participantList[index].participantId,
                                  _participantList[index].participantName,
                                  _participantList[index].participantCno,
                                  _participantList[index].participantEmail,
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
    String participantId,
    String participantName,
    String participantCno,
    String participantEmail) {
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
      child: new Container(
        color: Colors.white,
        padding: new EdgeInsets.all(25.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[],
            ),
            SizedBox(
              height: 10.0,
            ),
            new Text(
              "STUDENT ID:",
              // style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
              // style: TextStyle(
              //   color: Colors.white,
              // ),
            ),
            new Text(
              participantId,
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
            new Text(
              "STUDENT NAME:",
              // style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
              // style: TextStyle(
              //   color: Colors.white,
              // ),
            ),
            new Text(
              participantName,
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
            new Text(
              "STUDENT CONTACT NUMBER:",
              // style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
              // style: TextStyle(
              //   color: Colors.white,
              // ),
            ),
            new Text(
              participantCno,
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
            new Text(
              "STUDENT EMAIL:",
              // style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
              // style: TextStyle(
              //   color: Colors.white,
              // ),
            ),
            new Text(
              participantEmail,
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
