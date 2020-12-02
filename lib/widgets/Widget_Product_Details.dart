import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wordpress_app/model/products.dart';
import 'package:wordpress_app/utils/ExpandText.dart';
import 'package:wordpress_app/utils/custom_stepper.dart';
import 'package:wordpress_app/widgets/Widget_related_Product.dart';

// ignore: must_be_immutable
class ProductDetailsWidget extends StatelessWidget {
  ProductDetailsWidget({
    Key key,
    this.data,
  }) : super(key: key);
  Product data;
  final CarouselController _controller = CarouselController();
  int qty = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                productImages(data.images, context),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: data.calculateDiscount() > 0,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.green,
                      ),
                      child: Text(
                        "${data.calculateDiscount()}% OFF",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    data.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      data.attributes != null && data.attributes.length > 0
                          ? (data.attributes[0].options.join('-').toString() +
                              "" +
                              data.attributes[0].name)
                          : "",
                    ),
                    Visibility(
                      visible: data.salePrice != data.regularPrice,
                      child: Text(
                        'Rs${data.regularPrice}',
                        style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'Rs ${data.salePrice}',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomeStepper(
                        lowerLimit: 0,
                        upperLimit: 2,
                        iconSize: 22,
                        onChanged: (value) {
                          print(value);
                        },
                        stepValue: 1,
                        value: this.qty),
                    FlatButton(
                      padding: EdgeInsets.all(15),
                      shape: StadiumBorder(),
                      color: Colors.red,
                      onPressed: () {},
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                ExpandText(
                    labelHeader: 'Product Details',
                    desc: data.description,
                    shortDesc: data.shortDescription),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                WidgetRelatedProducts(
                  labelName: 'Related Products',
                  products: this.data.relatedIds,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget productImages(List<Images> images, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Center(
                    child: Image.network(
                      images[index].src,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 1.5,
              ),
              carouselController: _controller,
            ),
          ),
          Positioned(
            top: 100,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                _controller.previousPage();
              },
            ),
          ),
          Positioned(
            top: 100,
            left: MediaQuery.of(context).size.width - 80,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                _controller.nextPage();
              },
            ),
          ),
        ],
      ),
    );
  }
}
