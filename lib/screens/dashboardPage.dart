import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_app/widgets/widgetHomeCategories.dart';
import 'package:wordpress_app/widgets/widgetHomeProducts.dart';

import '../config.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:Colors.white,
        child: ListView(
          children: [
            imageCarousel(context),
            WidgetCategories(),
            WidgetHomeProducts(labelName: 'Top Courses Today', tagId: Config.topsellingProductsTagId),
            WidgetHomeProducts(labelName: 'Special Offers', tagId: Config.specialofferTagId),
          ],
        )
      ),
    );
  }

  Widget imageCarousel(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      child: Carousel(
        overlayShadow: false,
        borderRadius: true,
        boxFit: BoxFit.none,
        autoplay: true,
        dotSize: 0.0,
        images: [
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network('https://soliloquywp.com/wp-content/uploads/2017/09/image-slider-to-wordpress-template-page.jpg'),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network('https://soliloquywp.com/wp-content/uploads/2017/09/image-slider-to-wordpress-template-page.jpg'),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network('https://soliloquywp.com/wp-content/uploads/2017/09/image-slider-to-wordpress-template-page.jpg'),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network('https://soliloquywp.com/wp-content/uploads/2017/09/image-slider-to-wordpress-template-page.jpg'),
          ),
        ],
      ),
    );
  }
}