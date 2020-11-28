import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Pages/ParsecDetails.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class FestDetails extends StatefulWidget {
  SaveUser _user;
  FestDetails(this._user);

  @override
  _FestDetailsState createState() => _FestDetailsState();
}

class _FestDetailsState extends State<FestDetails> {

  var results;

  int port = 5432;
  String hostURL = "ec2-34-232-24-202.compute-1.amazonaws.com";
  String databaseName = "djb7v0o318g55";
  String userName = "oofplrsgbytwdc";
  String password =
      "b72bf90efb5e5f52b3c22146e1180e36d03a87f7ef5f76f8025733511e663583";

  PostgresKonnection _postgresKonnection = new PostgresKonnection();

  Future operation() async {
    await _postgresKonnection.setKonnection(
        hostURL, port, databaseName, userName, password);

    PostgreSQLConnection _konnection =
        await _postgresKonnection.getKonnection();

    print(_konnection);

    results = await _konnection.query('select * from book');
    print(results);

    // await _postgresKonnection.closeKonnection();
  }

  @override
  Widget build(BuildContext context) {

    operation();

    sum() {
      Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => 
              //  Details()
              // HomePage(_user)
              ParsecDetails(widget._user,_postgresKonnection)
              ));
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
                      padding: const EdgeInsets.symmetric(vertical: 50.0),
                      child: new Text(
                        "All Details about Parsec & Sub-Events",
                        style:
                            new TextStyle(fontSize: 22.0, color: Colors.white),
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
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 75),
                      child: new SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {},
                          textColor: Colors.blue,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: new Text(
                              " sub Event 1",
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 75),
                      child: new SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {},
                          textColor: Colors.blue,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: new Text(
                              " sub Event 2 ",
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 75),
                      child: new SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {},
                          textColor: Colors.blue,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: new Text(
                              " sub Event 4 ",
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 75),
                      child: new SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          onPressed: () {},
                          textColor: Colors.blue,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          elevation: 15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: new Text(
                              " sub Event 1",
                              style: new TextStyle(
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                        ),
                        // ],
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
