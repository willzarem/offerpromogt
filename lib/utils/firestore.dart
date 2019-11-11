import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Firestore _instance;
  CollectionReference usersRef;

  FirestoreService() {
    this._instance = Firestore.instance;
    this._instance.settings(
        persistenceEnabled: true,
        cacheSizeBytes: 10000000,
        timestampsInSnapshotsEnabled: true);
    this.usersRef = this._instance.collection('users');
  }

  getInstance() => this._instance;
}
