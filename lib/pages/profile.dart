import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
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
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                      hintText: 'Nombre completo', hasFloatingPlaceholder: false),
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
                            maxTime: DateTime.now(),
                            theme: DatePickerTheme(), onConfirm: (date) {
                          setState(() {
                            birthDateController.text =
                                DateFormat.yMd('es').format(date);
                          });
                        })),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 13,
                  inputFormatters: [WhitelistingTextInputFormatter(RegExp("[0-9]"))],
                  decoration: InputDecoration(
                      hintText: 'Documento de identifiación',
                      hasFloatingPlaceholder: false),
                ),
              )
            ],
          ),
        ));
  }
}
