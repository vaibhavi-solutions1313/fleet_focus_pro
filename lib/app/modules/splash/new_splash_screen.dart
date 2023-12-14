
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant.dart';
import 'controllers/splash_controller.dart';
class NewSplashScreen extends GetView<SplashController>{
  const NewSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(100.0)),
                gradient: LinearGradient(colors: [AppColors.appPrimaryColor,AppColors.appPrimaryLightColor],begin: Alignment.center)
              ),
              child: Image.asset('assets/staffin_logo.png',width: Get.width/3,),
            ),
          ),
          TextButton(onPressed: (){
            // controller.
          }, child: const Text('Get Started'))
        ],
      ),
    );
  }

}