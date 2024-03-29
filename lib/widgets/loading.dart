import 'package:flutter/material.dart';

Widget circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 10.0),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.purple),
    ),
  );
}

Widget linearProgress() {
  return Container(
    padding: EdgeInsets.only(top: 10.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.orange[900]),
    ),
  );
}