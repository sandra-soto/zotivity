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
  httpClient = GoogleHttpClient(_authHeaders);
  // custom IOClient from below

  var data = await CalendarApi(httpClient).calendarList.list();
  print("CALENDARS");
  print(data.items);
  data.items.forEach((element) {
    var calendarSummary = element.summaryOverride;
    if (element.summaryOverride == null){
      calendarSummary = element.summary;
    }
    print(calendarSummary);
    print(element.id);

  });

  print("??????????????????????????????");
  print((new DateTime.now()).add(new Duration(days: 7)).toString());
  var wdw = {
    "timeMin": "${(new DateTime.now().toUtc())}",
    "timeMax": "${((new DateTime.now()).add(new Duration(days:3))).toUtc()}",
  "timeZone": "UTC",
    "items": [
      {
        "id": "sandra041909@gmail.com"
      }
    ]
  };
  try{
    var freeBusyData = await CalendarApi(httpClient).freebusy.query(FreeBusyRequest.fromJson(wdw));
    print(freeBusyData.toJson());
  }
  catch(err){
    print(err);
  }


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

class GoogleApiRequest {
  var _authHeaders;
  GoogleHttpClient _httpClient;

  GoogleApiRequest() ;
  // constructor
  GoogleApiRequest.init(authHeaders) {
    _authHeaders = authHeaders;
    _httpClient = GoogleHttpClient(_authHeaders);
  }
  get httpClient{
    return _httpClient;
  }

  set authHeaders(authHeaders){
    _authHeaders = authHeaders;
    _httpClient = GoogleHttpClient(_authHeaders);
  }

  Future<void> cal() async {
    var data = await CalendarApi(this._httpClient).calendarList.list();
    print("come on babeyyy");
    print(data.items);
    data.items.forEach((element) {
      var calendarSummary = element.summaryOverride;
      if (element.summaryOverride == null){
        calendarSummary = element.summary;
      }
      print(calendarSummary);
    });
  }
}

User getCurrentUser(){
  return auth.currentUser;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  await auth.signOut();

  print("User Signed Out");
}

