import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:offerpromogt/pages/login.dart';

void main() {
  initializeDateFormatting('de_DE', null);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OfferPromo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'CothamSans',
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: Login(),
    );
  }
}
