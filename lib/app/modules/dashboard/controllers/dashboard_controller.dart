import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

import '../../../../helpers/services.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController

  final CarouselController carouselController = CarouselController();
  final RxInt currentPage = 0.obs;
  final List<String> sliderList = [
    'assets/dashboard_icons/fleet_slider1.png',
    'assets/dashboard_icons/fleet_slider2.png',
    'assets/dashboard_icons/fleet_slider3.png',
  ];

  final List<GridItem> gridItemList = [
    GridItem(
        imagePath: 'assets/dashboard_icons/dashboard_salary_payment.png',
        text: 'Salary'),
    GridItem(
        imagePath: 'assets/dashboard_icons/dashboard_roaster.png',
        text: 'Roaster'),
    GridItem(
        imagePath: 'assets/dashboard_icons/dashboard_salary_payment.png',
        text: 'Payment'),
    GridItem(
        imagePath: 'assets/dashboard_icons/dashboard_truck.png',
        text: 'Trucks'),
    GridItem(
        imagePath: 'assets/dashboard_icons/dashboard_customer.png',
        text: 'Customer'),
  ];

  final List<CardItemModel> masterItemList = [
    CardItemModel(
        image: 'assets/dashboard_icons/master_customer.png',
        text: 'Customer'),
    CardItemModel(
        image: 'assets/dashboard_icons/master_license_type.png',
        text: 'License Types'),
    CardItemModel(
        image: 'assets/dashboard_icons/master_visa.png', text: 'Visa'),
    CardItemModel(
        image: 'assets/dashboard_icons/master_driver_number.png',
        text: 'Driver Number'),
  ];

  // final List<MasterImage> masterItemList = [
  //   MasterImage(
  //       image: 'assets/dashboard_icons/master_customer.png',),
  //   MasterImage(
  //       image: 'assets/dashboard_icons/master_license_type.png'),
  //   MasterImage(
  //       image: 'assets/dashboard_icons/master_visa.png'),
  //   MasterImage(
  //       image: 'assets/dashboard_icons/master_driver_number.png'),
  // ];
  //
  // final List<MasterText> masterItemText = [
  //   MasterText(text: 'Customer'),
  //   MasterText(text: 'License Types'),
  //   MasterText(text: 'Visa'),
  //   MasterText(text: 'Driver Number'),
  // ];
  final List<CardItemModel> employeeItemList = [
    CardItemModel(
        image: 'assets/dashboard_icons/employee_driver_list.png',
        text: 'Driver List'),
    CardItemModel(
        image: 'assets/dashboard_icons/employee_roaster.png',
        text: 'Roaster'),
    CardItemModel(
        image: 'assets/dashboard_icons/employee_payments.png', text: 'Payment'),
    CardItemModel(
        image: 'assets/dashboard_icons/employee_invoices.png',
        text: 'Invoices'),
  ];
  final List<CardItemModel> truckItemList = [
    CardItemModel(
        image: 'assets/dashboard_icons/trucks_list.png',
        text: 'Truck List'),
    CardItemModel(
        image: 'assets/dashboard_icons/trucks_types.png',
        text: 'Truck Types'),
  ];
  final List<CardItemModel> wagesItemList = [
    CardItemModel(
        image: 'assets/dashboard_icons/wages_payment.png',
        text: 'Payments'),
  ];
  final List<CardItemModel> jobItemList = [
    CardItemModel(
        image: 'assets/dashboard_icons/jobs_list.png',
        text: 'Job List'),
  ];

  @override
  void onInit() {
    super.onInit();
    AppServices().determinePosition();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class GridItem {
  final String imagePath;
  final String text;

  GridItem({
    required this.imagePath,
    required this.text,
  });
}

// card_item_model.dart
class CardItemModel {
  final String image;
  final String text;

  CardItemModel({required this.image, required this.text});
}

class MasterImage {
  final String image;

  MasterImage({required this.image});
}

class MasterText {
  final String text;

  MasterText({required this.text});
}
