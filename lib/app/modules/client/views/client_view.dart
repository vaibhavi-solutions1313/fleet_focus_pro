import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../constant.dart';
import '../../../../helpers/helping_methods.dart';
import '../../../../widgets/our_button.dart';
import '../../../../widgets/our_text_field.dart';
import '../controllers/client_controller.dart';

class ClientView extends GetView<ClientController> {
  const ClientView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: OurColors.cardBG,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.blue),
        title: Text(
          "Clients",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              final _formKey = GlobalKey<FormState>();
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Create Client",
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
                          OurTextField(hint: "Name", controller: controller.name),
                          SizedBox(
                            height: 10.sp,
                          ),
                          OurTextField(hint: "Amount", controller: controller.name),
                          SizedBox(
                            height: 10.sp,
                          ),
                          OurButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  context.loaderOverlay.show();
                                  controller.addClient().then((value) {
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
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(() => controller.clientsList.isNotEmpty
          ? ListView(
              padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 10.sp),
              children: List.generate(
                  controller.clientsList.length,
                  (index) => Card(
                        color: Colors.grey.shade200,
                        surfaceTintColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "CLIENT ID  #${controller.clientsList[index]['id']}",
                                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
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
                                                      "Update Client",
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
                                                    OurTextField(hint: "Name", controller: controller.name),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    OurTextField(hint: "Amount", controller: controller.amount),
                                                    SizedBox(
                                                      height: 10.sp,
                                                    ),
                                                    Padding(
                                                      padding: MediaQuery.of(context).viewInsets,
                                                      child: OurButton(
                                                          onTap: () {
                                                            if (controller.name.text.isNotEmpty || controller.amount.text.isNotEmpty) {
                                                              context.loaderOverlay.show();
                                                              controller.updateClient(controller.clientsList[index]['id'].toString()).whenComplete(() {
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
                                              controller.amount.clear();
                                              controller.name.clear();
                                            });
                                          },
                                          icon: const Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            context.loaderOverlay.show();
                                            controller.deleteClient(controller.clientsList[index]['id'].toString()).then((value) {
                                              context.loaderOverlay.hide();
                                            }).onError((error, stackTrace) {
                                              context.loaderOverlay.hide();
                                              HelpingMethods.showToast(error.toString());
                                            });
                                          },
                                          icon: const Icon(Icons.delete)),
                                    ],
                                  )
                                ],
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "Name",
                                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                        ),
                                        Text(
                                          controller.clientsList[index]['name'].toString(),
                                          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                        ),
                                        SizedBox(
                                          height: 10.sp,
                                        ),
                                        Text(
                                          "Created",
                                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                        ),
                                        Text(
                                          controller.reformattedTime(controller.clientsList[index]['created_at'].toString()),
                                          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                        ),
                                        SizedBox(
                                          height: 10.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "Amount",
                                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                        ),
                                        Text(
                                          controller.clientsList[index]['amount'] ?? "NA",
                                          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 16.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
            )
          : Center(
              child: Text(
              "No clients found.",
              style: TextStyle(fontSize: 16.sp),
            ),),),
    );
  }
}
