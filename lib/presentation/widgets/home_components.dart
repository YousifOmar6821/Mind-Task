import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/app_colors.dart';
import '../../data/local/global_settings.dart';
import '../../data/models/slider.dart';
import '../../generated/assets.dart';
import 'custom_buttons.dart';
import 'custom_text.dart';

class SliderBanner extends StatelessWidget {
  List<Sliders>? sliders;
   SliderBanner({
    super.key,
    required this.sliders,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: CarouselSlider(
        items: sliders?.map((value) {
          return Material(
            borderRadius: BorderRadius.circular(10.0),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              value.image!,
              width: double.infinity,
              // fit: BoxFit.cover,
              fit: BoxFit.contain,
            ),
          );
        }).toList(),
        options: CarouselOptions(
          // height: MediaQuery.of(context).size.height / 2,
          aspectRatio: 16 / 7,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration:
          const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            // Do something when the page is changed
          },
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

class CustomCategory extends StatelessWidget {

  String? catName;
  String? image;
   CustomCategory({
     super.key,
   required this.catName,
   required this.image,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              /// Function
            },
            child: Container(

              height: Get.width * 0.3,
              width: Get.width * 0.3,
              padding: const EdgeInsets.all(34),
              decoration: const BoxDecoration(
                // color: Colors.deepPurple,
                image: DecorationImage(
                  image: AssetImage(Assets.imagesFrame), // Your image path here
                  // fit: BoxFit.cover, // Adjust the image size and alignment as needed
                ),
              ),
              child: SizedBox(
                child: Image.network(
                  image!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CText(
                overflow: TextOverflow.ellipsis,
                catName!,
                maxLines: 1,
                style:
                const TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}


class SectionTitle extends StatelessWidget {
  String? title;
  final void Function()? moreButtonFunction;
  SectionTitle({
    super.key,
    required this.title,
    required this.moreButtonFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only( left: 20.0,right: 20.0,bottom: 10),
          child: Divider(
            thickness: 1,
            color: Color(0xffCCCCCC),
          ),
        ),
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CText(
                title!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CSizedButton(
                onPressed: moreButtonFunction,
                text: GlobalSettings.lang.more,
                color: primarySwatch,
                textColor: Colors.white,
                circularRadius: 25,
                width: Get.width * .25,
                height: Get.width * .1,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {

  double? cardSize;
  String? image;
  String? productName;
  String? desc;
  String? rate;
  String? salePrice;
  String? listPrice;
  String? discount;
   ProductCard({
    super.key,
    required this.cardSize,
    required this.image,
    required this.productName,
    required this.desc,
    required this.rate,
    required this.salePrice,
    required this.listPrice,
    required this.discount,
   });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        elevation: 2,
        child: SizedBox(
          width: cardSize,
          // height:MediaQuery.of(context).size.width* 0.9,
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.start,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: cardSize,
                child:
                Image.network(
                  image!,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(Assets.imagesJar,fit:BoxFit.contain);
                  },
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                           CText(
                            productName!,
                            maxLines: 1,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                           CText(
                             desc!,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                CText(
                                  '(${rate??10})',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,

                                  ),
                                ),
                                RatingBar.builder(
                                  itemSize: 13,
                                  ignoreGestures: true,
                                  initialRating: double.parse(rate??'5'),
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemBuilder:
                                      (context, _) =>
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate:
                                      (rating) {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 3.0),
                    SizedBox(
                      // width: cardSize,
                      height: Get.width * 0.2,
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        crossAxisAlignment:
                        CrossAxisAlignment.end,
                        children: [
                           CText(
                            '$salePrice ${GlobalSettings.lang.currency}',
                            maxLines: 1,
                            style: const TextStyle(
                              color: primarySwatch,
                              fontSize: 12,
                            ),
                          ),
                           CText(
                            '$listPrice ${GlobalSettings.lang.currency}',
                            maxLines: 1,
                            style: const TextStyle(
                              decoration:
                              TextDecoration
                                  .lineThrough,
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          Container(
                            color: Colors.black,
                            child:  CText(
                              '$discount% ${GlobalSettings.lang.discount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SaleProductCard extends StatelessWidget {

  double? cardSize;
  String? image;
  String? productName;
  String? desc;
  String? rate;
  String? salePrice;
  String? listPrice;
  String? discount;
  SaleProductCard({
    super.key,
    required this.cardSize,
    required this.image,
    required this.productName,
    required this.desc,
    required this.rate,
    required this.salePrice,
    required this.listPrice,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        child: SizedBox(
          width: cardSize,
          // height:MediaQuery.of(context).size.width* 0.9,
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.start,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: cardSize,
                child:
                Image.network(
                  image!,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(Assets.imagesJar,fit:BoxFit.contain);
                  },
                  fit: BoxFit.contain,
                ),
                // FadeInImage(
                //   image:  NetworkImage(image!),
                //   placeholder:  const AssetImage(
                //       "https://admin.ihoneyherb.com/products/uploads/thumbs/1710227886hiring.png"),
                //   imageErrorBuilder:
                //       (context, error, stackTrace) {
                //     return Image.network(
                //         'ashttps://admin.ihoneyherb.com/products/uploads/thumbs/1710227886hiring.png',
                //       fit: BoxFit.contain,
                //     );
                //   },
                //   fit: BoxFit.contain,
                // )
              ),
              Column(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  CText(
                    productName!,
                    maxLines: 1,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                  CText(
                    desc!,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        CText(
                          '(${rate??10})',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,

                          ),
                        ),
                        RatingBar.builder(
                          itemSize: 13,
                          ignoreGestures: true,
                          initialRating: double.parse(rate??'5'),
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemBuilder:
                              (context, _) =>
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate:
                              (rating) {},
                        ),
                      ],
                    ),
                  ),
                  CText(
                    '$salePrice ${GlobalSettings.lang.currency}',
                    maxLines: 1,
                    style: const TextStyle(
                      color: primarySwatch,
                      fontSize: 15,
                    ),
                  ),
                  CText(
                    '$listPrice ${GlobalSettings.lang.currency}',
                    maxLines: 1,
                    style: const TextStyle(
                      decoration:
                      TextDecoration
                          .lineThrough,
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    child:  CText(
                      '$discount% ${GlobalSettings.lang.discount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewProductCard extends StatelessWidget {

  double? cardSize;
  String? image;
  String? productName;
  String? desc;
  String? rate;
  String? salePrice;
  String? listPrice;
  String? discount;
  NewProductCard({
    super.key,
    required this.cardSize,
    required this.image,
    required this.productName,
    required this.desc,
    required this.rate,
    required this.salePrice,
    required this.listPrice,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        child: SizedBox(
          width: cardSize,
          // height:MediaQuery.of(context).size.width* 0.9,
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.start,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: cardSize,
                child:
                Image.network(
                  image!,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(Assets.imagesJar,fit:BoxFit.contain);
                  },
                  fit: BoxFit.contain,
                ),
                // FadeInImage(
                //   image:  NetworkImage(image!),
                //   placeholder:  const AssetImage(
                //       "https://admin.ihoneyherb.com/products/uploads/thumbs/1710227886hiring.png"),
                //   imageErrorBuilder:
                //       (context, error, stackTrace) {
                //     return Image.network(
                //         'ashttps://admin.ihoneyherb.com/products/uploads/thumbs/1710227886hiring.png',
                //       fit: BoxFit.contain,
                //     );
                //   },
                //   fit: BoxFit.contain,
                // )
              ),
              Column(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  CText(
                    productName!,
                    maxLines: 1,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                  CText(
                    desc!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        CText(
                          '(${rate??10})',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,

                          ),
                        ),
                        RatingBar.builder(
                          itemSize: 13,
                          ignoreGestures: true,
                          initialRating: double.parse(rate??'5'),
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemBuilder:
                              (context, _) =>
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate:
                              (rating) {},
                        ),
                      ],
                    ),
                  ),
                  CText(
                    '$salePrice ${GlobalSettings.lang.currency}',
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



