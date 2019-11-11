import 'package:flutter/material.dart';
import 'package:offerpromogt/pages/home.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  static final FacebookLogin facebookSignIn = new FacebookLogin();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;

  String _message = 'Log in/out by pressing the buttons below.';

  Future<FirebaseUser> firebaseAuthWithFacebook({@required FacebookAccessToken token}) async {

    AuthCredential credential= FacebookAuthProvider.getCredential(accessToken: token.token);
    AuthResult authResult = await firebaseAuth.signInWithCredential(credential);
    return authResult.user;
  }

  Future<void> _login() async {
    final FacebookLoginResult result =
        await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessage('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
         firebaseUser = await firebaseAuthWithFacebook(token: accessToken);
         print(_message);
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
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
  }

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(hintText: 'Usuario'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Debe ingresar un usuario';
                              }
                              return null;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(hintText: 'Password'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Debe ingresar una contraseña';
                              }
                              return null;
                            }),
                      ),
                      RaisedButton(
                        color: Color(0xFF005b03),
                        textColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                        child: Text(
                          'Entrar',
                          style: TextStyle(fontSize: 19.0),
                        ),
                      ),
                      RaisedButton(
                        color: Color(0xFF3b5998),
                        textColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        onPressed: _login,
                        child: Text(
                          'Facebook',
                          style: TextStyle(fontSize: 19.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Registrate',
                          style: TextStyle(
                              fontSize: 16.0,
                              decoration: TextDecoration.underline,
                              color: Colors.blue[400]),
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
    );
  }
}
