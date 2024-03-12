import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constant.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../widgets/our_button.dart';
import '../../../../widgets/our_text_field.dart';
import '../controllers/visa_controller.dart';

class VisaView extends GetView<VisaController> {
  const VisaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black54),
        leading: IconButton(onPressed: () {
          Get.back();
        }, icon: Icon(Icons.arrow_back_ios_new)),
        title: Text(
          "Visa",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [AppColors.splashDark, AppColors.splashLight],
              ),
            ),
            child: IconButton(
              onPressed: () {
                final _formKey = GlobalKey<FormState>();
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Create Visa Name",
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
                            height: 10.sp,
                          ),
                          OurTextField(hint: "Visa Name", controller: controller.visaName),
                          SizedBox(
                            height: 10.sp,
                          ),
                          OurButton(
                              onTap: () {
                                // if (_formKey.currentState!.validate()) {
                                //   context.loaderOverlay.show();
                                //   controller.addCustomer().then((value) {
                                //     context.loaderOverlay.hide();
                                //   }).onError((error, stackTrace) {
                                //     HelpingMethods.showToast(error.toString());
                                //     context.loaderOverlay.hide();
                                //   });
                                // }
                              },
                              title: 'Create')
                        ],
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add,color: Colors.white,),
            ),
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => controller.visaLists.isNotEmpty
              ? Expanded(
                  child: DataTable(
                    dataRowColor: MaterialStateProperty.all<Color>(Colors.grey.shade100),
                    headingRowColor: MaterialStateProperty.all<Color>(OurColor.highlightBG),
                    border: TableBorder(borderRadius: BorderRadius.circular(12.sp)),
                    columnSpacing: 2,
                    columns: [
                      DataColumn(
                        label: Text(
                          'Visa Name',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16.sp),
                        ),
                      ),
                    ],
                    rows: controller.visaLists.value.map((row) {
                      return DataRow(
                        cells: [
                          DataCell(
                            ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (bounds) => LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [AppColors.textAndOutlineTop, AppColors.textAndOutlineBottom],
                              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                              child: Text(
                                row['status'].toString().toUpperCase(),
                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black.withOpacity(0.75), fontSize: 15.5.sp),
                              ),
                            ),
                            showEditIcon: true,
                            onTap: () {
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
                                        "Update Visa Name",
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
                                        height: 10.sp,
                                      ),
                                      OurTextField(hint: "Visa Name", controller: controller.visaName),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      Padding(
                                        padding: MediaQuery.of(context).viewInsets,
                                        child: OurButton(
                                            onTap: () {
                                              if (controller.visaName.text.isNotEmpty) {
                                                context.loaderOverlay.show();
                                                controller.updateVisa(row['id'].toString()).whenComplete(() {
                                                  context.loaderOverlay.hide();
                                                });
                                              } else {
                                                HelpingMethods.showToast('Please fill fields to update.');
                                              }
                                            },
                                            title: 'Update'),
                                      ),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      Center(
                                          child: Text(
                                        "Or",
                                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                                      )),
                                      SizedBox(
                                        height: 10.sp,
                                      ),
                                      Padding(
                                        padding: MediaQuery.of(context).viewInsets,
                                        child: OurButton(
                                            isDelete: true,
                                            onTap: () {
                                              context.loaderOverlay.show();
                                              controller.deleteVisa(row['id'].toString()).then((v) {
                                                context.loaderOverlay.hide();
                                                Get.back();
                                              });
                                            },
                                            title: 'Delete'),
                                      ),
                                    ],
                                  ),
                                ),
                              ).whenComplete(() {
                                controller.visaName.clear();
                              });
                            },
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                )
              : Center(
                  child: Text(
                    "No data found.",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                )),
        ],
      ),
    );
  }
}
