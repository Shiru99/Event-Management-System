import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class ParsecDetails extends StatefulWidget {
  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  ParsecDetails(this._user, this._postgresKonnection);

  @override
  _ParsecDetailsState createState() => _ParsecDetailsState();
}

class _ParsecDetailsState extends State<ParsecDetails> {
  var results;
  bool _isLoading = true;

  // PostgresKonnection _postgresConnection = _postgresKonnection;
  Future fun() async {
    PostgreSQLConnection _konnection =
        await widget._postgresKonnection.getKonnection();
    results = await _konnection.query('select * from fest');
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
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: new Text(
                              results[0][1].toString(),
                              style: new TextStyle(
                                  fontSize: 22.0, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: new Text(
                              results[0][2].toString(),
                              style: new TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: new Text(
                              results[0][3].toString(),
                              style: new TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: new Text(
                              results[0][4].toString(),
                              style: new TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: new Text(
                              results[0][0].toString(),
                              style: new TextStyle(
                                  fontSize: 18.0, color: Colors.white),
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
