import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mvvm_demo/core/models/response_model.dart';

class HttpGetApiService {
   Future<List<ResponseModel>> getData() async {
    List<ResponseModel> datas = [];

    try {
      final response = await http
          .get(Uri.parse('https://gorest.co.in/public/v2/users'), headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer c9deacfd00d58aef0219b783eebff9cbac46821034ee07d465a2424b341c7725"
      });

      if (response.statusCode == 200) {
        datas = responseModelFromJson(response.body);
        return datas;
      }
      log("${datas.length}");
    } catch (e) {
      log('Error sending request!');
    }
    return datas;
  }
}
