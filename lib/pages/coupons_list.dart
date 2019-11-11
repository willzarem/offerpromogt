import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offerpromogt/models/coupon.dart';
import 'package:offerpromogt/pages/home.dart';
import 'package:offerpromogt/widgets/loading.dart';

class CouponsListPage extends StatefulWidget {
  final String type;
  CouponsListPage({Key key, this.type}) : super(key: key);

  _CouponsListPageState createState() => _CouponsListPageState();
}

class _CouponsListPageState extends State<CouponsListPage> {
  List<Coupon> coupons = [];

  @override
  void initState() {
    super.initState();
    getCoupons(widget.type);
  }

  @override
  Widget build(BuildContext context) {
    String listTitle;
    switch (widget.type) {
      case 'drink':
        listTitle = 'Bebidas';
        break;
      case 'hotel':
        listTitle = 'Hoteles';
        break;
      case 'coffee':
        listTitle = 'Cafeterías';
        break;
      case 'restaurant':
        listTitle = 'Restaurantes';
        break;
      default:
        listTitle = 'Todos';
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cupones: $listTitle'),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<List<Coupon>>(
              future: getCoupons(widget.type),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return circularProgress();
                }
                if (snapshot.data.isEmpty) {
                  return Center(
                    child: Text(
                      'No hay cupones en esta categroría de momento, prueba volver más tarde. :)',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[600], fontSize: 30.0),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) =>
                      snapshot.data[index].viewAsList(context),
                );
              })),
    );
  }

  Future<List<Coupon>> getCoupons(String type) async {
    QuerySnapshot snapshot;
    if (type == 'all') {
      snapshot = await firestore.couponsRef
          .orderBy('createdAt', descending: true)
          .limit(10)
          .getDocuments();
    } else {
      snapshot = await firestore.couponsRef
          .where('type', isEqualTo: type)
          .orderBy('createdAt', descending: true)
          .limit(10)
          .getDocuments();
    }
    return snapshot.documents
        .map((doc) => Coupon.fromMap(doc.data, couponId: doc.documentID))
        .toList();
  }
}
