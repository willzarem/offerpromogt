import 'package:flutter/material.dart';

class Coupon {
  int id;
  double price;
  String title;
  CouponType type;
  String description;
  DateTime createdAt;
  DateTime expiresAt;
  String image;

  Coupon(
      {this.id,
      this.type,
      this.title,
      this.price,
      this.image,
      this.description,
      this.createdAt,
      this.expiresAt});

  factory Coupon.fromMap(Map<String, dynamic> map) => Coupon(
      id: map['id'],
      price: map['price'],
      title: map['title'],
      type: map['type'],
      image: map['image'],
      description: map['description'],
      createdAt: DateTime.parse(map['createdAt']),
      expiresAt: DateTime.parse(map['expiresAt']));

  Widget viewAsList() {
    return GestureDetector(
      onTap: () => print('goto'),
      child: Card(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.network(
                this.image,
                height: 100.0,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
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
                      text: TextSpan(
                          text: this.description,
                          style: TextStyle(
                              color: Colors.grey[700], fontSize: 12.0)),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum CouponType { bar, hotel, coffeeShop, restaurant, other }
