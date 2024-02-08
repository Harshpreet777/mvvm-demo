import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mvvm_demo/core/models/request_model.dart';

class ApiServices {
  Future getData() async {
    var dio = Dio();
    Response response;
    try {
      response = await dio.get('https://gorest.co.in/public/v2/users',
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization":
                  "Bearer c9deacfd00d58aef0219b783eebff9cbac46821034ee07d465a2424b341c7725"
            },
          ));

      return response;
    } catch (e) {
      log('Error sending request!');
    }
  }

  Future postData(RequestModel requestModel) async {
    Dio dio = Dio();
    Response response;
    try {
      response = await dio.post("https://gorest.co.in/public/v2/users",
          data: requestModelToJson(requestModel),
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer c9deacfd00d58aef0219b783eebff9cbac46821034ee07d465a2424b341c7725"
          }));
      return response;
    } catch (e) {
      log("Failed to Load $e");
      return false;
    }
  }

  Future deleteData({int? id}) async {
    var dio = Dio();
    Response response;
    try {
      response = await dio.delete('https://gorest.co.in/public/v2/users/$id',
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization":
                  "Bearer c9deacfd00d58aef0219b783eebff9cbac46821034ee07d465a2424b341c7725"
            },
          ));
      return response;
    } catch (e) {
      log("Failed to Load $e");
    }
  }

  Future updateData(RequestModel requestModel, int id) async {
    var dio = Dio();
    Response response;
    try {
      response = await dio.put('https://gorest.co.in/public/v2/users/$id',
          data: requestModelToJson(requestModel),
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer c9deacfd00d58aef0219b783eebff9cbac46821034ee07d465a2424b341c7725"
          }));
      return response;
    } catch (e) {
      log("Failed to Load $e");
      return false;
    }
  }
}
