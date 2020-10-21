import 'package:flutter/material.dart';
import 'package:wordpress_app/model/products.dart';
import '../api_service.dart';


class WidgetProductDetailPage extends StatefulWidget {
  WidgetProductDetailPage ({
    Key key,
    this.labelName,
    this.id,
    this.image,
  }) : super(key: key);

  String labelName;
  String id;
  String image;

  @override
  _WidgetProductDetailPageState createState() => _WidgetProductDetailPageState();
}

class _WidgetProductDetailPageState extends State<WidgetProductDetailPage> {
  APIService apiService;

  @override
void initState(){
  apiService = APIService();

  super.initState();
}
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: FutureBuilder(
        future: apiService.getProducts(tagName:this.widget.id),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> model) {
          if (model.hasData) {
            return _buildList(model.data);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
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
              Container(
                  margin: EdgeInsets.all(10),
                  width: 130,
                  height: 120,
                  alignment: Alignment.center,
                  child: Image.network(data.images[0].src,
                  height: 120,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0,5),
                        blurRadius: 15, 
                      )
                    ]
                  ),
                ),
              Container(
                width: 200,
                alignment: Alignment.centerLeft,
                child: Text(
                  data.name,
                  style: TextStyle(color: Colors.black,
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