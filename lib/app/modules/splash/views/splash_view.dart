import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/circular_reveal_clipper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../constant.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.vertical(bottom: Radius.circular(80.0)),
                  gradient: LinearGradient(
                      colors: [AppColors.appPrimaryColor, AppColors.appPrimaryLightColor, AppColors.appPrimaryLightColor], end: Alignment.topCenter,begin: Alignment.bottomCenter)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/location-sharp.png',width: Get.width*0.3,height: Get.width*0.3,fit: BoxFit.fill,),
                    Image.asset('assets/Group 1000005741.png',width: Get.width*0.5,fit: BoxFit.fill,),
                  ],
                ),
              ),
            ),
          ),
        ),
        TextButton(
            onPressed: () {
              // controller.
            },
            child: const Text('Get Started'))
      ],
    )
        // body: Stack(
        //   children: [
        //     Image.asset(
        //       "assets/splash_view.png",
        //       width: Get.width,
        //       height: Get.height,
        //       fit: BoxFit.cover,
        //     ),
        //     Positioned(bottom: 35.sp,right: 0,left: 0,child: Center(child: SizedBox(width: 25.sp,height: 10.sp,child: LinearProgressIndicator())))
        //   ],
        // )
        );
  }
}

class MyCustomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path=Path();

    // path.moveTo(0,  0);
    path.lineTo(0, size.height*0.9);
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height*0.9);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
