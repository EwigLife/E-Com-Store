import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/Provider/cart_provider.dart';
import 'package:wordpress_app/Provider/loader_provider.dart';
import 'package:wordpress_app/screens/cart_page.dart';
import 'package:wordpress_app/screens/homePage.dart';
import 'package:wordpress_app/screens/productDetailPage.dart';
import 'package:wordpress_app/screens/productPage.dart';
import 'Provider/productsProvider.dart';
import 'screens/basePage.dart';

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
          ChangeNotifierProvider(
            create: (context) => LoaderProvider(),
            child: BasePage(),
          ),
          ChangeNotifierProvider(
            create: (context) => CartProvider(),
            child: ProductDetailPage(),
          ),
          ChangeNotifierProvider(
            create: (context) => CartProvider(),
            child: CartPage(),
          ),
        ],
        child: MaterialApp(
          title: 'My APP',
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ));
  }
}
