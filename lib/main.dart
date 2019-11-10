import 'dart:async';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  //my code
  final FirebaseAuth _authInstance = FirebaseAuth.instance;
  //end my code

  Future<FirebaseUser> firebaseAuthWithFacebook({@required FacebookAccessToken token}) async {

    AuthCredential credential= FacebookAuthProvider.getCredential(accessToken: token.token);
    AuthResult authResult = await _authInstance.signInWithCredential(credential);
    return authResult.user;
  }
  
    

  Future<Null> _signOut(BuildContext context) async {
    await facebookSignIn.logOut();
    Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text('Sign out button clicked'),
        ));
    print('Signed out');
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Fb Sign In with Firebase'),
        ),
        body: new Builder(
          builder: (BuildContext context) {
            return new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new MaterialButton(
                    //padding: new EdgeInsets.all(16.0),
                    minWidth: 150.0,
                    onPressed: () async {
                      final FacebookLoginResult facebookLoginResult = await facebookSignIn.logInWithReadPermissions(['email', 'public_profile']);

                        switch (facebookLoginResult.status) {
                          case FacebookLoginStatus.error:
                            print("Error");
                            break;

                          case FacebookLoginStatus.cancelledByUser:
                            print("CancelledByUser");
                            break;

                          case FacebookLoginStatus.loggedIn:
                            print("LoggedIn");
                            /// calling the auth mehtod and getting the logged user
                            var firebaseUser = await firebaseAuthWithFacebook(
                                token: facebookLoginResult.accessToken);
                            print(firebaseUser);
                        }
                    },
                    child: new Text('Sign in with Facebook'),
                    color: Colors.lightBlueAccent,
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(5.0),
                  ),
                  new MaterialButton(
                    minWidth: 150.0,
                    onPressed: () => _signOut(context),
                    child: new Text('Sign Out'),
                    color: Colors.lightBlueAccent,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class UserInfoDetails {
  UserInfoDetails(this.providerId, this.uid, this.displayName, this.photoUrl,
      this.email, this.isAnonymous, this.isEmailVerified, this.providerData);

  /// The provider identifier.
  final String providerId;

  /// The provider’s user ID for the user.
  final String uid;

  /// The name of the user.
  final String displayName;

  /// The URL of the user’s profile photo.
  final String photoUrl;

  /// The user’s email address.
  final String email;

  // Check anonymous
  final bool isAnonymous;

  //Check if email is verified
  final bool isEmailVerified;

  //Provider Data
  final List<ProviderDetails> providerData;
}

class ProviderDetails {
  final String providerId;

  final String uid;

  final String displayName;

  final String photoUrl;

  final String email;

  ProviderDetails(
      this.providerId, this.uid, this.displayName, this.photoUrl, this.email);
}

class DetailedScreen extends StatelessWidget {
  final UserInfoDetails detailsUser;

  // DetailScreen({
  //   Key key,
  //   this.name}) : super(key: key);

  DetailedScreen({Key key, @required this.detailsUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Fb Sign In Details'),
          automaticallyImplyLeading: false,
        ),
        body: new Container(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              new Text(
                "Name : " + detailsUser.displayName,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1.2,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              new Padding(
                padding: new EdgeInsets.all(5.0),
              ),
              new Text(
                "Email : " + detailsUser.email,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1.2,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              new Padding(
                padding: new EdgeInsets.all(5.0),
              ),
              new Text(
                "isAnonymous : " + detailsUser.isAnonymous.toString(),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1.2,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              new Padding(
                padding: new EdgeInsets.all(5.0),
              ),
              new Text(
                "isEmailVerified : " + detailsUser.isEmailVerified.toString(),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1.2,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              new Padding(
                padding: new EdgeInsets.all(5.0),
              ),
              new Text(
                "Photo URL : " + detailsUser.photoUrl,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1.2,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              new Padding(
                padding: new EdgeInsets.all(5.0),
              ),
              new Text(
                "Provider ID : " + detailsUser.providerId,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1.2,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              new Padding(
                padding: new EdgeInsets.all(5.0),
              ),
              new Text(
                "UiD : " + detailsUser.uid,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1.2,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              new Padding(
                padding: new EdgeInsets.all(5.0),
              ),
              new Text(
                "Fb provider data : " +
                    detailsUser.providerData[0].displayName +
                    " : " +
                    detailsUser.providerData[0].uid,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: 1.2,
                style: new TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.brown),
              ),
              new Padding(padding: const EdgeInsets.all(10.0)),
              new Image.network(
                detailsUser.photoUrl,
                colorBlendMode: BlendMode.dstIn,
              )
            ],
          ),
        ));
  }
}