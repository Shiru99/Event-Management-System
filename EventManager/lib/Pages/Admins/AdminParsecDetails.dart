import 'package:EventManager/Widgets/widgets.dart';
import 'package:flutter/material.dart';

class AdminParsecDetails extends StatefulWidget {
  @override
  _AdminParsecDetailsState createState() => _AdminParsecDetailsState();
}

class _AdminParsecDetailsState extends State<AdminParsecDetails> {
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
                              "Update Parsec Details by Admin ",
                              style: new TextStyle(
                                fontSize: 22.0,
                                color: Colors.white
                              ),
                            ),
                          ),
                    

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      child: new TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration:
                            textInputDecoration("Detail 0 ", " john.doe@gmail.com"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      child: new TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration:
                            textInputDecoration("Details 1", " john.doe@gmail.com"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                      ),
                    ),
                    
                    

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      child: new TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration:
                            textInputDecoration("Details 2", " john.doe@gmail.com"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 5.0),
                      child: new TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration:
                            textInputDecoration("Details 3", " john.doe@gmail.com"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).nextFocus(),
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
                              " Update ",
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