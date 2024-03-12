import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:get/get.dart';

import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constant.dart';
import '../../../../map_view_drivers.dart';
import '../../../routes/app_pages.dart';
import '../../driver/views/salary_list_view.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../splash/controllers/splash_controller.dart';
import '../../truck/views/truck_types_view.dart';
import '../controllers/dashboard_controller.dart';
import 'gridItem_widget.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();

    var splashControl = Get.find<SplashController>();

    return Scaffold(
        key: _key,
        backgroundColor: OurColors.scaffold,
        // drawer: const OurDrawer(),
        appBar:AppBar(
          backgroundColor: AppColors.canvasColor,
          scrolledUnderElevation: 0.0,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          toolbarHeight: 80.0,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Image.asset(
              "assets/fleet_focus_logo.png",
              // width: 50.sp,
              height: 50.sp,
            ),
          ),
          leading: Container(
            margin: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0),
            child: Material(
              borderRadius: BorderRadius.circular(50.0),
              elevation: 5.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: IconButton(
                  tooltip: 'Track Driver\'s Location',
                  onPressed: () {
                    // _key.currentState!.openDrawer();
                    Get.to(() => MapDriversView(
                      // isHome: true,
                    ),);
                  },
                  icon: Icon(
                      Icons.location_on,
                      size: 28,
                      // color: Colors.blue
                      color: AppColors.textAndOutlineColor
                  ),
                ),
              ),
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 10.0),
              child: Material(
                borderRadius: BorderRadius.circular(50.0),
                elevation: 5.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: IconButton(
                    // padding: EdgeInsets.all(16.0),
                    tooltip: 'My Profile',
                    onPressed: () async {
                      context.loaderOverlay.show();
                      await Get.find<ProfileController>().getUserInfo();
                      context.loaderOverlay.hide();
                      Get.toNamed('/profile');
                    },
                    icon: Icon(Icons.person_outline_rounded, size: 24, color: AppColors.textAndOutlineColor,),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 15.sp),
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
                          RichText(
                            text: TextSpan(
                                text: "Welcome back, ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black.withOpacity(0.80)),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                    '${splashControl.userInfo.value['name']}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color:
                                        Colors.black.withOpacity(0.80)),
                                  )
                                ]),
                          ),
                          Text(
                            "Ref Code : ${splashControl.userInfo.value['ref_code']}",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black.withOpacity(0.80)),
                          ),
                        ],
                      )),
                    ),
                  ),
                  CarouselSlider(
                    carouselController: controller.carouselController,
                    options: CarouselOptions(
                        viewportFraction: 1.0,
                        height: 200.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(milliseconds: 3000),
                        pauseAutoPlayOnManualNavigate: true,
                        autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                        onPageChanged: (index, _) {
                          controller.currentPage.value = index;
                        }),
                    items: controller.sliderList.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset(
                              image,
                              fit: BoxFit.fill,
                              width: Get.width,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  /*Obx(() => GridView(
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
                    )),*/
                  /*SizedBox(
                  height: 10.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 4.sp),
                  child: Text(
                    "Driver Locations",
                    style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                ),*/
                ],
              ),
            ),

            /// Icons gallery
            // GridView.builder(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 3,
            //     crossAxisSpacing: 8.0,
            //     mainAxisSpacing: 8.0,
            //     // childAspectRatio: 1.0,
            //   ),
            //   itemCount: controller.gridItemList.length,
            //   itemBuilder: (context, index) {
            //     final gridItems = controller.gridItemList[index];
            //     return InkWell(
            //       onTap: (){
            //         switch(gridItems) {
            //           case 'Salary':
            //             Get.toNamed(Routes.INVOICE);
            //             break;
            //           case 'Roaster':
            //             Get.toNamed(Routes.ROASTER);
            //             break;
            //           case 'Payment':
            //             Get.toNamed(Routes.WAGES);
            //             break;
            //           case 'Trucks':
            //             Get.toNamed('/truck');
            //             break;
            //           default:
            //             Get.toNamed('/customer');
            //         }
            //         // if(controller.gridItemList[index].text == 'Salary'){
            //         //   Get.toNamed(Routes.INVOICE);
            //         // } else if(controller.gridItemList[index].text == 'Roaster'){
            //         //   Get.toNamed(Routes.ROASTER);
            //         // } else if(controller.gridItemList[index].text == 'Payment'){
            //         //   Get.toNamed(Routes.WAGES);
            //         // } else if(controller.gridItemList[index].text == 'Trucks'){
            //         //   Get.toNamed('/truck');
            //         // } else{
            //         //   Get.toNamed('/customer');
            //         // }
            //       },
            //         child: GridItemWidget(item: gridItems));
            //   },
            // ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // First item of first row
                    InkWell(
                      onTap: () => Get.toNamed(Routes.INVOICE),
                      // Assuming first item is 'Salary'
                      child: GridItemWidget(item: controller.gridItemList[0]),
                    ),
                    // SizedBox(height: 16.0),
                    // Second item of first row
                    InkWell(
                      onTap: () => Get.toNamed(Routes.ROASTER),
                      // Assuming second item is 'Roaster'
                      child: GridItemWidget(item: controller.gridItemList[1]),
                    ),
                    // Third item of first row
                    InkWell(
                      onTap: () => Get.toNamed(Routes.WAGES),
                      // Assuming third item is 'Payment'
                      child: GridItemWidget(item: controller.gridItemList[2]),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Fourth item (first item of second row)
                    InkWell(
                      onTap: () => Get.toNamed('/truck'),
                      // Assuming fourth item is 'Trucks'
                      child: GridItemWidget(item: controller.gridItemList[3]),
                    ),
                    // Fifth item (second item of second row)
                    InkWell(
                      onTap: () => Get.toNamed('/customer'),
                      // Assuming centered item is 'Customer'
                      child: GridItemWidget(item: controller.gridItemList[4]),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            /// master
            Container(
              margin: EdgeInsets.only(top: 15.0, left: 10, bottom: 10.0),
              child: Text(
                'Master',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.masterItemList.length,
                itemBuilder: (context, index) {
                  final masterItem = controller.masterItemList[index];
                  return Container(
                    // padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        switch (masterItem.text) {
                          case 'Customer':
                            Get.toNamed(Routes.CUSTOMER);
                            break;
                          case 'License Types':
                            Get.toNamed(Routes.LICENSE_TYPE);
                            break;
                          case 'Visa':
                            Get.toNamed(Routes.VISA);
                            break;
                          default:
                            Get.toNamed(Routes.DRIVER_NUMBER);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 250,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                image: AssetImage(masterItem.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Text(
                              masterItem.text,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: SizedBox(
            //     height: Get.height/4,
            //     child:
            //
            //   ),
            // ),

            /// employees
            Container(
              margin: EdgeInsets.only(top: 15.0, left: 10, bottom: 10.0),
              child: Text(
                'Employees',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.employeeItemList.length,
                itemBuilder: (context, index) {
                  final employeeItem = controller.employeeItemList[index];
                  return Container(
                    // padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        switch (employeeItem.text) {
                          case 'Driver List':
                            Get.toNamed(Routes.DRIVER);
                            break;
                          case 'Roaster':
                            Get.toNamed(Routes.ROASTER);
                            break;
                          case 'Payment':
                            Get.to(SalaryListView(),
                                transition: Transition.rightToLeft);
                            break;
                          default:
                            Get.toNamed(Routes.INVOICE);
                        }
                        // if(controller.employeeItemList[index].text == ){
                        //   Get.toNamed(Routes.DRIVER);
                        // } else if(controller.employeeItemList[index].text == 'Roaster'){
                        //   Get.toNamed(Routes.ROASTER);
                        // } else if(controller.employeeItemList[index].text == 'Payment'){
                        //   Get.to(SalaryListView(), transition: Transition.rightToLeft);
                        // } else{
                        //   Get.toNamed(Routes.INVOICE);
                        // }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 250,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                image: AssetImage(employeeItem.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Text(
                              employeeItem.text,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /// trucks
            Container(
              margin: EdgeInsets.only(top: 15.0, left: 10, bottom: 10.0),
              child: Text(
                'Trucks',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.truckItemList.length,
                itemBuilder: (context, index) {
                  final trucksItem = controller.truckItemList[index];
                  return Container(
                    // padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        switch (trucksItem.text) {
                          case 'Truck List':
                            Get.toNamed(Routes.TRUCK);
                            break;
                          default:
                            Get.to(TruckTypesView());
                        }
                        // if(controller.truckItemList[index].text == 'Truck List'){
                        //   Get.toNamed(Routes.TRUCK);
                        // } else{
                        //   Get.to(TruckTypesView());
                        // }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 250,
                            height: 160, // Adjust the height as needed
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                image: AssetImage(trucksItem.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Text(
                              trucksItem.text,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /// wages
            Container(
              margin: EdgeInsets.only(top: 15.0, left: 10, bottom: 10.0),
              child: Text(
                'Wages',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.wagesItemList.length,
                itemBuilder: (context, index) {
                  final wagesItem = controller.wagesItemList[index];
                  return Container(
                    // padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.WAGES);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 250,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                image: AssetImage(wagesItem.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Text(
                              wagesItem.text,
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /// jobs
            Container(
              margin: EdgeInsets.only(top: 15.0, left: 10),
              child: Text(
                'Jobs',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.jobItemList.length,
                itemBuilder: (context, index) {
                  final jobItem = controller.jobItemList[index];
                  return Container(
                    // padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.JOB);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 250,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                image: AssetImage(jobItem.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Text(
                              jobItem.text,
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /*Expanded(
            child: SizedBox(
              width: Get.width,
              // height: Get.width,
              child: const MapDriversView(
                isHome: true,
              ),
            ),
          ),*/
          ],
        )
    );
  }
}
