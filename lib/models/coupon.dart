import 'package:flutter/material.dart';
import 'package:offerpromogt/pages/coupon.dart';

class Coupon {
  int id;
  double price;
  String title;
  String type;
  String description;
  DateTime createdAt;
  DateTime expiresAt;
  String image;
  String couponId;
  String ownerName;
  String ownerId;

  Coupon(
      {this.couponId,
      this.type,
      this.title,
      this.price,
      this.image,
      this.description,
      this.ownerName,
      this.ownerId,
      this.createdAt,
      this.expiresAt});

  factory Coupon.fromMap(Map<String, dynamic> map, {String couponId}) => Coupon(
      couponId: couponId,
      price: map['price'].toDouble(),
      title: map['title'],
      type: map['type'],
      image: map['image'],
      description: map['description'],
      ownerName: map['ownerName'],
      ownerId: map['ownerId'],
      createdAt: map['createdAt'].toDate(),
      expiresAt: map['expiresAt'].toDate());

  Widget viewAsList(BuildContext context) {
    return Card(
      child: Material(
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CouponPage(
                        coupon: this,
                      ))),
          child: Row(
            children: <Widget>[
              Image.network(
                this.image,
                height: 130.0,
                width: 130.0,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        this.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Colors.black),
                      ),
                      Divider(),
                      RichText(
                        maxLines: 2,
                        text: TextSpan(
                            text: this.description,
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 12.0)),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${this.ownerName}',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum CouponType { bar, hotel, coffeeShop, restaurant, other }
