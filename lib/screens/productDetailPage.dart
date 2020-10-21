import 'package:flutter/material.dart';
import 'package:wordpress_app/widgets/widgetProductDetailPage.dart';

class ProductDetailPage extends StatefulWidget {
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: WidgetProductDetailPage(),
      
    );
  }
  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: Colors.redAccent,
      automaticallyImplyLeading: false,
      title: Text(
        'WooCommerece Apps',
        style: TextStyle(color: Colors.white,),
      ),
      actions: [
        Icon(Icons.notifications_none, color: Colors.white,),
        SizedBox(width: 10,),
        Icon(Icons.shopping_cart, color: Colors.white,),
        SizedBox(width: 10,),
        FlatButton(onPressed: () { 
          Navigator.pop(context);
         },
        child: Icon(Icons.arrow_back, color: Colors.white,)),
        SizedBox(width: 10,),
      ],
    );
  }
}