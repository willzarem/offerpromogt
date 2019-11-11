import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:offerpromogt/models/coupon.dart';
import 'package:offerpromogt/pages/coupon.dart';
import 'package:offerpromogt/pages/coupons_list.dart';
import 'package:offerpromogt/pages/profile.dart';
import 'package:offerpromogt/utils/firestore.dart';
import 'package:offerpromogt/widgets/loading.dart';

String userDocId;
final FirestoreService firestore = FirestoreService();

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController promoSliderController;

  @override
  void initState() {
    this.promoSliderController =
        PageController(initialPage: 1, viewportFraction: 0.9);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'OfferPromo',
          style: TextStyle(
              color: Colors.white, fontSize: 30.0, fontFamily: 'CothamSans'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            color: Colors.white,
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage())),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Las promociones para hoy:',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 24.0),
            ),
            Container(
              height: 400.0,
              child: FutureBuilder<QuerySnapshot>(
                  future: firestore.featuredRef
                      .orderBy('createdAt', descending: true)
                      .limit(5)
                      .getDocuments(source: Source.serverAndCache),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return circularProgress();
                    }
                    return PageView.builder(
                      itemCount: snapshot.data.documents.length,
                      controller: promoSliderController,
                      itemBuilder: (context, position) {
                        return promoSlider(Coupon.fromMap(
                            snapshot.data.documents[position].data,
                            couponId:
                                snapshot.data.documents[position].documentID));
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        currentIndex: 2,
        items: getBottomNavigationItems(),
        onTap: (index) {
          String type;
          switch (index) {
            case 0:
              type = 'drink';
              break;
            case 1:
              type = 'hotel';
              break;
            case 3:
              type = 'coffee';
              break;
            case 4:
              type = 'restaurant';
              break;
            default:
              type = 'all';
          }
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CouponsListPage(
                        type: type,
                      )));
        },
      ),
    );
  }

  Widget promoSlider(Coupon coupon) {
    return AnimatedBuilder(
      animation: promoSliderController,
      builder: (context, widget) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(5),
            height: 600,
            child: Material(
                child: InkWell(
              child: widget,
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CouponPage(coupon: coupon))),
            )),
          ),
        );
      },
      child: Container(
        child: coupon.image == null
            ? Container(
                child: Column(
                  children: <Widget>[
                    Text(coupon.title),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(coupon.description),
                    )
                  ],
                ),
              )
            : Image.network(coupon.image, fit: BoxFit.fitWidth),
      ),
    );
  }

  getBottomNavigationItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/001-cheers.svg',
            height: 50.0,
          ),
          title: Text(
            'Bebidas',
            style: TextStyle(color: Colors.grey[800]),
          )),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/002-hotel.svg',
            height: 50.0,
          ),
          title: Text(
            'Hoteles',
            style: TextStyle(color: Colors.grey[800]),
          )),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/005-tag.svg',
            height: 60.0,
          ),
          title: Text(
            'Todos',
            style: TextStyle(color: Colors.grey[800]),
          )),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/003-coffee.svg',
            height: 50.0,
          ),
          title: Text(
            'Cafeterías',
            style: TextStyle(color: Colors.grey[800]),
          )),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/004-fast-food.svg',
            height: 50.0,
          ),
          title: Text(
            'Restaurantes',
            style: TextStyle(color: Colors.grey[800]),
          )),
    ];
  }
}
