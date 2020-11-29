import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  SaveUser _user;
  HomePage(this._user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


    int port = 5432;
    String hostURL = "ec2-34-232-24-202.compute-1.amazonaws.com";
    String databaseName = "djb7v0o318g55";
    String userName = "oofplrsgbytwdc";
    String password = "b72bf90efb5e5f52b3c22146e1180e36d03a87f7ef5f76f8025733511e663583";

    PostgresKonnection _postgresKonnection = new PostgresKonnection();



  Future operation() async {

    await _postgresKonnection.setKonnection( hostURL, port, databaseName, userName, password);
    

    PostgreSQLConnection _konnection = await _postgresKonnection.getKonnection();

    print(_konnection);

    var results = await _konnection.query('select * from book');
    print(results);

    // await _postgresKonnection.closeKonnection();

    
  }

  
  List<Posts> postList = [];
  
    
  
    @override
    Widget build(BuildContext context) {
  
      operation();
  
      return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        appBar: appBarMain(context),
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 150.0, bottom: 10.0),
                        //   child: logo(90, 280),
                        // ),
  
                        new ListView.builder(
                        itemCount: postList.length,
                        itemBuilder: (_, index) {
                          // return PostUI(
                          //     postList[index].image,
                          //     postList[index].description,
                          //     postList[index].date,
                          //     postList[index].time);
                        },
                      ),
  
                        Container(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 60.0, vertical: 10),
                            child: Text(
                              " A Paradigm  Shift  💫", // 💫🌠
                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                  fontFamily: "Signatra"),
                            ),
                          ),
                        ),
  
                        Container(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70.0, vertical: 10),
                            child: Text(
                              "14th-16th Feb, 2020", // 💫🌠
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic // "Signatra"
                                  ),
                            ),
                          ),
                        ),
  
                        Container(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70.0, vertical: 10),
                            child: Text(
                              widget._user.email,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic // "Signatra"
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      );
    }
  }
  
  class Posts {
}
