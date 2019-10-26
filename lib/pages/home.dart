import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:offerpromogt/models/coupon.dart';
import 'package:offerpromogt/pages/coupons_list.dart';

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
            color: Colors.green[900],
            onPressed: () => print('go to profile'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: PageView.builder(
          controller: promoSliderController,
          itemBuilder: (context, position) {
            return promoSlider(position);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: getBottomNavigationItems(),
        onTap: (index) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CouponsListPage(
                        type: CouponType.restaurant,
                      )));
        },
      ),
    );
  }

  Widget promoSlider(int position) {
    return AnimatedBuilder(
      animation: promoSliderController,
      builder: (context, widget) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(5),
            height: 800,
            child: widget,
          ),
        );
      },
      child: Container(
        child:
            Image.network('https://placehold.it/600x800?text=Promo$position'),
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
          title: Text('Bebidas')),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/002-hotel.svg',
            height: 50.0,
          ),
          title: Text('Hoteles')),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/003-coffee.svg',
            height: 50.0,
          ),
          title: Text('Cafeterías')),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/004-fast-food.svg',
            height: 50.0,
          ),
          title: Text('Restaurantes')),
    ];
  }
}
