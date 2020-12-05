import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/Provider/cart_provider.dart';
import 'package:wordpress_app/Provider/loader_provider.dart';
import 'package:wordpress_app/utils/ProgressHUD.dart';

class BasePage extends StatefulWidget {
  BasePage({
    Key key,
  }) : super(key: key);
  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  bool isApiCallProcess = false;

  @override
  // ignore: must_call_super
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(builder: (context, loaderModel, child) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: ProgressHUD(
          child: pageUI(),
          inAsyncCall: loaderModel.isApiCallProcess,
          opacity: 0.3,
        ),
      );
    });
  }

  Widget pageUI() {
    return null;
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: Colors.redAccent,
      automaticallyImplyLeading: true,
      title: Text(
        'WooCommerece Apps',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      actions: [
        Icon(
          Icons.notifications_none,
          color: Colors.white,
        ),
        SizedBox(
          width: 10,
        ),
        IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        Provider.of<CartProvider>(context, listen: false).cartItems.length == 0
            ? Container()
            : Positioned(
                child: Stack(
                  children: [
                    Icon(
                      Icons.brightness_1,
                      size: 20.0,
                      color: Colors.green[800],
                    ),
                    Positioned(
                      top: 4.0,
                      right: 7.0,
                      child: Center(
                        child: Text(
                          Provider.of<CartProvider>(context, listen: false)
                              .cartItems
                              .length
                              .toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
