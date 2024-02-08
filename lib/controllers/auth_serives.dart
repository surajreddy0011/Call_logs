import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_core/firebase_core.dart';

class AuthService {
  //creating new account using email and password method.
  Future<String> createAccountWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return "Account Created";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  //login with email password method
  Future<String> loginWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Login Successful";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  //logout the user
  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }

  //check whether the user is sign in or not
  Future<bool> isLoggedIn() async {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  // for google login
  Future ContinueWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      //send the authentication request
      final GoogleSignInAuthentication gAuth = await googleUser!.authentication;

      //obtain a new creditional
      final creds = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);

      //sign in with credentials
      await FirebaseAuth.instance.signInWithCredential(creds);
      return "Google Login Successful";
    } on FirebaseAuthException catch (e) {
      e.message.toString();
    }
  }
}
