import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:mvvm_demo/core/constants/string_constants.dart';
import 'package:mvvm_demo/core/enums/viewstate.dart';
import 'package:mvvm_demo/core/models/request_model.dart';
import 'package:mvvm_demo/core/routing/routes.dart';
import 'package:mvvm_demo/core/repos/services.dart';
import 'package:mvvm_demo/core/utils/toast_utils.dart';
import 'package:mvvm_demo/core/viewmodels/base_model.dart';

class UpdateViewViewModel extends BaseModel {
  RequestModel? updateViewResponseModel;
  RequestModel? get updateViewRequest => updateViewResponseModel;
  ApiServices apiServices = ApiServices();

  set updateViewRequest(RequestModel? value) {
    updateViewResponseModel = value;
    updateUI();
  }

  Future postUpdate(
      BuildContext context, RequestModel requestModel, int? id) async {
    state = ViewState.busy;
    Response response = await apiServices.updateData(requestModel, id ?? 0);
    try {
      if (response.statusCode == 200) {
        state = ViewState.idle;
        if (context.mounted) {
          Navigator.of(context).pushNamed(Routes.detailsRoute);
        }
      } else {
        FlutterToastUtil.showToast(StringConstant.somethingWentWrong);
        state = ViewState.idle;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode.toString().startsWith("5") == true) {
          state = ViewState.idle;
          FlutterToastUtil.showToast(e.response!.statusMessage.toString());
          return;
        }
      }
      e.response != null
          ? FlutterToastUtil.showToast(e.response!.data["message"].toString())
          : FlutterToastUtil.showToast(e.message.toString());
      state = ViewState.idle;
    } catch (e) {
      FlutterToastUtil.showToast('Error $e');
      state = ViewState.idle;
    }
    state = ViewState.idle;
  }
}
