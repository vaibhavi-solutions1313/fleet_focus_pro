import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constant.dart';
import '../../../../map_view_drivers.dart';
import '../../../../widgets/dashboard_main_card.dart';
import '../../../../widgets/our_drawer.dart';
import '../../../routes/app_pages.dart';
import '../../customer/controllers/customer_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../roaster/controllers/roaster_controller.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();


    var splashControl = Get.find<SplashController>();

    return Scaffold(
      key: _key,
      backgroundColor: OurColors.scaffold,
      drawer: const OurDrawer(),
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        leading: IconButton(
          onPressed: () {
            _key.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu, color: Colors.blue),
        ),
        centerTitle: true,
        title: Image.asset(
          "assets/staffin_logo.png",
          // width: 50.sp,
          height: 52.sp,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0.sp),
            child: IconButton(
              onPressed: () async {
                context.loaderOverlay.show();
                await Get.find<ProfileController>().getUserInfo();
                context.loaderOverlay.hide();
                Get.toNamed('/profile');
              },
              icon: Image.asset("assets/Profile.png"),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SafeArea(
                  top: true,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Welcome back, ${splashControl.userInfo.value['name']}",
                              style: TextStyle(fontSize: 14.5.sp, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.80)),
                            ),
                            Text(
                              "Ref Code : ${splashControl.userInfo.value['ref_code']}",
                              style: TextStyle(fontSize: 14.5.sp, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.80)),
                            ),
                          ],
                        )),
                  ),
                ),
                Obx(() => GridView(
                      padding: EdgeInsets.symmetric(vertical: 15.sp),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 9 / 6),
                      children: [
                        DashboardMainCard(
                          title: 'Salary',
                          trailingIcon: '\$',
                          value: "52",
                          color: Color(0xFF5A37FF),
                          leadingIcon: Container(
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                color: Color(0xffEEEBFF),
                              shape: BoxShape.circle
                            ),
                            child: Icon(
                              Icons.attach_money,
                              color:Color(0xFF5A37FF),
                              size: 20.sp,
                            ),
                          ),
                          onTap: () {
                            Get.toNamed(Routes.INVOICE);
                          },
                        ),
                        DashboardMainCard(
                          title: 'Roaster',
                          trailingIcon: '\$',
                          value: Get.find<RoasterController>().roasterInfo.length.toString(),
                          color: Color(0xFFDC56D6),
                          leadingIcon: Container(
                            decoration: BoxDecoration(color: Color(0xFFFFF0FE), borderRadius: BorderRadius.circular(25.sp)),
                            padding: EdgeInsets.all(10.sp),
                            child: Icon(
                              Icons.calendar_month,
                              color: Color(0xFFDC56D6),
                              size: 20.sp,
                            ),
                          ),
                          onTap: () {
                            Get.toNamed(Routes.ROASTER);
                          },
                        ),
                        DashboardMainCard(
                          title: 'Wages',
                          trailingIcon: '@',
                          value: "12",
                          color: Colors.green,
                          leadingIcon: Container(
                            decoration: BoxDecoration(color: Colors.green.shade300, borderRadius: BorderRadius.circular(25.sp)),
                            padding: EdgeInsets.all(10.sp),
                            child: Icon(
                              Icons.money_outlined,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                          onTap: () {
                            Get.toNamed(Routes.WAGES);
                          },
                        ),
                        DashboardMainCard(
                          title: 'Vehicles',
                          color: Color(0xFF7D000F),
                          value: splashControl.vehiclesList.value.length.toString(),
                          leadingIcon: Image.asset(
                            "assets/vehicle_group.png",
                            width: 25.sp,
                          ),
                          onTap: () {
                            Get.toNamed('/truck');
                          },
                        ),
                        DashboardMainCard(
                          title: 'Customers',
                          value: Get.find<CustomerController>().customersLists.length.toString(),
                          color: Color(0xFFF3B421),
                          leadingIcon: Image.asset(
                            "assets/customers_group.png",
                            width: 25.sp,
                          ),
                          onTap: () {
                            Get.toNamed('/customer');
                          },
                        ),



                      ],
                    )),
                SizedBox(
                  height: 10.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 4.sp),
                  child: Text(
                    "Driver Locations",
                    style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: Get.width,
              // height: Get.width,
              child: const MapDriversView(
                isHome: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
