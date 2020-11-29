import 'package:EventManager/Authorisations/auth.dart';
import 'package:EventManager/Authorisations/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animations/loading_animations.dart';

void toastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      fontSize: 16.0);
}

Container loading() {
  return Container(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          logo(90, 280),
          SizedBox(height: 45),
          LoadingBouncingGrid.circle(
            borderColor: Colors.black,
            borderSize: 9.0,
            size: 60.0,
            backgroundColor: Colors.white,
            duration: Duration(milliseconds: 1000),
          )
        ],
      ),
    ),
  );
}

Widget logo(double h, double w) {
  return new Hero(
    tag: 'hero',
    child: Container(
      // alignment: Alignment.center,
      width: w,
      height: h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/logo.png"),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

InputDecoration textInputDecoration(String labalText, String hintText) {
  return InputDecoration(
    labelText: labalText,
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.white38,
    ),
    labelStyle: TextStyle(
      color: Colors.white,
    ),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
      color: Colors.white,
    )),
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
      color: Colors.white,
    )),
  );
}

class DialogBox {
  informtion(BuildContext context, String title, String description) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    return Navigator.pop(context);
                  },
                  child: Text("Ok"))
            ],
          );
        });
  }
}

Widget PostUI(String image, String description, String date) {
  return SingleChildScrollView(
    child: new Card(
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
        side: BorderSide( color: Colors.black, width: 1.0,),
      ),
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
                  date,
                  // style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                  // style: TextStyle(
                  //   color: Colors.white,
                  // ),
                ),
                new Text(
                  "time",
                  // style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                  // style: TextStyle(
                  //   color: Colors.white,
                  // ),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                print("clicked on Image");
              },
              child: new Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10.0,
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
              // child:Colors.black,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget appBarMain(BuildContext context) {
  AuthorisationMethods _authorisationMethods = new AuthorisationMethods();
  return AppBar(
      backgroundColor: Colors.black,
      toolbarHeight: 40,
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            logo(30, 100),
            Text(
              "A  Paradigm  Shift  💫", // 💫🌠
              style: TextStyle(
                  fontSize: 20.0, color: Colors.white, fontFamily: "Signatra"),
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _authorisationMethods.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => authenticate()));
                toastMessage("Signed-out successfully");
              },
              color: Colors.white,
              hoverColor: Colors.blueAccent,
            ),
          ])

      // logo(30,100),

      );
}
