
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task/data/models/product.dart';

import '../models/category.dart';
import '../models/slider.dart';
import '../web_services/user_web_service.dart';

class UserRepository {
  final UserWebService patientWebService;

  UserRepository(this.patientWebService);

  Future<List<List>> getHomeData() async {
    try {
      var data = await patientWebService.getHomeData();
      List<List> list = [];
      list.add(data['slider'].map<Sliders>((x) => Sliders.fromJson(x)).toList());
      list.add(data['categories'].map<Categories>((x) => Categories.fromJson(x)).toList());
      list.add(data['products'].map<Product>((x) => Product.fromJson(x)).toList());
      list.add(data['selected_products'].map<Product>((x) => Product.fromJson(x)).toList());
      list.add(data['new_products'].map<Product>((x) => Product.fromJson(x)).toList());
      return list;
    } catch (e) {
      rethrow;
    }
  }
  Future<List<Product>> getMoreProductsData(String productType,String searchKeyWord) async {
    try {
      var data = await patientWebService.getMoreProductsData( productType,searchKeyWord);
      return data.map<Product>((prod) => Product.fromJson(prod)).toList();
    } catch (e) {
      rethrow;
    }
  }
}