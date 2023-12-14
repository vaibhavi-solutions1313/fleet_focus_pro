import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../constant.dart';



class ApiResponse<T> {
  final int statusCode;
  final T? data;
  final String? error;

  ApiResponse({required this.statusCode, this.data, this.error});
}

class NetworkHelper {
  final String baseUrl;
  final Map<String, String> headers;

  NetworkHelper({required this.baseUrl, Map<String, String>? headers}) : headers = headers ?? {};

  void setAuthorizationToken(String token) {
    headers['Authorization'] = 'Bearer $token';
  }

  Future<ApiResponse<dynamic>> fetchData(String endpoint) async {
    log('-----ENDPOINT-----');
    log('GET - $baseUrl$endpoint');
    final response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);
    log('<<<<<<<<<<<<<<<<<<<<<RESPONSE>>>>>>>>>>>>>>>>>>>>>');
    log(response.body);
    log('<<<<<<<<<<<<<<<<<<<<<RESPONSE ENDS>>>>>>>>>>>>>>>>>>');
    if (response.statusCode == 200) {
      return ApiResponse(statusCode: response.statusCode, data: jsonDecode(response.body));
    } else {
      return ApiResponse(statusCode: response.statusCode, error: 'Failed to load data');
    }
  }

  Future<ApiResponse<dynamic>> postData(String endpoint, Map<String, dynamic> data) async {
    log('-----ENDPOINT-----');
    log('POST - RAW - $baseUrl$endpoint');
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(data),
    );
    log('<<<<<<<<<<<<<<<<<<<<<RESPONSE>>>>>>>>>>>>>>>>>>>>>');
    log(response.body);
    log('<<<<<<<<<<<<<<<<<<<<<RESPONSE ENDS>>>>>>>>>>>>>>>>>>');
    if (response.statusCode == 200) {
      return ApiResponse(statusCode: response.statusCode, data: jsonDecode(response.body));
    } else {
      return ApiResponse(statusCode: response.statusCode, error: 'Failed to create data');
    }
  }

  Future<ApiResponse<dynamic>> updateData(String endpoint, Map<String, dynamic> data) async {
    log('-----ENDPOINT-----');
    log('PUT - RAW - $baseUrl$endpoint');
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(data),
    );
    log('<<<<<<<<<<<<<<<<<<<<<RESPONSE>>>>>>>>>>>>>>>>>>>>>');
    log(response.body);
    log('<<<<<<<<<<<<<<<<<<<<<RESPONSE ENDS>>>>>>>>>>>>>>>>>>');
    if (response.statusCode == 200) {
      return ApiResponse(statusCode: response.statusCode, data: jsonDecode(response.body));
    } else {
      return ApiResponse(statusCode: response.statusCode, error: 'Failed to update data');
    }
  }

  Future<void> deleteData(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl$endpoint'), headers: headers);

    if (response.statusCode != 204) {
      throw Exception('Failed to delete data');
    }
  }

  Future<ApiResponse<dynamic>> postFormData(String endpoint, Map<String, String> formData, List<http.MultipartFile> files) async {
    log('-----ENDPOINT-----');
    log('POST - FORM - $baseUrl$endpoint');
    final request = http.MultipartRequest('POST', Uri.parse('$baseUrl$endpoint'));

    // Set headers
    request.headers.addAll(headers);

    // Add form fields
    // if (files.isNotEmpty) {
    //   formData.forEach((key, value) {
    //     request.fields[key] = value;
    //   });
    // } else {
    //   request.fields.addAll(formData);
    // }

    // Add files
    if (files.isNotEmpty) {
      request.files.addAll(files);
    }


    if(formData.isNotEmpty) {
      request.fields.addAll(formData);
    }

    http.StreamedResponse response = await request.send();
    final responseBody = jsonDecode(await response.stream.bytesToString());

    log('<<<<<<<<<<<<<<<<<<<<<RESPONSE>>>>>>>>>>>>>>>>>>>>>');
    log(responseBody.toString());
    log('<<<<<<<<<<<<<<<<<<<<<RESPONSE ENDS>>>>>>>>>>>>>>>>>>');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse(statusCode: response.statusCode, data: responseBody);
    } else if (response.statusCode == 401) {
      return ApiResponse(statusCode: response.statusCode, error: responseBody['data']);
    } else if (response.statusCode == 422 || response.statusCode == 404) {
      return ApiResponse(statusCode: response.statusCode, error: responseBody['message'], data: responseBody['data']);
    } else {
      return ApiResponse(statusCode: response.statusCode, error: 'Request failed');
    }
  }
}


class SendNotification {
  static Future sendFCMNotification(String title, String description, String fcm) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=${Endpoints.fcmServerKey}'
    };
    var request = http.Request('POST', Uri.parse('https://fcm.googleapis.com/fcm/send'));
    request.body = json.encode({
      "priority": "HIGH",
      "notification": {
        "title": title,
        "body": description,
        "mutable_content": true,
        "sound": "Tri-tone"
      },
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      },
      "to": fcm
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
