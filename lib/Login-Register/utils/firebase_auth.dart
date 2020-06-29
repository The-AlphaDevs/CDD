//11 June 2020
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fire_auth/globals.dart' as globals;

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void checkHistoryStatus(String emailID) {
    var userQuery = Firestore.instance
        .collection('users')
        .document(emailID)
        .collection('History')
        .orderBy('Time', descending: true);

    userQuery.getDocuments().then((data) {
      if (data.documents.length > 0) {
        globals.hasHistory = true;
      } else {
        globals.hasHistory = false;
      }
    });
  }

  Future<bool> signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      if (user != null)
        return true;
      else
        return false;
    } catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("error logging out");
    }
  }

  Future<bool> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) return false;
      AuthResult res =
          await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      if (res.user == null) return false;
      final snapshot = await Firestore.instance
          .collection('users')
          .document(res.user.email)
          .get();
      if (snapshot == null || !snapshot.exists) {
        // Document with id == docId doesn't exist.
        Firestore.instance
            .collection('users')
            .document(res.user.email)
            .setData({
          'email': res.user.email,
          'displayName': res.user.displayName,
          'mobile_number': 'Enter Mobile Number',
          'state': 'Enter City',
        });
      }
      // if (temp == null) {
      //   Firestore.instance.collection('users').document(res.user.email).setData(
      //       {'email': res.user.email, 'displayName': res.user.displayName});
      // }
      print("inserted in firestore from res.user!");
      checkHistoryStatus(res.user.email);

      return true;
    } catch (e) {
      print(e.message);
      print("Error logging with google");
      return false;
    }
  }
}
