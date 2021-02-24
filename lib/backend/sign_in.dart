import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:zotivity/backend/GoogleHttpClient.dart';
import 'globals.dart';

// this file has all the authentication backend stuff,
// don't need to import anything from here
// sources:
// https://stackoverflow.com/questions/48477625/how-to-use-google-api-in-flutter/48485898#48485898

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: [
    'https://www.googleapis.com/auth/calendar'
  ]
);



Future<User> initAuthFirebase() async {
  await Firebase.initializeApp();
  return getCurrentUser();
}

Future<User> signInWithGoogle() async {

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final _authHeaders = await googleSignIn.currentUser.authHeaders;
  // custom IOClient from other file
  httpClient = GoogleHttpClient(_authHeaders);

  final UserCredential authResult = await auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded');
    return user;
  }

  return null;
}

User getCurrentUser(){
  return auth.currentUser;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  await auth.signOut();

  print("User Signed Out");
}

