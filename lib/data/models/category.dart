class Categories {
  late String? id;
  late String? catName;
  late String? icon;

  Categories({
    required this.id,
    required this.catName,
    required this.icon,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catName = json['cat_name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cat_name'] = catName;
    data['icon'] = icon;
    return data;
  }
}