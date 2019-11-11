import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:offerpromogt/models/user.dart';

import 'package:offerpromogt/pages/home.dart';
import 'package:offerpromogt/widgets/loading.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  User user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    firestore.usersRef
        .document(userDocId)
        .get(source: Source.serverAndCache)
        .then((DocumentSnapshot doc) {
      User userInfo;

      if (doc.exists) {
        userInfo = User.fromMap(doc.data);
      }

      setState(() {
        this.user = userInfo;
        this.fullNameController.text = userInfo?.fullName;
        this.birthDateController.text =
            DateFormat.yMd('es').format(userInfo?.birthDate);
        this.idNumberController.text = userInfo?.idNumber;
        this.isLoading = false;
      });
    }).catchError((error) {
      print(error);
      setState(() {
        this.isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Perfil',
            style: TextStyle(
                color: Colors.white, fontSize: 30.0, fontFamily: 'CothamSans'),
          ),
        ),
        body:
            Padding(padding: EdgeInsets.all(20.0), child: buildProfileForm()));
  }

  buildProfileForm() {
    if (isLoading) {
      return circularProgress();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: fullNameController,
            decoration: InputDecoration(
                hintText: 'Nombre completo', hasFloatingPlaceholder: false),
            onChanged: (value) => this.user.fullName = value,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
              controller: birthDateController,
              readOnly: true,
              decoration: InputDecoration(
                  hintText: 'Fecha de nacimiento',
                  hasFloatingPlaceholder: false),
              onTap: () => DatePicker.showDatePicker(context,
                      locale: LocaleType.es,
                      currentTime: this.user.birthDate,
                      maxTime: DateTime.now(),
                      theme: DatePickerTheme(), onConfirm: (date) {
                    setState(() {
                      birthDateController.text =
                          DateFormat.yMd('es').format(date);
                      user.birthDate = date;
                    });
                  })),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: idNumberController,
            keyboardType: TextInputType.number,
            maxLength: 13,
            inputFormatters: [WhitelistingTextInputFormatter(RegExp("[0-9]"))],
            decoration: InputDecoration(
                hintText: 'Documento de identifiación',
                hasFloatingPlaceholder: false),
            onChanged: (value) => this.user.idNumber = value,
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: MaterialButton(
            child: Text('Guardar'),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: handleSave(context),
          ),
        )
      ],
    );
  }

  handleSave(BuildContext context) => () async {
        setState(() {
          this.isLoading = true;
        });
        try {
          await firestore.usersRef
              .document(userDocId)
              .setData(this.user.toMap());
        } catch (e) {
          print(e);
        } finally {
          Navigator.pop(context);
        }
      };
}
