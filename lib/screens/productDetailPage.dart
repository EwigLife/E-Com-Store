import 'package:flutter/material.dart';
import 'package:wordpress_app/model/products.dart';
import 'package:wordpress_app/screens/basePage.dart';
import 'package:wordpress_app/widgets/Widget_Product_Details.dart';

// ignore: must_be_immutable
class ProductDetailPage extends BasePage {
  ProductDetailPage({Key key, this.product}) : super(key: key);
  Product product;
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends BasePageState<ProductDetailPage> {
  @override
  Widget pageUI() {
    return ProductDetailsWidget(
      data: this.widget.product,
    );
  }
}
