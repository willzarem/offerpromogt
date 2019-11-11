import 'package:flutter/material.dart';
import 'package:offerpromogt/pages/home.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:offerpromogt/widgets/loading.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _loginScaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  static final FacebookLogin facebookSignIn = new FacebookLogin();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;

  String _message = 'Log in/out by pressing the buttons below.';

  Future<FirebaseUser> firebaseAuthWithFacebook(
      {@required FacebookAccessToken token}) async {
    AuthCredential credential =
        FacebookAuthProvider.getCredential(accessToken: token.token);
    AuthResult authResult = await firebaseAuth.signInWithCredential(credential);
    return authResult.user;
  }

  Future<void> _login() async {
    setState(() {
      this._isLoading = true;
    });
    final FacebookLoginResult result =
        await facebookSignIn.logIn(['email', 'public_profile']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        firebaseUser = await firebaseAuthWithFacebook(token: accessToken);
        _showMessage('Sesión iniciada: ${firebaseUser.displayName}.');
        firestore.usersRef.document(firebaseUser.uid).setData({
          'providerId': firebaseUser.providerId,
          'uid': firebaseUser.uid,
          'displayName': firebaseUser.displayName,
          'photoUrl': firebaseUser.photoUrl,
          'email': firebaseUser.email,
          'phoneNumber': firebaseUser.phoneNumber,
          'fbId': accessToken.userId,
          'lastSignInTimestamp': DateTime.now()
        }, merge: true);
        userDocId = firebaseUser.uid;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Inicio de sesión cancelado.');
        setState(() {
          this._isLoading = false;
        });
        break;
      case FacebookLoginStatus.error:
        _showMessage('Ocurrió un error la iniciar sesión.\n'
            '${result.errorMessage}');
        setState(() {
          this._isLoading = false;
        });
        break;
    }
  }

  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
  }

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
    _loginScaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.grey[600].withOpacity(0.7),
      behavior: SnackBarBehavior.floating,
    ));

    print(
        '**********************************************$message****************************************************************');
  }

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _loginScaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 550.0,
              width: 250.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/images/logo.jpg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          // Padding(
                          //   padding: const EdgeInsets.only(bottom: 10.0),
                          //   child: TextFormField(
                          //       controller: _usernameController,
                          //       decoration: InputDecoration(hintText: 'Usuario'),
                          //       validator: (value) {
                          //         if (value.isEmpty) {
                          //           return 'Debe ingresar un usuario';
                          //         }
                          //         return null;
                          //       }),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.only(bottom: 10.0),
                          //   child: TextFormField(
                          //       controller: _passwordController,
                          //       obscureText: true,
                          //       decoration: InputDecoration(hintText: 'Password'),
                          //       validator: (value) {
                          //         if (value.isEmpty) {
                          //           return 'Debe ingresar una contraseña';
                          //         }
                          //         return null;
                          //       }),
                          // ),
                          // RaisedButton(
                          //   color: Color(0xFF005b03),
                          //   textColor: Colors.white,
                          //   padding: EdgeInsets.symmetric(
                          //       vertical: 10.0, horizontal: 20.0),
                          //   onPressed: () {
                          //     Navigator.push(context,
                          //         MaterialPageRoute(builder: (context) => Home()));
                          //   },
                          //   child: Text(
                          //     'Entrar',
                          //     style: TextStyle(fontSize: 19.0),
                          //   ),
                          // ),
                          RaisedButton(
                            color: Color(0xFF3b5998),
                            textColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            onPressed: _login,
                            child: Text(
                              'Iniciar sesion con Facebook',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 19.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              'Registrate (proximamente)',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  decoration: TextDecoration.underline,
                                  color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _isLoading ? linearProgress() : Container(),
        ],
      ),
    );
  }
}
