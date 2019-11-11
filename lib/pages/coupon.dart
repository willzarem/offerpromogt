import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:offerpromogt/models/coupon.dart';

class CouponPage extends StatelessWidget {
  final Coupon coupon;
  const CouponPage({Key key, this.coupon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.coupon.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Container(
        // padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(this.coupon.image),
            Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Text(
                this.coupon.title,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Text(
                'Válido hasta: ' +
                    DateFormat.yMd('es').format(this.coupon.expiresAt),
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.grey, fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                this.coupon.description,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16.0, fontFamily: 'Roboto'),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                'Información adicional:',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300, fontFamily: 'Roboto'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, left: 130.0),
              decoration: BoxDecoration(
                  color: Colors.lightBlue[200],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0))),
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Autor: ${this.coupon.ownerName}', style: TextStyle(fontSize: 16.0),)),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, left: 130.0),
              decoration: BoxDecoration(
                  color: Colors.lightBlue[200],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0))),
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Publicado: ${DateFormat.yMMMEd("es").format(this.coupon.createdAt)}', style: TextStyle(fontSize: 16.0),)),
            )
          ],
        ),
      ),
    );
  }
}
