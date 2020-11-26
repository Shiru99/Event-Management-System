
import 'package:EventManager/Widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {


  TextEditingController _email = new TextEditingController();
  bool isSignedIn = false;

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return buildHomeScreen();
    } else {
      return buildSignInScreen();
    }
  }

  Widget buildHomeScreen() {
    return Text("Already SignedIn");
  }

  Scaffold buildSignInScreen() {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child:Container(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                
                  Padding(
                    padding: const EdgeInsets.only(top: 150.0),
                    child: logo(90,280),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,bottom: 50.0),
                    child: Text(
                        " A Paradigm  Shift  💫", // 💫🌠
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontFamily: "Signatra"),
                      ),
                  ),
                  

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 45.0),
                    child: new TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: textInputDecoration("Email"," john.doe@gmail.com"),
                      
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                      controller: _email,
                      validator: (email) {
                        if (email.isEmpty) {
                          return 'Please enter some text';
                        }
                        return EmailValidator.validate(email)
                            ? null
                            : "Invalid email address";
                      },
                      onSaved: (value) {
                        return _email.text = value;
                      }),
                  ),

                
                
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 75),
                  child: new SizedBox(
                    
                    width: 280.0,
                    height: 45.0,
                    child: 
                    RaisedButton(
                              onPressed: () {},
                              textColor: Colors.white,
                              color: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(50.0))
                              ),
                              elevation: 15,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: new Text(
                                  "Reset Password",
                                  style: new TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                      ),
                    // ],
                  ),
                ),
                
               

                  
                   
                 
                  
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Text(
                      "from  Team : G-10",
                      style: TextStyle(
                        fontSize: 32.0,
                        color: Colors.white,
                        fontFamily: "Signatra",
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
  }
}
