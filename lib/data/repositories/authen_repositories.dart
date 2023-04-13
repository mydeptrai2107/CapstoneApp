import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenRepositories {
  //final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  Future signIn() async {
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return;
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    //UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
