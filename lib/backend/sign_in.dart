import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'GoogleHttpClient.dart';

// this file has all the authentication backend stuff,
// don't need to import anything from here

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

  final authHeaders = await googleSignIn.currentUser.authHeaders;
  // custom IOClient from below
  final httpClient = GoogleHttpClient(authHeaders);

  var data = await CalendarApi(httpClient).calendarList.list();
  print("come on babeyyy");
      print(data.items);
      data.items.forEach((element) {
        var calendarSummary = element.summaryOverride;
        if (element.summaryOverride == null){
          calendarSummary = element.summary;
        }
        print(calendarSummary);
      });


  final UserCredential authResult = await auth.signInWithCredential(credential);
  final User user = authResult.user;

  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

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