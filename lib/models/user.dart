class User {
  String docId;
  String fullName;
  DateTime birthDate;
  String idNumber;

  User({this.docId, this.fullName, this.birthDate, this.idNumber});

  factory User.fromMap(Map<String, dynamic> map, {String docId}) => User(
      docId: docId,
      fullName: map['fullName'],
      birthDate: map['birthDate'].toDate(),
      idNumber: map['idNumber']);

  Map<String, dynamic> toMap() => {
        'fullName': this.fullName,
        'birthDate': this.birthDate,
        'idNumber': this.idNumber,
      };
}
