import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';

class ParsecDetails extends StatefulWidget {

  PostgresKonnection _postgresKonnection;
  SaveUser _user;
  ParsecDetails(this._user,this._postgresKonnection);
  
  @override
  _ParsecDetailsState createState() => _ParsecDetailsState();
}

class _ParsecDetailsState extends State<ParsecDetails> {
  @override
  Widget build(BuildContext context) {
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
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: new Text(
                              " Parsec Details ",
                              style: new TextStyle(
                                fontSize: 22.0,
                                color: Colors.white
                              ),
                            ),
                          ),
                    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: new Text(
                              " Details 1",
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white
                              ),
                            ),
                          ),
                    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: new Text(
                              " Details 2",
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white
                              ),
                            ),
                          ),
                    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: new Text(
                              " Details 3",
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white
                              ),
                            ),
                          ),
                    Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50.0),
                            child: new Text(
                              " Details 4",
                              style: new TextStyle(
                                fontSize: 18.0,
                                color: Colors.white
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
