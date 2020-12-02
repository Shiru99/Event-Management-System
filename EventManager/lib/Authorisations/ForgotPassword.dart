import 'package:EventManager/Authorisations/auth.dart';
import 'package:EventManager/Authorisations/authenticate.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _resetPasswordFormKey = GlobalKey<FormState>();

  AuthorisationMethods _authorisationMethods = new AuthorisationMethods();

  TextEditingController _email = new TextEditingController();

  bool _isLoading = false;

  reset() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildSignInScreen();
  }

  resetPassword() async {
    setState(() {
      _isLoading = true;
    });

    if (_resetPasswordFormKey.currentState.validate()) {
      try {
        await _authorisationMethods.sendResetPasswordEmail(_email.text);
      } catch (e) {
        print(e.toString());
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => authenticate()));
    }
  }

  Scaffold buildSignInScreen() {
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
                            key: _resetPasswordFormKey,
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
                                      autofocus: true,
                                      textInputAction: TextInputAction.done,
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
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 75, vertical: 20),
                            child: Container(
                              alignment: Alignment.center,
                              child: Container(
                                  child: Column(
                                children: [
                                  Text(
                                    "Please ensure",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 20,
                                      // fontStyle: FontStyle.italic
                                    ),
                                  ),
                                  Text(
                                    "Password Size 8 - characters &",
                                    style: TextStyle(
                                        color: Colors.white38,
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  Text(
                                    "Format : a-z + A-Z + 0-9 + !@#\$&*~",
                                    style: TextStyle(
                                        color: Colors.white38,
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 75),
                            child: new SizedBox(
                              width: 280.0,
                              height: 45.0,
                              child: RaisedButton(
                                onPressed: () {
                                  resetPassword();
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
