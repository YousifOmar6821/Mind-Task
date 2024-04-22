class Product {
  late String? id;
  late String? name;
  late String? shortDesc;
  late String? mainImage;
  late String? listPrice;
  late String? salePrice;
  late String? discount;
  late String? rating;

  Product(
      {
        required this.id,
        required this.name,
        required this.shortDesc,
        required this.mainImage,
        required this.listPrice,
        required this.salePrice,
        required this.discount,
        required this.rating});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name'];
    shortDesc = json['short_desc'];
    mainImage = json['main_image'];
    listPrice = json['list_price'];
    salePrice = json['sale_price'];
    discount = json['discount'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['short_desc'] = shortDesc;
    data['main_image'] = mainImage;
    data['list_price'] = listPrice;
    data['sale_price'] = salePrice;
    data['discount'] = discount;
    data['rating'] = rating;
    return data;
  }
}