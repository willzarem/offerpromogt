import 'package:flutter/material.dart';
import 'package:offerpromogt/data/coupons.dart';
import 'package:offerpromogt/models/coupon.dart';

class CouponsListPage extends StatefulWidget {
  final CouponType type;
  CouponsListPage({Key key, this.type}) : super(key: key);

  _CouponsListPageState createState() => _CouponsListPageState();
}

class _CouponsListPageState extends State<CouponsListPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.type);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cupones: ${widget.type}'),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: coupons.length,
            itemBuilder: (context, index) {
              return Coupon.fromMap(coupons[index]).viewAsList();
            },
          )),
    );
  }
}
