import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:task/business_logic/bloc/user/user_bloc.dart';
import 'package:task/constants/routes.dart';
import 'package:task/data/repositories/user_repository.dart';
import 'package:task/data/web_services/user_web_service.dart';
import 'package:task/presentation/screens/homeScreen.dart';
import 'package:task/presentation/screens/loginScreen.dart';
import 'package:task/presentation/screens/more_products.dart';
import 'business_logic/bloc/authentication/authentication_bloc.dart';
import 'constants/app_colors.dart';
import 'data/repositories/authentication_repository.dart';
import 'data/web_services/authentication_web_service.dart';
import 'l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return bloc.MultiBlocProvider(
      providers: [
        // bloc.BlocProvider<LocaleCubit>(
        //   create: (BuildContext context) => LocaleCubit(),
        // ),
        bloc.BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) => AuthenticationBloc(AuthenticationRepository(AuthenticationWebService())),
        ),
        bloc.BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(UserRepository(UserWebService())),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        //GlobalSettings.lang.appName,
        theme: ThemeData(
          primarySwatch: primarySwatchMaterialColor,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: primarySwatchMaterialColor),
          scaffoldBackgroundColor: const Color(0xFFFBF9F9),
        ),
        supportedLocales: L10n.supportedLocales,
        localizationsDelegates: L10n.localizationsDelegates,
        getPages: [
          GetPage(name: loginScreen, page: () => LoginScreen()),
          GetPage(name: homeScreen, page: () => HomeScreen()),
          GetPage(name: moreProductsScreen, page: () => MoreProductsScreen(
            products:Get.arguments['products'],
            title:Get.arguments['title'],

          )),
          // GetPage(
          //     name: otpScreen,
          //     page: () => OtpScreen(
          //       mrn: Get.arguments['mrn'],
          //       isLogin: Get.arguments!['isLogin'],
          //     )),
        ],
      ),
    );
  }
}