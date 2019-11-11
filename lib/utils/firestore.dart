import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Firestore _instance;
  CollectionReference usersRef;
  CollectionReference couponsRef;
  CollectionReference featuredRef;

  FirestoreService() {
    this._instance = Firestore.instance;
    this._instance.settings(
        persistenceEnabled: true,
        cacheSizeBytes: 10000000,
        timestampsInSnapshotsEnabled: true);
    this.usersRef = this._instance.collection('users');
    this.couponsRef = this._instance.collection('coupons');
    this.featuredRef = this._instance.collection('featured');
  }

  getInstance() => this._instance;
}
