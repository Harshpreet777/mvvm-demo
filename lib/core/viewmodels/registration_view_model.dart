import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/core/constants/string_constants.dart';
import 'package:mvvm_demo/core/enums/viewstate.dart';
import 'package:mvvm_demo/core/models/request_model.dart';
import 'package:mvvm_demo/core/routing/routes.dart';
import 'package:mvvm_demo/core/repos/services.dart';
import 'package:mvvm_demo/core/utils/toast_utils.dart';
import 'package:mvvm_demo/core/viewmodels/base_model.dart';

class RegistrationViewModel extends BaseModel {
  ApiServices apiServices = ApiServices();
  // static dynamic state;
  RequestModel? _registrationRequestModel;
  RequestModel? get registrationRequest => _registrationRequestModel;

  set registrationRequest(RequestModel? value) {
    _registrationRequestModel = value;
    updateUI();
  }

  Future postRegistration(
      BuildContext context, RequestModel requestModel) async {
    Response response = await apiServices.postData(requestModel);

    state = ViewState.busy;
    try {
      if (response.statusCode == 201) {
        state = ViewState.idle;

        if (context.mounted) {
          Navigator.of(context).pushNamed(Routes.loginRoute);
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
