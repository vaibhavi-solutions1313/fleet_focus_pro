import 'package:fleet_focus_pro/app/modules/splash/controllers/splash_controller.dart';
import 'package:fleet_focus_pro/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../helpers/helping_methods.dart';
import '../../../../plans_view.dart';
import '../../../routes/app_pages.dart';
import '../../client/controllers/client_controller.dart';
import '../../customer/controllers/customer_controller.dart';
import '../../driver/controllers/driver_controller.dart';
import '../../driver_number/controllers/driver_number_controller.dart';
import '../../job/controllers/job_controller.dart';
import '../../license_type/controllers/license_type_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../roaster/controllers/roaster_controller.dart';
import '../../truck/controllers/truck_controller.dart';
import '../../visa/controllers/visa_controller.dart';
import '../../wages/controllers/wages_controller.dart';

class OnboardingScreen extends GetView<SplashController> {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/onboarding_background.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.imageUrls.length,
                  onPageChanged: (index){
                    controller.currentPage.value = index;
                  },
                  itemBuilder: (context, index){
                    final images = controller.imageUrls[index];
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        height: 250,
                        width: 300,
                        margin: EdgeInsets.only(top: 80,),
                        child: Image.asset(
                          images,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 8),
              SmoothPageIndicator(
                controller: controller.pageController,
                count: controller.imageUrls.length,
                effect: ExpandingDotsEffect(
                  dotColor: Colors.white,
                  activeDotColor: AppColors.lightBlackishTextColor,
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 8,
                ),
              ),
              SizedBox(height: 70),
              Obx(() => Text(
                controller.introText[controller.currentPage.value],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold
                ),
              ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){
                        Get.toNamed('/dashboard');
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        gradient: LinearGradient(
                          colors: [Color(0xFFF2E8DC), Color(0xFFDBE0F3)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2.0, // Adjust spread radius as desired
                            blurRadius: 4.0, // Adjust blur radius as desired
                            offset: Offset(0, 2), // Adjust offset as desired
                          ),
                        ],
                      ),
                      child: Center(
                        child: TextButton(
                            onPressed: () async{
                              if(controller.currentPage.value < controller.imageUrls.length - 1){
                                controller.pageController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.bounceIn
                                );
                              } else{
                                if (box.read(StorageKeys.bearerToken) != null) {
                                  await controller.getUser().then((value) async {
                                    if (controller.userInfo.value['role_id'] == 2) {
                                      await Future.wait([
                                        controller.getUser(),
                                        controller.getVehicles(),
                                        Get.find<ProfileController>().getUserInfo(),
                                        Get.find<ClientController>().getClients(),
                                        Get.find<CustomerController>().getCustomers(),
                                        Get.find<LicenseTypeController>().getLicences(),
                                        Get.find<VisaController>().getVisa(),
                                        Get.find<DriverNumberController>().getDriversLists(),
                                        Get.find<DriverNumberController>().getDriverNumbers(),
                                        Get.find<TruckController>().getVehicleTypes(),
                                        Get.find<TruckController>().getVehiclesList(),
                                        Get.find<DriverController>().getDriverLists(),
                                        Get.find<JobController>().getJobs(),
                                        Get.find<WagesController>().getWages(),
                                        Get.find<RoasterController>().getRoaster(),
                                        controller.getLicenseState(),
                                        controller.getLicenseTypes()
                                      ]);
                                      if (value.data['isPlanExpireOrNot'] == true) {
                                        Get.to(const PlansView(), transition: Transition.rightToLeft);
                                      } else {
                                        Get.toNamed(Routes.DASHBOARD);
                                      }
                                    } else {
                                      HelpingMethods.showToast("Sorry! You're unauthorized user.");
                                    }
                                  });
                                } else {
                                  Get.toNamed(Routes.LOGIN);
                                }
                              }
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              size: 24,
                              color: Colors.black,
                              weight: 2.0,
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      )
      // backgroundColor: LinearGradient(
      //   begin: Alignment.bottomRight,
      //   end: Alignment.topLeft,
      //   colors: [Color(0xFFB2D7EA), Color(0xFFF2E8DC)],
      // ).colors.first,
    );
  }
}