import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/data/local/global_settings.dart';
import 'package:task/generated/assets.dart';
import '../../data/models/product.dart';
import '../widgets/home_components.dart';

class MoreProductsScreen extends StatelessWidget {
  const MoreProductsScreen({
    super.key,
    required this.products,
    required this.title,
  });

  final List<Product> products;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 50,
        title: Center(
          child: Text(
            title,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: (){
              Get.back();
            },
              child: Image.asset(GlobalSettings.appSettings.languageCode=='en'
                  ? Assets.iconsBackToHome
                  :Assets.iconsBackAr,
              ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10.0),
          child: LayoutBuilder(builder: (context, constrains) {
            var cardSize = constrains.maxWidth / 2 - 8;
            return Wrap(
              children: products.map((product) {
                return ProductCard(
                  cardSize: cardSize,
                  image: product.mainImage,
                  productName: product.name,
                  desc: product.shortDesc,
                  rate: product.rating,
                  salePrice: product.salePrice,
                  listPrice: product.listPrice,
                  discount: product.discount,
                );
              }).toList(),
            );
          }),
        ),
      ),
    );
  }
}
