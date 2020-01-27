import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  final firestore = Firestore.instance;

  Future<FirebaseUser> signInWithGoogle() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final AuthResult authResult = await auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;
    if (user != null) {
      if (firestore.collection('/users').document(user.uid) == null) {
        firestore.collection('/users').document(user.uid).setData({
          'count': Map(),
        });
      }
    }
    return user;
  }

  Future<FirebaseUser> currentUser() {
    return auth.currentUser();
  }

  Future<void> logOutGoogle() async {
    auth.signOut();
  }
}

Auth auth = Auth();
