import 'package:fleet_focus_pro/app/modules/driver/model/driver_list_item_model.dart';
import 'package:fleet_focus_pro/app/modules/roaster/model/roaster_info_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../constant.dart';
import '../../../../helpers/api_helper.dart';
import '../../../../models/send_roaster_model.dart';
import '../../driver/controllers/driver_controller.dart';

class RoasterController extends GetxController {
  var roasterInfo = <RoasterInfoModel>[].obs;
  var vehicleList = [].obs;
  var regoList = [].obs;
  var selectedDriver = {}.obs;
  var selectedRego = {}.obs;
  var filteredRoasters = [].obs;
  var selectedDates = SetRoasterModel().obs;
  var selectedTableData = <TableData>[].obs;
  TextEditingController selectedDate = TextEditingController();
  TextEditingController selectedShiftStartDate = TextEditingController();
  TextEditingController selectedShiftEndDate = TextEditingController();

  @override
  void onInit() {
    getRoaster();
    getRegos();
    getVehiclesList();
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

  Future<ApiResponse<dynamic>> getRoaster() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.fetchData(Endpoints.getRoasters).then((value) {
      if (value.statusCode == 200) {
        // roasterInfo.value = value.data['data'];
        for(var data in value.data['data']){
          var driverList = Get.find<DriverController>().driverList;

          RoasterInfoModel roasterInfoModel = RoasterInfoModel.fromJson(data);

          for(var driverItemModel in driverList){
            DriverItemModel currentDriver = DriverItemModel.fromJson(driverItemModel);
            if(roasterInfoModel.driverId != null && currentDriver.id !=null && roasterInfoModel.driverId == currentDriver.id){
              roasterInfoModel.driverName = currentDriver.userName;
              break;
            }
          }

          roasterInfo.add(roasterInfoModel);
        }
      }
      return value;
    }).onError((error, stackTrace) {
      return ApiResponse(statusCode: 500);
    });
  }

  Future<ApiResponse<dynamic>> getRegos() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.fetchData(Endpoints.getRego).then((value) {
      if (value.statusCode == 200) {
        regoList.value = value.data['data'];
      }
      return value;
    }).onError((error, stackTrace) {
      return ApiResponse(statusCode: 500);
    });
  }

  Future<ApiResponse<dynamic>> getVehiclesList() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.fetchData(Endpoints.getVehicleList).then((value) {
      if (value.statusCode == 200) {
        vehicleList.value = value.data['data'];
      }
      return value;
    }).onError((error, stackTrace) {
      return ApiResponse(statusCode: 500);
    });
  }

  void filterRoasterByDriverId() {
    // filteredRoasters.value = roasterInfo.where((p0) => p0['user_id'] == selectedDriver['user_id']).toList();
  }

  Future<ApiResponse<dynamic>> setRoaster() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    // String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // selectedDates.value.date = date;
    selectedDates.value.tableData!.removeWhere((element) => element.startTime == null || element.endTime == null);
    print(selectedDates.toJson().toString());
    return await networkHelper.postData(Endpoints.setRoaster, selectedDates.toJson());
  }

  Future<String> selectDOB() async {
    DateTime? _selectedDate = await showDatePicker(
      context: Get.overlayContext!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2300),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), // Set the theme for the date picker dialog
          child: child!,
        );
      },
    );
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    return formattedDate;
  }

  Future<String?> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );

    final now = DateTime.now();

    if (pickedTime != null) {
      final dateTime = DateTime(now.year, now.month, now.day, pickedTime!.hour, pickedTime!.minute);
      final formattedTime = DateFormat.Hm().format(dateTime);
      return formattedTime;
    } else {
      return null;
    }
  }

  String status(int statusId) {
    if (statusId == 0) {
      return "Pending";
    } else if (statusId == 1) {
      return "Approved";
    } else if (statusId == 2) {
      return "Rejected";
    } else {
      return "Unknown Status";
    }
  }

  void refreshAddtoList() {
    selectedTableData.refresh();
  }
}
