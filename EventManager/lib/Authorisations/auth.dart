import 'package:EventManager/Authorisations/SaveUser.dart';
import 'package:EventManager/Widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthorisationMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

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
    return _user != null
        ? SaveUser(
            userID: _user.uid,
            displayName: _user.displayName,
            email: _user.email,
            phoneNumber: _user.phoneNumber)
        : null;
  }

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      return return_firebase_user(authResult.user);
    } catch (error) {
      print(error.toString());
      String errorMessage;
      print(error.code);

      switch (error.code) {
        case "email-already-in-use":
          errorMessage =
              "The email address is already in use by another account.";
          break;
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "network-request-failed":
        case "network_error":
          errorMessage = "Check internet connection";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      toastMessage(errorMessage);
    }
  }

  Future signInWithGmailAndPassword(String _email, String _password) async {
    try {
      User _firebaseUser = (await _auth.signInWithEmailAndPassword(
              email: _email, password: _password))
          .user;
      return return_firebase_user(_firebaseUser);
    } catch (error) {
      print(error.toString());
      String errorMessage;
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage =
              "Your password is wrong OR\nThis account use Google SignIn.";
          break;
        case "email-already-in-use":
          errorMessage =
              "The email address is already in use by another account.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "network-request-failed":
        case "network_error":
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
              email: _email, password: _password))
          .user;
      return return_firebase_user(_firebaseUser);
    } catch (error) {
      print(error.toString());
      String errorMessage;
      print(error.code);

      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "email-already-in-use":
          errorMessage =
              "The email address is already in use by another account.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "network-request-failed":
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
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "email-already-in-use":
          errorMessage =
              "The email address is already in use by another account.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "network-request-failed":
        case "network_error":
          errorMessage = "Check internet connection";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      toastMessage(errorMessage);
    }
  }

//   Future<void> resetPassword(String email) async {
//       await _firebaseAuth.sendPasswordResetEmail(email: email);
// }
  Future<void> sendResetPasswordEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      toastMessage("A password reset link has been sent to $email");
    } catch (error) {
      print(error.toString());
      String errorMessage;
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "email-already-in-use":
          errorMessage =
              "The email address is already in use by another account.";
          break;
        case "user-not-found":
          errorMessage =
              "There is no user record corresponding to this identifier. The user may have been deleted.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "network-request-failed":
        case "network_error":
          errorMessage = "Check internet connection";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      toastMessage(errorMessage);
    }
  }

  Future<void> signOutGoogle() async {
    try {
      await googleSignIn.signOut();
      print("signout from google");
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      signOutGoogle();

      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      String errorMessage;
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "email-already-in-use":
          errorMessage =
              "The email address is already in use by another account.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        case "network-request-failed":
        case "network_error":
          errorMessage = "Check internet connection";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      toastMessage(errorMessage);
    }
  }
}
