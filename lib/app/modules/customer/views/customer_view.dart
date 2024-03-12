import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constant.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../widgets/our_button.dart';
import '../../../../widgets/our_text_field.dart';
import '../controllers/customer_controller.dart';

class CustomerView extends GetView<CustomerController> {
  const CustomerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black54),
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_new)),
        title: Text(
          "Customers",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [AppColors.splashDark, AppColors.splashLight],
                ),
              ),
              child: IconButton(
                onPressed: (){
                  final _formKey = GlobalKey<FormState>();
                 Get.dialog(
                     WillPopScope(onWillPop: () =>Future.value(false),
                       child: Center(
                         child: Container(
                           margin: EdgeInsets.all(16.0),
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(16.0)
                           ),
                           child: Padding(
                             padding: const EdgeInsets.all(16.0),
                             child: Material(
                                 child: Form(
                                   key: _formKey,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     mainAxisSize: MainAxisSize.min,
                                     children: [
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.end,
                                         children: [
                                           InkWell(
                                               onTap: (){
                                                 Get.back();
                                               },
                                               child: Icon(Icons.cancel,color: Colors.blueAccent,)),
                                         ],
                                       ),
                                       Text(
                                         "Create Customer",
                                         style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                                       ),
                                       SizedBox(
                                         height: 10.sp,
                                       ),
                                       Text(
                                         "Please fill the information below",
                                         style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                                       ),
                                       SizedBox(
                                         height: 15.sp,
                                       ),
                                       OurTextField(hint: "Enter Name", controller: controller.name),
                                       SizedBox(
                                         height: 14.sp,
                                       ),
                                       OurTextField(hint: "Enter Address", controller: controller.address),
                                       SizedBox(
                                         height: 14.sp,
                                       ),
                                       OurTextField(hint: "Enter ABN", controller: controller.abn),
                                       SizedBox(
                                         height: 14.sp,
                                       ),
                                       OurTextField(hint: "Enter ACN", controller: controller.acn),
                                       SizedBox(
                                         height: 18.sp,
                                       ),
                                       OurButton(
                                           onTap: () {
                                             if (_formKey.currentState!.validate()) {
                                               context.loaderOverlay.show();
                                               controller.addCustomer().then((value) {
                                                 context.loaderOverlay.hide();
                                               }).onError((error, stackTrace) {
                                                 HelpingMethods.showToast(error.toString());
                                                 context.loaderOverlay.hide();
                                               });
                                             }
                                           },
                                           title: 'Create')
                                     ],
                                   ),
                                 )),
                           ),
                         ),
                       ),)
                 );
                },
                // onPressed: () {
                //   final _formKey = GlobalKey<FormState>();
                //   showModalBottomSheet(
                //     context: context,
                //     isScrollControlled: true,
                //     builder: (context) => Padding(
                //       padding: MediaQuery.of(context).viewInsets,
                //       child: Padding(
                //         padding: const EdgeInsets.all(16.0),
                //         child: Form(
                //           key: _formKey,
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.stretch,
                //             mainAxisSize: MainAxisSize.min,
                //             children: [
                //               Text(
                //                 "Create Customer",
                //                 style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                //               ),
                //               SizedBox(
                //                 height: 10.sp,
                //               ),
                //               Text(
                //                 "Please fill the information below",
                //                 style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                //               ),
                //               SizedBox(
                //                 height: 10.sp,
                //               ),
                //               OurTextField(hint: "Name", controller: controller.name),
                //               SizedBox(
                //                 height: 10.sp,
                //               ),
                //               OurTextField(hint: "Address", controller: controller.address),
                //               SizedBox(
                //                 height: 10.sp,
                //               ),
                //               OurTextField(hint: "ABN", controller: controller.abn),
                //               SizedBox(
                //                 height: 10.sp,
                //               ),
                //               OurTextField(hint: "ACN", controller: controller.acn),
                //               SizedBox(
                //                 height: 10.sp,
                //               ),
                //               OurButton(
                //                   onTap: () {
                //                     if (_formKey.currentState!.validate()) {
                //                       context.loaderOverlay.show();
                //                       controller.addCustomer().then((value) {
                //                         context.loaderOverlay.hide();
                //                       }).onError((error, stackTrace) {
                //                         HelpingMethods.showToast(error.toString());
                //                         context.loaderOverlay.hide();
                //                       });
                //                     }
                //                   },
                //                   title: 'Create')
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   );
                // },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => controller.customersLists.isNotEmpty
            ? ListView(
                padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 0.sp),
                children: List.generate(
                    controller.customersLists.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 6.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(14.0),
                            // border: Border.all(
                            //   color: AppColors.textAndOutlineBottom,
                            //   width: 1.0,
                            // ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 3),
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5.0
                            )
                          ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/customers_group.png",
                                        width: 23.sp,
                                      ),
                                      SizedBox(width: 6.0,),
                                      ShaderMask(
                                        blendMode: BlendMode.srcIn,
                                        shaderCallback: (bounds) => LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [AppColors.textAndOutlineTop, AppColors.textAndOutlineBottom],
                                        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                                        child: Text(
                                          "CUSTOMER ID  #${controller.customersLists[index]['id']}",
                                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 16.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.name.text = controller.customersLists[index]['name'].toString();
                                            controller.address.text = controller.customersLists[index]['address'].toString();
                                            controller.abn.text = controller.customersLists[index]['abn'].toString();
                                            controller.acn.text = controller.customersLists[index]['acn'].toString();
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) => Padding(
                                                padding: const EdgeInsets.all(18.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "Update Customer",
                                                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      height: 5.sp,
                                                    ),
                                                    Text(
                                                      "Please fill the information below",
                                                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    OurTextField(hint: "Name", controller: controller.name),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    OurTextField(hint: "Address", controller: controller.address),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    OurTextField(hint: "ABN", controller: controller.abn),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    OurTextField(hint: "ACN", controller: controller.acn),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    Padding(
                                                      padding: MediaQuery.of(context).viewInsets,
                                                      child: OurButton(
                                                          onTap: () {
                                                            if (controller.name.text.isNotEmpty || controller.address.text.isNotEmpty) {
                                                              context.loaderOverlay.show();
                                                              controller.updateCustomer(controller.customersLists[index]['id'].toString()).whenComplete(() {
                                                                context.loaderOverlay.hide();
                                                              });
                                                            } else {
                                                              HelpingMethods.showToast('Please fill fields to update.');
                                                            }
                                                          },
                                                          title: 'Update'),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ).whenComplete(() {
                                              controller.address.clear();
                                              controller.name.clear();
                                              controller.abn.clear();
                                              controller.acn.clear();
                                            });
                                          },
                                          icon:  Image.asset('assets/Edit Square.png',height: 24,)),
                                      IconButton(
                                          onPressed: () {
                                            context.loaderOverlay.show();
                                            controller.deleteClient(controller.customersLists[index]['id'].toString()).then((value) async {
                                              await controller.getCustomers();
                                              context.loaderOverlay.hide();
                                            }).onError((error, stackTrace) {
                                              context.loaderOverlay.hide();
                                              HelpingMethods.showToast(error.toString());
                                            });
                                          },
                                          icon: Image.asset('assets/Delete.png',height: 24,)),
                                    ],
                                  )
                                ],
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Name: ",
                                        style: TextStyle(color: AppColors.textAndOutlineTop, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                      ),
                                      Text(
                                        controller.customersLists[index]['name'].toString(),
                                        style: TextStyle(color: AppColors.textAndOutlineColor, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Address: ",
                                        style: TextStyle(color: AppColors.textAndOutlineTop, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                      ),
                                      Text(
                                        controller.customersLists[index]['address'] ?? "NA",
                                        style: TextStyle(color: AppColors.textAndOutlineColor, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "ABN: ",
                                        style: TextStyle(color: AppColors.textAndOutlineTop, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                      ),
                                      Text(
                                        controller.customersLists[index]['abn'].toString(),
                                        style: TextStyle(color: AppColors.textAndOutlineColor, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "ACN: ",
                                        style: TextStyle(color: AppColors.textAndOutlineTop, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                      ),
                                      Text(
                                        controller.customersLists[index]['acn'] != "" ? controller.customersLists[index]['acn'] : "NA",
                                        style: TextStyle(color: AppColors.textAndOutlineColor, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Created: ",
                                        style: TextStyle(color: AppColors.textAndOutlineTop, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                      ),
                                      Text(
                                        controller.reformattedTime(controller.customersLists[index]['created_at'].toString()),
                                        style: TextStyle(color: AppColors.textAndOutlineColor, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
              )
            : Center(
                child: Text(
                  "No Customer found.",
                  style: TextStyle(fontSize: 16.sp, color: AppColors.textAndOutlineTop),
                ),
              ),
      ),
    );
  }
}
