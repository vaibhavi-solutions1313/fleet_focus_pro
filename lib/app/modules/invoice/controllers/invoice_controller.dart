import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constant.dart';
import '../../../../helpers/api_helper.dart';
import '../../../../widgets/our_pdf_view.dart';

class InvoiceController extends GetxController {
  List<String> gstOptions = ["Yes", "No"];
  TextEditingController invoiceNumber = TextEditingController();
  TextEditingController invoiceDate = TextEditingController();
  TextEditingController invoiceRemarks = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController description = TextEditingController();
  final amountDescForm = GlobalKey<FormState>();
  TextEditingController invoiceFromDate = TextEditingController();
  TextEditingController invoiceToDate = TextEditingController();
  var searchInvoiceResult = [].obs;

  // SELECTIONS
  String? selectedGst;
  String? selectedCustomerId;
  var totalAmount = 0.0.obs;
  var subtotal = 0.0.obs;
  var gst = 0.0.obs;
  var selectedAmountDescription = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<String> selectDOB(bool isSearch) async {
    DateTime? _selectedDate = await showDatePicker(
      context: Get.overlayContext!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2300),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), // Set the theme for the date picker dialog
          child: child!,
        );
      },
    );
    String formattedDate = DateFormat(isSearch == false ? 'dd-MM-yyyy' : 'yyyy-MM-dd').format(_selectedDate!);
    return formattedDate;
  }

  Future<ApiResponse> generateInvoice() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postData(Endpoints.createInvoice, {
      "gstOption": selectedGst,
      "customerId": selectedCustomerId,
      "invoiceDate": invoiceDate.text,
      "invoiceRemarks": invoiceRemarks.text,
      "gstAmount": gst.value,
      "totalAmountWithoutGST": subtotal.value,
      "totalAmountWithGST": totalAmount.value,
      "invoiceDetails": selectedAmountDescription.value
    }).then((value) {
      if (value.statusCode == 200) {
        clearFields();
        var json = value.data;
        getInvoicePdf(json['data']['id'].toString()).then((value) {
          if (value.statusCode == 200) {
            Get.to(OurPDFView(url: value.data['data']), transition: Transition.rightToLeft);
          }
        });
      }
      return value;
    });
  }

  Future<ApiResponse> getInvoicePdf(String invoiceId) async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postData(Endpoints.invoicePDF, {
      "invoice_id": invoiceId,
    });
  }

  Future<ApiResponse> searchInvoices() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.postData(Endpoints.searchInvoices, {"startDate": invoiceFromDate.text, "endDate": invoiceToDate.text}).then((value) {
      if(value.statusCode == 200) {
        searchInvoiceResult.value = value.data['data'];
      }
      invoiceFromDate.clear();
      invoiceToDate.clear();
      return value;
    });
  }

  Future<void> launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void clearFields() {
    invoiceDate.clear();
    invoiceRemarks.clear();
    amount.clear();
    description.clear();
    selectedGst = null;
    selectedCustomerId = null;
    totalAmount.value = 0.0;
    subtotal.value = 0.0;
    gst.value = 0.0;
    selectedAmountDescription.clear();
  }

  void clearTextFields() {
    invoiceDate.clear();
    invoiceRemarks.clear();
    amount.clear();
    description.clear();
  }
}
