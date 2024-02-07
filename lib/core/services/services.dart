import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mvvm_demo/core/models/request_model.dart';
import 'package:mvvm_demo/core/models/response_model.dart';

class ApiServices {
  Future<List<ResponseModel>> getData() async {
    List<dynamic> userData = [];
    List<ResponseModel> datas = [];
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

      if (response.statusCode == 200) {
        userData = response.data;
        datas = userData.map((e) {
          return ResponseModel.fromJson(e);
        }).toList();
      }
    } catch (e) {
      log('Error sending request!');
    }
    return datas;
  }

  Future<bool> postData(RequestModel requestModel) async {
    Dio dio = Dio();
    try {
      Response response = await dio.post("https://gorest.co.in/public/v2/users",
          data: requestModelToJson(requestModel),
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer c9deacfd00d58aef0219b783eebff9cbac46821034ee07d465a2424b341c7725"
          }));
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Failed to Load $e");
      return false;
    }
  }

  Future<bool> deleteData({int? id}) async {
    var dio = Dio();
    try {
      final response =
          await dio.delete('https://gorest.co.in/public/v2/users/$id',
              options: Options(
                headers: {
                  "Content-Type": "application/json",
                  "Authorization":
                      "Bearer c9deacfd00d58aef0219b783eebff9cbac46821034ee07d465a2424b341c7725"
                },
              ));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Failed to Load $e");
      return false;
    }
  }

  Future<bool> updateData(RequestModel requestModel, int id) async {
    var dio = Dio();
    try {
      final response = await dio.put('https://gorest.co.in/public/v2/users/$id',
          data: requestModelToJson(requestModel),
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization":
                "Bearer c9deacfd00d58aef0219b783eebff9cbac46821034ee07d465a2424b341c7725"
          }));
      if (response.statusCode == 200) {
        log("response.data is ${response.data}");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Failed to Load $e");
      return false;
    }
  }
}
