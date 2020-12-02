import 'package:flutter/material.dart';
import 'package:wordpress_app/api_service.dart';
import 'package:wordpress_app/model/products.dart';
import 'package:wordpress_app/screens/productDetailPage.dart';

// ignore: must_be_immutable
class WidgetRelatedProducts extends StatefulWidget {
  WidgetRelatedProducts({
    this.labelName,
    this.products,
    this.data,
  });
  String labelName;
  List<int> products;
  Product data;
  @override
  _WidgetRelatedProductsState createState() => _WidgetRelatedProductsState();
}

class _WidgetRelatedProductsState extends State<WidgetRelatedProducts> {
  APIService apiService;

  @override
  void initState() {
    apiService = APIService();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF4F7FA),
      child: Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, top: 4),
              child: Text(
                this.widget.labelName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 4),
              child: Text(
                'View All',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
        _productsList(),
      ]),
    );
  }

  Widget _productsList() {
    return FutureBuilder(
      future: apiService.getProducts(productsIDs: this.widget.products),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> model) {
        if (model.hasData) {
          return _buildList(model.data);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildList(List<Product> items) {
    return Container(
      height: 200,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          var data = items[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                                product: data,
                              )));
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: 130,
                  height: 120,
                  alignment: Alignment.center,
                  child: Image.network(
                    data.images[0].src,
                    height: 120,
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 5),
                          blurRadius: 15,
                        )
                      ]),
                ),
              ),
              Container(
                width: 200,
                alignment: Alignment.centerLeft,
                child: Text(
                  data.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4, left: 4),
                width: 200,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      'RS.${data.regularPrice}',
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'RS.${data.regularPrice}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
