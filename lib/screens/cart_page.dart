import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/Provider/cart_provider.dart';
import 'package:wordpress_app/Provider/loader_provider.dart';
import 'package:wordpress_app/utils/ProgressHUD.dart';
import 'package:wordpress_app/widgets/widget_cart_product.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    var cartItemsList = Provider.of<CartProvider>(context, listen: false);
    cartItemsList.resetStreams();
    cartItemsList.fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(builder: (context, loaderModel, child) {
      return Scaffold(
        body: ProgressHUD(
          child: _cartItemsList(),
          inAsyncCall: loaderModel.isApiCallProcess,
          opacity: 0.3,
        ),
      );
    });
    // return Container(
    //   child: CartProduct(
    //     data: CartItem(
    //       qty: 1,
    //       productId: 3740,
    //       productName: 'Microsoft Azure AZ – 103',
    //       thumbnail:
    //           'https://earnerss.com/wp-content/uploads/2020/04/azure-az-103.png',
    //       productRegularPrice: "7000",
    //       productSalePrice: '3500',
    //     ),
    //   ),
    // );
  }

  Widget _cartItemsList() {
    return Consumer<CartProvider>(
      builder: (context, cartModel, child) {
        if (cartModel.cartItems != null && cartModel.cartItems.length > 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: cartModel.cartItems.length,
                    itemBuilder: (context, index) {
                      return CartProduct(data: cartModel.cartItems[index]);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(
                              Icons.sync,
                              color: Colors.white,
                            ),
                            Text(
                              'Update Cart',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Provider.of<LoaderProvider>(context, listen: false)
                              .setLoadingStatus(true);
                          var cartProvider =
                              Provider.of<CartProvider>(context, listen: false);
                          cartProvider.updateCart((val) {
                            Provider.of<LoaderProvider>(context, listen: false)
                                .setLoadingStatus(false);
                            print(val);
                          });
                        },
                        padding: EdgeInsets.all(5),
                        color: Colors.green,
                        shape: StadiumBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Rs ${cartModel.totalAmount}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      FlatButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Checkout',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 15,
                            ),
                          ],
                        ),
                        onPressed: () {},
                        shape: StadiumBorder(),
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
