import 'package:flutter/material.dart';
import 'package:offerpromogt/pages/home.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: 480.0,
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
