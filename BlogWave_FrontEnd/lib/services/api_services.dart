import 'dart:developer';
import 'package:blogwave_frontend/services/status_code.dart';
import 'package:dio/dio.dart' as dio;
import 'user_preferences.dart';

// Class of the Api service , Define all the api functions Like GET, POST AND DELETE
class ApiServices {
  Future getApi({required String api, required Map<String, dynamic> body}) async {
    try {
      final response = await dio.Dio().get(api,
          data: body,
          options: dio.Options(headers: {
            "authorization": "Bearer ${UserPreferences.token}",
          }));
      log(response.statusCode.toString());
      if (response.statusCode == ServerStatusCodes.success) {
        // log(response.data.toString());
        var jsonData = response.data;
        return jsonData;
      }
    } catch (e) {
      log(e.toString());
    }
  }

//POST APi , Function to Send new Blog Data to the Database
  Future<ApiResponse> postApi({required String api, required Map<String, dynamic> body}) async {
    final response_1 = await dio.Dio().post(
      api,
      data: body,
      options: dio.Options(
        validateStatus: (_) => true,
        headers: {
          "authorization": "Bearer ${UserPreferences.token}",
        },
      ),
    );
    return ApiResponse(data: response_1.data, statusCode: response_1.statusCode);
  }
// DELETE APi , Function to Delete Blog Data from the Database
  Future deleteApi({required String api, required Map<String, dynamic> body}) async {
    final response_1 = await dio.Dio().delete(
      api,
      data: body,
      options: dio.Options(
        headers: {
          "authorization": "Bearer ${UserPreferences.token}",
        },
      ),
    );

    if (response_1.statusCode == ServerStatusCodes.addSuccess) {
      var jsonData = response_1.data;
      log('Status code: ${response_1.statusCode}');
      return jsonData;
    } else {
      log('Failed to delete . Status code: ${response_1.statusCode}');
      log('Response body: ${response_1.data}');
    }
  }
}

class ApiResponse {
  final dynamic data;
  final dynamic statusCode;

  ApiResponse({
    required this.data,
    required this.statusCode,
  });
}
