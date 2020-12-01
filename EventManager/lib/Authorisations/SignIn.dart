import 'package:EventManager/Authorisations/ForgotPassword.dart';
import 'package:EventManager/Authorisations/PostgresKonnection.dart';
import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Authorisations/auth.dart';
import 'package:EventManager/Pages/Admins/AdminDetails.dart';
import 'package:EventManager/Pages/FestDetails.dart';
import 'package:EventManager/Pages/ScoreCard.dart';
import 'package:EventManager/Welcome/HomePage.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _signInFormKey = GlobalKey<FormState>();
  SaveUser _user;

  AuthorisationMethods _authorisationMethods = new AuthorisationMethods();

  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  bool _passwordVisible = false;
  bool _isLoading = false;

  reset() {
    setState(() {
      _isLoading = true;
    });
  }

  resetPassword() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgotPassword()));
    // toastMessage("Reset Password");
  }

  // List results;

  int port = 5432;
  String hostURL = "ec2-34-232-24-202.compute-1.amazonaws.com";
  String databaseName = "djb7v0o318g55";
  String userName = "oofplrsgbytwdc";
  String password =
      "b72bf90efb5e5f52b3c22146e1180e36d03a87f7ef5f76f8025733511e663583";

  PostgresKonnection _postgresKonnection = new PostgresKonnection();

  Future createKonnection() async {
    await _postgresKonnection.setKonnection(
        hostURL, port, databaseName, userName, password);
  }

  nextPage(String email) async {
    await createKonnection();

    PostgreSQLConnection _konnection =
        await _postgresKonnection.getKonnection();

    print(_konnection);

    var results = await _konnection.query('select admin_email from admino');
    var results1 =
        await _konnection.query('select invigilator_email from invigilator');

    bool isAdmin = false;
    bool isGuest = false;

    for (var result in results) {
      if (result[0] == _user.email) {
        isAdmin = true;
      }
    }

    for (var result in results1) {
      if (result[0] == _user.email) {
        isGuest = true;
      }
    }

    _isLoading = false;

    if (isAdmin) {
      print("Welcome, Admin");
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AdminDetails(_user, _postgresKonnection)));
    } else if (isGuest) {
      print("Welcome, Guest");
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FestDetails(_user, _postgresKonnection)));
    } else {
      print("Welcome, Participant");
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FestDetails(_user, _postgresKonnection)));
    }

    setState(() {
      _authorisationMethods.signOut();
      toastMessage("Signed-out successfully");
    });

    // print(_isLoading);
    // _isLoading = false;
    // print(_isLoading);
  }

  signingWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _authorisationMethods
          .signInWithGoogle()
          .then((value) => _user = value);

      if (_user == null) {
        reset();
      } else {
        print(_user.userID);
        // print(_user.displayName);    // null
        print(_user.email);
        // print(_user.photoUrl);       // null
        // print(_user.phoneNumber);    // null
        nextPage(_user.email);

        toastMessage("Successfully Signed-in with Google");
      }
    } catch (e) {
      toastMessage(e.toString());
      reset();
    }
  }

  signInTheUserGP() async {
    if (_signInFormKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _authorisationMethods
            .signInWithGmailAndPassword(_email.text, _password.text)
            .then((value) => _user = value);

        if (_user == null) {
          reset();
        } else {
          print(_user.userID);
          // print(_user.displayName);    // null
          print(_user.email);
          // print(_user.photoUrl);       // null
          // print(_user.phoneNumber);    // null
          nextPage(_user.email);

          toastMessage("Signed-in successfully");
        }
      } catch (e) {
        toastMessage(e.toString());
        reset();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      body: _isLoading
          ? loading()
          : SingleChildScrollView(
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
                          Padding(
                            padding: const EdgeInsets.only(top: 150.0),
                            child: logo(90, 280),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 50.0),
                            child: Text(
                              " A Paradigm  Shift  💫", // 💫🌠
                              style: TextStyle(
                                  fontSize: 30.0,
                                  color: Colors.white,
                                  fontFamily: "Signatra"),
                            ),
                          ),
                          Form(
                            key: _signInFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 5.0),
                                  child: new TextFormField(
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: textInputDecoration(
                                          "Email", " john.doe@gmail.com"),
                                      // autofocus: true,
                                      textInputAction: TextInputAction.next,
                                      // onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0, vertical: 5.0),
                                  child: new TextFormField(
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      obscureText: _passwordVisible,
                                      decoration: new InputDecoration(
                                        labelText: "Password",
                                        hintText:
                                            " a-z + A-Z + 0-9 + !@#\$&*~ ",
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _passwordVisible
                                                ? Icons
                                                    .visibility // Icons.lock,
                                                : Icons.visibility_off,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordVisible =
                                                  !_passwordVisible;
                                            });
                                          },
                                        ),
                                      ),
                                      textInputAction: TextInputAction.done,
                                      controller: _password,
                                      onFieldSubmitted: (_) =>
                                          FocusScope.of(context).unfocus(),
                                      validator: (password) {
                                        Pattern pattern =
                                            // r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                        RegExp regex = new RegExp(pattern);
                                        if (password.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        if (password.length < 8) {
                                          return 'atleast 8 charater';
                                        }
                                        if (!regex.hasMatch(password))
                                          return 'week password';
                                        else
                                          return null;
                                      },
                                      onSaved: (value) {
                                        return _password.text = value;
                                      }),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              resetPassword();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 50, bottom: 40),
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Text(
                                    "forgot password ?",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 75),
                            child: new SizedBox(
                              // width: MediaQuery.of(context).size.width,
                              width: 280.0,
                              height: 45.0,
                              child: RaisedButton(
                                onPressed: () {
                                  signInTheUserGP();
                                },
                                textColor: Colors.white,
                                color: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(50.0))),
                                elevation: 15,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: new Text(
                                    " Sign In ",
                                    style: new TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              // ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 75),
                            child: GestureDetector(
                              // onTap: () => "Button Tapped",
                              onTap: () {
                                signingWithGoogle();
                              },
                              child: Container(
                                width: 280.0,
                                height: 45.0,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0)),
                                  color: Colors.blue,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/btn_google_signin_dark_normal.png"),
                                    // fit: BoxFit.cover,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have Account? ",
                                  style: new TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.toggle();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "Create Account",
                                      style: new TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 50),
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
