import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'helpers/api_helper.dart';

final box = GetStorage();
final networkHelper = NetworkHelper(baseUrl: Endpoints.baseUrl, headers: Endpoints.headers);

class Configs {
  String bearerToken = "";
  static String stripePublishableKey = "pk_test_51MTORaACs2GeMo1k1tnh1Za76wz34xrX7Zuwtlqjoztb4PmJEvdjhLjQm1AD4aoYy1J35007dXFtH4PLX8B2hOUy00hBgFjIQe"; // TEST
  // static String stripePublishableKey = "pk_test_51NuCGxSG1Xg8OWZS4KVCtGMMsr1tDzYRvXoZthI5CmWl2C5mEYwOA6bzQqEvxDd7WZU267rpBeqS59RB8Az9niIS00fW1fdT8Z"; // LIVE
  static String stripeClientSecretKey = "sk_test_51MTORaACs2GeMo1kWBRcFkbmi6jU6BZTpPDrC4j5eOm9BNGXlrYEySLsiaTGo9LH9x2fioHMqGjulfQ8e72309zH00yauu33xn"; // TEST
  // static String stripeClientSecretKey = "sk_test_51NuCGxSG1Xg8OWZS7OD8FZxHXVGPP1nht4mc7TUgdLO2gkyPCvzcXepPzektyvoHpYzNitI0tiUxfeMU0gt9BWFI00zhVqFjRT"; // LIVE
  static bool isFullAccess = false;
  static bool isPartialAccess = false;
}

class Endpoints {
  static String baseUrl = 'https://truckapp.store';
  static String loginUser = '/api/login-vendor';
  static String accountVerifyOTP = '/api/verify-otp';
  static String getUser = '/api/get-vendor';
  static String registerUser = '/api/register-vendor';
  static String registerDriver = '/api/register-driver';
  static String editDriver = '/api/edit-driver';
  static String editAvatar = '/api/edit-driver-avatar';
  static String requestOTPinEmail = '/api/send-forgot-password-otp';
  static String confirmPassOtp = '/api/forgot-password';
  static String termsConditions = '/api/get-terms-deed-urls';
  static String getVehicles = '/api/get-vehicle-list';
  static String getClients = '/api/client-list';
  static String getLicence = '/api/get-license-types';
  static String updateLicence = '/api/edit-license-type';
  static String getCustomers = '/api/get-customer';
  static String deleteClient = '/api/client-delete';
  static String addClient = '/api/client-store';
  static String addCustomer = '/api/add-customer';
  static String updateClient = '/api/client-update';
  static String updateCustomer = '/api/edit-customer';
  static String createVisaName = '/api/add-visa-type';
  static String getVisa = '/api/list-visa-type';
  static String updateVisa = '/api/edit-visa-type';
  static String deleteVisa = '/api/delete-visa-type';
  // static String getDriverLists = '/api/get-driver-list';
  static String getDriverNumbers = '/api/list-driver-number';
  static String addDriverNumber = '/api/add-driver-number';
  static String updateDriverNumber = '/api/edit-driver-number';
  static String deleteDriverNumber = '/api/delete-driver-number';
  static String wages = '/api/search-wages';
  static String getTruckTypes = '/api/get-vehicle-type';
  static String getTrucks = '/api/get-vehicle-list';
  static String addVehicle = '/api/add-vehicle';
  static String addVehicleType = '/api/add-vehicle-type';
  static String getDrivers = '/api/get-driver-list';
  static String getSalaries = '/api/salary-user';
  static String sendPDFMail = '/api/send-loa-mail';
  static String getLicenseState = '/api/fetch-license-state';
  static String licenseTypes = '/api/list-license-type';
  static String jobList = '/api/get-job-list';
  static String getPlans = '/api/get-plans';
  static String getRoasters = '/api/get-roaster-driver-list';
  static String getRego = '/api/fetch-rego';
  static String getVehicleList = '/api/get-vehicle-list';
  static String setRoaster = '/api/send-roaster-driver';
  static String purchasePlan = '/api/save-subscription';
  static String createInvoice = '/api/create-invoice';
  static String invoicePDF = '/api/get-invoice-pdf';
  static String searchInvoices = '/api/search-invoice';
  static String fcmServerKey =
      'AAAAaUzXK4Y:APA91bHH-E6SLk8YCX6M7UTpkP0HY-AcHoearBE_UGhDFJSPa5TtveyFm5gK9vFGi7XDLJeAbC1pG1nxeffI5ddjL0szHX2wNZQ9-8BBzh-8WP53IUvKX_-KJrtDfUA46m1qDjciX5dO';
  static Map<String, String> headers = {'Content-Type': 'application/json', 'Accept': 'application/json'};
}

class OurColor {
  static const Color scaffoldBG = Colors.white;
  static const Color highlightBG = Color(0xFF12B5E4);
  static const Color textFieldBackgroundColor = Color(0xFFCBCBCB);
}

class StorageKeys {
  static String bearerToken = "bearerToken";
  static String userData = "userData";
  static String lastCoord = "lastCoord";
  static String isWorkStarted = "isWorkStarted";
  static String todayWorkTime = "todayWorkTime";
  static String notificationShown = "notificationShown";
}

class OurColors {
  static Color scaffold = Colors.white;
  // static Color cardBG = Color(0xFF135d91);
  static Color cardBG = Colors.white;
}

class TextFonts {
  static TextStyle subtitle = TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp, color: Colors.black.withOpacity(0.65), letterSpacing: 0);
}
class AppColors{
  static const Color appPrimaryColor=Color(0xff154379);
  static const Color appPrimaryLightColor=Color(0xff12B5E4);
  static const Color canvasColor=whiteColor;

  ///Common colors
  static const Color greenishColor=Color(0xff26A65B);
  static const Color lightGreenishColor=Color(0xff00BE35);
  static const Color blackishColor=Color(0xff414141);
  static const Color whiteColor=Color(0xffFFFFFF);
  static const Color creamColor=Color(0xffF4F4F4);
  static const Color textFilledColor=Color(0xffF2F2F2);

  ///Light Common colors
  // static const Color lightGreenishColor=Color(0xff26A65B);


  ///Text Color
  static const Color darkBlackishTextColor=Color(0xff524C4C);
  static const Color lightBlackishTextColor=Color(0xff646464);
  static const Color lightBlackishTextColor69=Color(0xff6E6969);
  static const Color textFillHintTextColor=Color(0xffABABAB);

}