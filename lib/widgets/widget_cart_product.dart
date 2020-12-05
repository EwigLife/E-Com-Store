import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordpress_app/Provider/cart_provider.dart';
import 'package:wordpress_app/Provider/loader_provider.dart';
import 'package:wordpress_app/model/cat_response_model.dart';
import 'package:wordpress_app/utils/custom_stepper.dart';
import 'package:wordpress_app/utils/utils.dart';

class CartProduct extends StatelessWidget {
  CartProduct({this.data});
  CartItem data;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: makeListTile(context),
      ),
    );
  }

  ListTile makeListTile(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        leading: Container(
          width: 50,
          height: 150,
          alignment: Alignment.center,
          child: Image.network(
            data.thumbnail,
            height: 150,
          ),
        ),
        title: Text(
          data.productName,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.all(5),
          child: Wrap(
            direction: Axis.vertical,
            children: [
              Text(
                'Rs ${data.productSalePrice.toString()}',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    Text(
                      'Remove',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Utils.showMessage(
                      context,
                      'WooCommerece App',
                      'Do you want to delete this Item?',
                      'Yes',
                      () {
                        Provider.of<LoaderProvider>(context, listen: false)
                            .setLoadingStatus(true);
                        Provider.of<CartProvider>(context, listen: false)
                            .removeItem(data.productId);
                        Provider.of<LoaderProvider>(context, listen: false)
                            .setLoadingStatus(false);
                        Navigator.of(context).pop();
                      },
                      buttonText2: 'No',
                      isConfimationDialog: true,
                      onPressed2: () {
                        Navigator.of(context).pop();
                      });
                },
                padding: EdgeInsets.all(8),
                color: Colors.redAccent,
                shape: StadiumBorder(),
              ),
            ],
          ),
        ),
        trailing: Container(
          width: 120,
          child: CustomeStepper(
              lowerLimit: 0,
              upperLimit: 1,
              iconSize: 22.0,
              onChanged: (value) {
                Provider.of<CartProvider>(context, listen: false)
                    .updateQty(data.productId, value);
              },
              stepValue: 1,
              value: data.qty),
        ),
      );
}
