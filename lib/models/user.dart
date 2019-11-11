class User {
  String docId;
  String displayName;
  String email;
  String photoUrl;
  String fbId;
  DateTime birthDate;
  String idNumber;

  User(
      {this.docId,
      this.displayName,
      this.birthDate,
      this.idNumber,
      this.email,
      this.fbId,
      this.photoUrl});

  factory User.fromMap(Map<String, dynamic> map, {String docId}) => User(
        docId: docId,
        displayName: map['displayName'],
        birthDate: map['birthDate']?.toDate(),
        idNumber: map['idNumber'],
        email: map['email'],
        fbId: map['fbId'],
        photoUrl: map['photoUrl'],
      );

  Map<String, dynamic> toMap() => {
        'displayName': this.displayName,
        'birthDate': this.birthDate,
        'idNumber': this.idNumber,
        'email': this.email,
        'fbId': this.fbId,
        'photoUrl': this.photoUrl,
      };
}
