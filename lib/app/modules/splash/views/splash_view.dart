import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../constant.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 2000),
  );

  @override
  void initState() {
    super.initState();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose of the controller on widget disposal
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/splash_background.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Center(
                  child: ScaleTransition(
                    // scale: _animationController,
                    scale: Tween<double>(begin: 0.3, end: 1.0)
                        .animate(_animationController),
                    child: Image.asset(
                      'assets/fleet_focus_logo.png',
                      width: 400,
                      height: 250,
                    ),
                  ),
                )
              ],
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(15.0),
            onTap: () {
                Get.toNamed('/onboarding');
            },
            child: Container(
              height: 50,
              width: 154,
              margin: EdgeInsets.only(top: 15.0, bottom: 30.0),
              padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [AppColors.splashDark, AppColors.splashLight],
                ),
              ),
              // style: ElevatedButton.styleFrom(backgroundColor: isDelete ? Colors.red :OurColor.highlightBG, padding: EdgeInsets.symmetric(vertical: 14.sp, horizontal: 15.sp)),
              // onPressed: onTap,
              child: Center(
                child: Text(
                  'Get Started',
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          )
        ],
      ),
      /*Column(
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
    )*/
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

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // path.moveTo(0,  0);
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
    // throw UnimplementedError();
  }
}
