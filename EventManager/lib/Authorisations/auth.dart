import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthorisationMethods {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();

  Future getCurrentUser() async {
    final User _user = _auth.currentUser;
    final uid = _user.uid;
    // _user.displayName;
    // _user.email;
    // _user.phoneNumber;
    // _user.photoUrl;
    print(uid);
    return _user;
  }

   // ignore: non_constant_identifier_names
   SaveUser return_firebase_user(User _user) {
    return _user != null ? SaveUser(userID: _user.uid,displayName:_user.displayName,email: _user.email,phoneNumber: _user.phoneNumber) : null;
  }

 

  Future signInWithGmailAndPassword(String _email, String _password) async {
    try {
    
      User _firebaseUser =  (await _auth.signInWithEmailAndPassword( email: _email, password: _password)).user;
      return return_firebase_user(_firebaseUser);
    } catch (error) {
      print(error.toString());
      String errorMessage;
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "ERROR_NETWORK_REQUEST_FAILED":
          errorMessage = "Check internet connection";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      toastMessage(errorMessage);

    }
  }

  Future signUpWithGmailAndPassword(String _email, String _password) async {
    try {
      User _firebaseUser = (await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password)).user;
      return return_firebase_user(_firebaseUser);
    } catch (error) {
      print(error.toString());
      String errorMessage;
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          errorMessage = "this email is already in use. Try sign in.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "ERROR_NETWORK_REQUEST_FAILED":
          errorMessage = "Check internet connection";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      toastMessage(errorMessage);
    }
  }

  Future resetPassword(String _email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: _email);
    } catch (error) {
      print(error.toString());
      String errorMessage;
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "ERROR_NETWORK_REQUEST_FAILED":
          errorMessage = "Check internet connection";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      toastMessage(errorMessage);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      String errorMessage;
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "ERROR_NETWORK_REQUEST_FAILED":
          errorMessage = "Check internet connection";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      toastMessage(errorMessage);
    }
  }
}
