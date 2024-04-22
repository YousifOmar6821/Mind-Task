import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task/business_logic/bloc/authentication/authentication_bloc.dart';
import 'package:task/constants/app_colors.dart';
import 'package:task/constants/routes.dart';
import 'package:task/data/local/global_settings.dart';
import 'package:task/presentation/widgets/custom_text.dart';
import '../../business_logic/bloc/user/user_bloc.dart';
import '../../business_logic/bloc/user/user_event.dart';
import '../../generated/assets.dart';
import '../../services/language_manager.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/toast.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  bool listen = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10.0),
          child: GestureDetector(
            child: const Icon(
              Icons.language,
              size: 30,
            ),
            onTap: () =>
                LanguageManager.switchLanguage(context,'login'),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:  const EdgeInsets.all(30.0),
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
            listenWhen: (previousState, state) => listen,
            listener: (BuildContext context, AuthenticationState state) { 
              if (state is LoginSuccess) {
                GlobalSettings.user=state.user;
                GlobalSettings.password=passwordController.text;

                Get.offNamed(homeScreen);
              }
              else if (state is LoginError) {
                MyToast.showToast(state.errMsg.toString(),Colors.red);
              }  
            },
            child: Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Center(
                      child: SizedBox(
                        width: Get.width * 0.4,
                        height: Get.width * 0.3,
                        child: Image.asset(
                          Assets.imagesLoginImage,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                   CText(
                     GlobalSettings.lang.welcome,
                     style: const TextStyle(
                       fontSize: 40,
                     ),
                   ),
                  const SizedBox(height: 30,),
                  TextFormField(
                    validator:(value) {
                      if (value!.isEmpty) {
                        // Check if email field is empty
                        return GlobalSettings.lang.emailValidator;
                      }
                    },
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: SizedBox(
                        width: Get.width * 0.05,
                        height: Get.width * 0.05,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            Assets.iconsEmailPrefix,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      hintText: GlobalSettings.lang.email,
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(15.0), // Add border radius here
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    validator:(value) {
                      if (value!.isEmpty) {
                        // Check if email field is empty
                        return GlobalSettings.lang.passwordValidator;
                      }
                    },
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: SizedBox(
                        width: Get.width * 0.02,
                        height: Get.width * 0.02,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            Assets.iconsPasswordPrefix,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      hintText: GlobalSettings.lang.email,
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(15.0), // Add border radius here
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: (){
                          /// Go To Forget Password Screen Screen
                        },
                        child:CText(
                          textAlign: TextAlign.end,
                          GlobalSettings.lang.forgetPassword,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xff999999),
                          ),
                        )
                      ),
                    ],
                  ),
                  // const SizedBox(height: 10,),
                  CSizedButton(

                    onPressed: (){
                      /// Login Function
                      if (_loginFormKey.currentState!.validate()) {
                      BlocProvider.of<AuthenticationBloc>(context).add(Login(email: emailController.text, password: passwordController.text));

                      } else {
                        MyToast.showToast(GlobalSettings.lang.enterValidData,Colors.red);
                      }

                    },
                    text: GlobalSettings.lang.login,
                    color: primarySwatch,
                    height: Get.height * 0.07,
                    width: double.infinity,
                    textSize: 24,
                    circularRadius: 18,
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CText(
                        textAlign: TextAlign.end,
                        GlobalSettings.lang.doNotHaveAccount,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xff999999),
                        ),
                      ),
                      TextButton(
                          onPressed: (){
                            /// Go To Register Screen
                          },
                          child:CText(
                            textAlign: TextAlign.end,
                            GlobalSettings.lang.registerNow,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                            ),
                          ) ,
                      )
                    ],
                  ),
                  const SizedBox(height: 40,),
                  const CText(
                    'Or Sign in With',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff757575),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xffF5F6F9),
                        radius: 15,
                        child:SizedBox(
                          // width: Get.width * 0.4,
                          // height: Get.width * 0.3,
                          child: Image.asset(
                            Assets.imagesGoogle,
                            fit: BoxFit.contain,
                          ),
                        ) ,
                      ),
                      const SizedBox(width: 15,),
                      CircleAvatar(
                        backgroundColor: const Color(0xffF5F6F9),
                        radius: 15,
                        child:SizedBox(
                          // width: Get.width * 0.4,
                          // height: Get.width * 0.3,
                          child: Image.asset(
                            Assets.imagesApple,
                            fit: BoxFit.contain,
                          ),
                        ) ,
                      ),
                      const SizedBox(width: 15,),
                      CircleAvatar(
                        backgroundColor: const Color(0xffF5F6F9),
                        radius: 15,
                        child:SizedBox(
                          // width: Get.width * 0.4,
                          // height: Get.width * 0.3,
                          child: Image.asset(
                            Assets.imagesFacbook,
                            fit: BoxFit.contain,
                          ),
                        ) ,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
