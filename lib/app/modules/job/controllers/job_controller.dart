import 'package:get/get.dart';

import '../../../../constant.dart';
import '../../../../helpers/api_helper.dart';
import '../../../../helpers/helping_methods.dart';

class JobController extends GetxController {
  //TODO: Implement JobController
  var getAllJobsList = [].obs;
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

  Future<ApiResponse<dynamic>> getJobs() async {
    networkHelper.setAuthorizationToken(box.read(StorageKeys.bearerToken));
    return await networkHelper.fetchData(Endpoints.jobList).then((value) {
      if (value.statusCode == 200) {
        getAllJobsList.value = value.data['data'];
      } else {
        HelpingMethods.showToast('Unable to fetch jobs');
      }
      return value;
    });
  }
}
