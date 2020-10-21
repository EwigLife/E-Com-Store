import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/screens/homePage.dart';
import 'package:wordpress_app/screens/productPage.dart';
import 'Provider/productsProvider.dart';

void main() {
  runApp(WooCommerceApp());
}

class WooCommerceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ProductProvider(),
            child: ProductPage(),
          ),
        ],
        child: MaterialApp(
          title: 'My APP',
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ));
  }
}
