class Category {
  int categoryId;
  String categoryName;
  String categoryDesc;
  int parent;
  OurImage image;
  
  Category({
    this.categoryId,
    this.categoryName,
    this.categoryDesc,
    this.image,
  });

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['id'];
    categoryName = json['name'];
    categoryDesc = json['description'];
    parent = json['parent'];
    image = json['image'] != null ? OurImage.fromJson(json['image']) : null;
  }
}

class OurImage {
  String url;

  OurImage({
    this.url,
  }); 

  OurImage.fromJson(Map<String, dynamic> json){
    url =json['src'];
  }
}