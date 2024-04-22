class Sliders {
  late String? id;
  late String? productId;
  late String? image;

  Sliders({
    required this.id,
    required this.productId,
    required this.image,
  });

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['image'] = image;
    return data;
  }
}