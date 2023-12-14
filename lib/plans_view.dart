import 'package:fleet_focus_pro/widgets/stripe_payment_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app/modules/splash/controllers/splash_controller.dart';
import 'constant.dart';
import 'helpers/api_helper.dart';
import 'helpers/helping_methods.dart';

Future<ApiResponse<dynamic>> subscribePlan(String planId, String paymentId, String amount) async {
  networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
  return networkHelper.postFormData(Endpoints.purchasePlan, {"plan_id": planId, "payment_id": paymentId, "amount": amount}, []);
}

class PlansView extends StatefulWidget {
  const PlansView({super.key});

  @override
  State<PlansView> createState() => _PlansViewState();
}

class _PlansViewState extends State<PlansView> {
  Future getPlans() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return networkHelper.fetchData(Endpoints.getPlans).then((value) {
      return value.data['data'].where((element) => element['status'] == 1).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Available Plans",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: getPlans(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data.isNotEmpty) {
            List data = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 15.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.sp),
                  child: Text(
                    "Checkout our plans!!",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22.sp),
                  ),
                ),
                SizedBox(
                  height: 4.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.sp),
                  child: Text(
                    "You can try our trail plan and its free.",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp, color: Colors.black54),
                  ),
                ),
                SizedBox(
                  height: 15.sp,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                        child: GestureDetector(
                          onTap: () {
                            // int totalCents = int.parse((double.parse(data[index]['price'].toString()) * 100).toString());
                            if(data[index]['id'] == 1) {
                              DateTime? accountCreatedDate = DateTime.tryParse(Get.find<SplashController>().userInfo.value['created_at']);
                              var diff = DateTime.now().difference(accountCreatedDate!);
                              if(diff.inDays > data[index]['days']) {
                                HelpingMethods.showToast("You're already using this plan.");
                              } else {
                                HelpingMethods.showToast("You've already claimed this offer.");
                              }
                            } else {
                              makePayment(context, data[index]['price'].toString(), "AUD", data[index]['id'].toString());
                            }

                          },
                          child: Card(
                            elevation: 5,
                            surfaceTintColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(15.0.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '\$${data[index]['price']}',
                                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.indigo),
                                      ),
                                      Text(
                                        data[index]['name'],
                                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.pink),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.sp,
                                  ),
                                  Text(
                                    '${data[index]['days']}Days',
                                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.teal),
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Text(
                                    data[index]['description'],
                                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text(
                "Unable to fetch plans, try again later",
                style: TextStyle(color: Colors.black87),
              ),
            );
          }
        },
      ),
    );
  }
}
