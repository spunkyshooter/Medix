import 'package:firebase_auth/firebase_auth.dart';

//create a class for this service
class AuthService {
  //first create instance of the FireBase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //useful for persistence case.
  //FireBase internally maintains sharedPreferences;
  Future<FirebaseUser> get getUser async {
    return await _auth.currentUser();
  }

  //Setting up Stream which listens to auth State Changes.
  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  //sign in with email and password
  Future<Map<String, dynamic>> signInWithEmailAndPass(email, password) async {
    Map<String, dynamic> data = {"success": false, "user": null};
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      data["success"] = true;
      data["user"] = user;
    } catch (error) {
      String errorMessage = "";
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      data["error"] = errorMessage;
    }
    return data;
  }
//register with email and password

//signout
}
