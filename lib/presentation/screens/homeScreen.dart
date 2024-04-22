import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task/business_logic/bloc/user/user_bloc.dart';
import 'package:task/business_logic/bloc/user/user_state.dart';
import 'package:task/constants/app_colors.dart';
import 'package:task/constants/routes.dart';
import 'package:task/data/local/global_settings.dart';
import 'package:task/presentation/widgets/custom_buttons.dart';
import 'package:task/presentation/widgets/custom_text.dart';
import 'package:task/presentation/widgets/home_components.dart';

import '../../business_logic/bloc/user/user_event.dart';
import '../../generated/assets.dart';
import '../../services/language_manager.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _searchController = TextEditingController();
  late String? searchKey;
  final PageStorageBucket bucket=PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    bool listen = true;
    bool isLoading = true;
    BlocProvider.of<UserBloc>(context).add(GetHomeDataEvent());
    return Scaffold(
      body:PageStorage(
        bucket: bucket,
        child:Padding(
          padding: const EdgeInsets.all(1.5),
          child: BlocConsumer<UserBloc, UserState>(
              listenWhen: (previousState, state) => listen,
              listener: (BuildContext context, UserState state) {
                if (state is GetHomeDataSuccess) {
                  isLoading = false;
                }
                if (state is GetMoreProductsSuccess) {
                  Get.toNamed(moreProductsScreen, arguments: {
                    'products': state.prods,
                    'title': '${GlobalSettings.lang.searchFor}$searchKey',
                  });
                }
                else if (state is GetMoreProductsError){
                  print(state.errMsg.toString());
                }
              },
              builder: (BuildContext context, UserState state) {
                return isLoading
                    ? const Center(
                    child: CircularProgressIndicator(
                      color: primarySwatch,
                    ))
                    : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0),
                            child: GestureDetector(
                              child: const Icon(
                                Icons.language,
                                size: 30,
                              ),
                              onTap: () =>
                                  LanguageManager.switchLanguage(context,'home'),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onSubmitted: (value) {
                                BlocProvider.of<UserBloc>(context).add(GetMoreProductsEvent('', value!));
                                searchKey = value;
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0),
                                labelText:
                                GlobalSettings.lang.searchForProducts,
                                hintText: GlobalSettings.lang.search,
                                prefixIcon: SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      width: Get.width * 0.02,
                                      height: Get.width * 0.02,
                                      Assets.iconsSearch,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  // gapPadding: 10,
                                  borderRadius: BorderRadius.circular(
                                      30.0), // Add border radius here
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0),
                            child: GestureDetector(
                                child: const Icon(
                                  Icons.exit_to_app,
                                  size: 30,
                                ),
                                onTap: () {
                                  GlobalSettings.user=null;
                                  Get.offNamed(loginScreen);
                                }),
                          ),
                        ],
                      ),
                      SliderBanner(sliders: GlobalSettings.sliders),
                      SizedBox(
                        // color: Colors.red,
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: GlobalSettings.categories.length,
                          itemBuilder: (context, index) {
                            return CustomCategory(
                              catName:
                              GlobalSettings.categories[index].catName,
                              image: GlobalSettings.categories[index].icon,
                            );
                          },
                        ),
                      ),
                      // Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children:GlobalSettings.categories.map((cat) {
                      //       return CustomCategory(
                      //           catName: cat.catName,
                      //           image: cat.icon,
                      //       );
                      //     }).toList(),
                      // ),
                      /// Products
                      SectionTitle(
                        title: GlobalSettings.lang.products,
                        moreButtonFunction: () {
                          /// Go to More Product Screen
                          Get.toNamed(moreProductsScreen, arguments: {
                            'products': GlobalSettings.products,
                            'title': GlobalSettings.lang.products,
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10.0),
                        child:
                        LayoutBuilder(builder: (context, constrains) {
                          var cardSize = constrains.maxWidth / 2 - 8;
                          return Wrap(
                            children: GlobalSettings.products
                                .take(4)
                                .map((product) {
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

                      /// Selected Products
                      SectionTitle(
                        title: GlobalSettings.lang.selectedProducts,
                        moreButtonFunction: () {
                          /// Go to More Product Screen
                          Get.toNamed(moreProductsScreen, arguments: {
                            'products': GlobalSettings.selectedProducts,
                            'title': GlobalSettings.lang.selectedProducts,
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 0.0),
                        child:
                        LayoutBuilder(builder: (context, constrains) {
                          var cardSize = constrains.maxWidth / 3 - 10;
                          return Wrap(
                            children: GlobalSettings.selectedProducts
                                .take(3)
                                .map((product) {
                              return SaleProductCard(
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

                      /// New Products
                      SectionTitle(
                        title: GlobalSettings.lang.newProducts,
                        moreButtonFunction: () {
                          /// Go to More Product Screen
                          Get.toNamed(moreProductsScreen, arguments: {
                            'products': GlobalSettings.newProducts,
                            'title': GlobalSettings.lang.newProducts,
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 0.0),
                        child:
                        LayoutBuilder(builder: (context, constrains) {
                          var cardSize = constrains.maxWidth / 3 - 10;
                          return Wrap(
                            children: GlobalSettings.newProducts
                                .take(3)
                                .map((product) {
                              return NewProductCard(
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
                    ],
                  ),
                );
              }),
        ) ,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 3,
        onPressed: (){},
        shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(50.0)
        ),
        child: const Icon(Icons.shopping_cart,color: Color(0xff8E8E93),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Material(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        clipBehavior: Clip.antiAlias,
        color: Colors.white10,
        child: BottomAppBar(
          shadowColor: Colors.black,
          elevation: 3,
          height: 70,
          color: Colors.white,
          notchMargin: 10,
          shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                    onPressed: (){},
                  child: Icon(Icons.home,color: primarySwatch,size: 35,),
                ),
                MaterialButton(
                  onPressed: (){},
                  child: Icon(Icons.list,color: Color(0xff8E8E93),size: 35,),
                ),
                MaterialButton(
                  onPressed: (){},
                  child: Icon(Icons.favorite,color: Color(0xff8E8E93),size: 35,),
                ),
                MaterialButton(
                  onPressed: (){},
                  child: Icon(Icons.person_pin,color: Color(0xff8E8E93),size: 35,),
                ),
              ],
            ),

        ),
      ),
    );
  }
}
