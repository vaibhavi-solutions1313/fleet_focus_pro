import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../app/modules/driver/views/salary_list_view.dart';
import '../app/modules/profile/controllers/profile_controller.dart';
import '../app/modules/splash/controllers/splash_controller.dart';
import '../app/modules/truck/views/truck_types_view.dart';
import '../app/routes/app_pages.dart';
import '../constant.dart';

class OurDrawer extends StatelessWidget {
  const OurDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? expiryDate = DateTime.tryParse(Get.find<SplashController>().userInfo.value['planEndDate'].toString());
    String formattedDate = expiryDate != null ? DateFormat.yMMMMd().format(expiryDate!) : "NA";
    return Drawer(
      child: ListView(
        children: [
          Stack(
            children: [
              Positioned(
                left: -40,
                top: -20,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.appPrimaryColor,
                ),
              ),
              Positioned(
                right: -30,
                top: -20,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.appPrimaryColor,
                ),
              ),
              Container(

                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(12.0),
                  color: AppColors.appPrimaryLightColor.withOpacity(0.8)
                ),
                child: Row(
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          // color: Colors.blueGrey,
                          margin: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
                          width: 35.sp,
                          height: 35.sp,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2.0,color: AppColors.appPrimaryLightColor),
                          borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.5, 0.5),
                                spreadRadius: -0.3,
                                color: Colors.white60,
                                blurRadius: 6.0
                              )
                            ]
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              Get.find<SplashController>().userInfo.value['profile_photo_path'] ?? '${Get.find<SplashController>().userInfo.value['profile_photo_url']}&format=png',
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.image_not_supported,
                                size: 18.sp,
                                color: Colors.black54,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),

                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.sp,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Get.find<SplashController>().userInfo.value['name'] ?? "NA",
                                style: GoogleFonts.lato(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.w700),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: InkWell(
                                    onTap: () async {
                                      context.loaderOverlay.show();
                                      await Get.find<ProfileController>().getUserInfo();
                                      context.loaderOverlay.hide();
                                      Get.toNamed(Routes.PROFILE);
                                    },
                                    child: Image.asset(
                                      'assets/edit_icon.png',
                                      width: 22.sp,
                                      height: 22.sp,
                                        color: Colors.white
                                    )),
                              )
                            ],
                          ),
                          // Text(
                          //   Get.find<SplashController>().userInfo.value['email'] ?? "NA",
                          //   style: TextStyle(color: Colors.black.withOpacity(0.75), fontSize: 15.sp, fontWeight: FontWeight.w500),
                          // ),
                          Wrap(
                            children: [
                              Text(
                                "Premium expires at",
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Color(0xFFE51919)),
                              ),
                              SizedBox(
                                width: 8.sp,
                              ),
                              Text(
                                formattedDate,
                                maxLines: 2,
                                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

          // DrawerHeader(
          //   padding: EdgeInsets.symmetric(horizontal: 18.sp),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     children: [
          //       Align(
          //         alignment: Alignment.centerLeft,
          //         child: ClipRRect(
          //           borderRadius: BorderRadius.circular(50.sp),
          //           child: Container(
          //             // color: Colors.blueGrey,
          //             width: 38.sp,
          //             height: 38.sp,
          //             child: Image.network(Get.find<SplashController>().userInfo.value['profile_photo_url'] + '&format=png'),
          //           ),
          //         ),
          //       ),
          //       SizedBox(
          //         height: 15.sp,
          //       ),
          //       Text(
          //         Get.find<SplashController>().userInfo.value['name'],
          //         style: TextStyle(color: Colors.black.withOpacity(0.75), fontSize: 15.sp, fontWeight: FontWeight.w500),
          //       ),
          //       Text(
          //         Get.find<SplashController>().userInfo.value['email'],
          //         style: TextStyle(color: Colors.black.withOpacity(0.75), fontSize: 15.sp, fontWeight: FontWeight.w500),
          //       ),
          //     ],
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     Get.to(PlansView(), transition: Transition.cupertino);
          //   },
          //   child: Container(
          //     color: Colors.deepPurple,
          //     padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 15.sp),
          //     child: Row(
          //       children: [
          //         Text(
          //           "Premium",
          //           style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.deepOrange),
          //         ),
          //         SizedBox(
          //           width: 10.sp,
          //         ),
          //         Text(
          //           "expires at $formattedDate",
          //           style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     Get.toNamed(Routes.DASHBOARD);
          //   },
          //   leading: ImageIcon(AssetImage('assets/drawer_icons/2 User.png')),
          //   title: Text(
          //     "Dashboard",
          //     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
          //   ),
          // ),
          ExpansionTile(
              childrenPadding: EdgeInsets.symmetric(horizontal: 10.sp),
              leading: ImageIcon(AssetImage('assets/drawer_icons/wallet-outline 1.png')),
              title: Text(
                'Master',
                style: GoogleFonts.lato(fontWeight: FontWeight.w500, fontSize: 17.sp),
              ),
              children: [
                // ListTile(
                //   onTap: () {
                //     Get.toNamed(Routes.CLIENT);
                //   },
                //   title: Text(
                //     "Clients",
                //     style: TextFonts.subtitle,
                //   ),
                // ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.CUSTOMER);
                  },
                  title: Text(
                    "Customers",
                    style: TextFonts.subtitle,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.LICENSE_TYPE);
                  },
                  title: Text(
                    "Licence Types",
                    style: TextFonts.subtitle,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.VISA);
                  },
                  title: Text(
                    "Visa",
                    style: TextFonts.subtitle,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Get.toNamed(Routes.DRIVER_NUMBER);
                  },
                  title: Text("Driver Number", style: TextFonts.subtitle),
                ),
              ]),
          ExpansionTile(
            leading: ImageIcon(AssetImage('assets/drawer_icons/2 User.png')),
            title: Text(
              'Employees',
              style: GoogleFonts.lato(fontWeight: FontWeight.w500, fontSize: 17.sp),
            ),
            children: [
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.DRIVER);
                },
                title: Text(
                  "Drivers List",
                  style: TextFonts.subtitle,
                ),
              ),
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.ROASTER);
                },
                title: Text(
                  "Roaster",
                  style: TextFonts.subtitle,
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(SalaryListView(), transition: Transition.rightToLeft);
                },
                title: Text(
                  "Salaries",
                  style: TextFonts.subtitle,
                ),
              ),
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.INVOICE);
                },
                title: Text(
                  "Invoices",
                  style: TextFonts.subtitle,
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: ImageIcon(AssetImage('assets/drawer_icons/Frame.png')),
            title: Text(
              'Trucks',
              style: GoogleFonts.lato(fontWeight: FontWeight.w500, fontSize: 17.sp),
            ),
            children: [
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.TRUCK);
                },
                title: Text(
                  "Trucks",
                  style: TextFonts.subtitle,
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(TruckTypesView());
                },
                title: Text(
                  "Truck Types",
                  style: TextFonts.subtitle,
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: ImageIcon(AssetImage('assets/drawer_icons/Ticket Star.png')),
            title: Text(
              'Wages',
              style: GoogleFonts.lato(fontWeight: FontWeight.w500, fontSize: 17.sp),
            ),
            children: [
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.WAGES);
                },
                title: Text(
                  "Wages",
                  style: TextFonts.subtitle,
                ),
              ),
            ],
          ),
          ExpansionTile(
            leading: ImageIcon(AssetImage('assets/drawer_icons/Add User.png')),
            title: Text(
              'Jobs',
              style: GoogleFonts.lato(fontWeight: FontWeight.w500, fontSize: 17.sp),
            ),
            children: [
              ListTile(
                onTap: () {
                  Get.toNamed(Routes.JOB);
                },
                title: Text(
                  "Jobs List",
                  style: TextFonts.subtitle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
