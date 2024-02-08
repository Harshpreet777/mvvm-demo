
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/core/constants/string_constants.dart';
import 'package:mvvm_demo/core/enums/viewstate.dart';
import 'package:mvvm_demo/core/models/response_model.dart';
import 'package:mvvm_demo/core/repos/services.dart';
import 'package:mvvm_demo/core/utils/toast_utils.dart';
import 'package:mvvm_demo/core/viewmodels/base_model.dart';

class UserDetailsViewModel extends BaseModel {
  List<ResponseModel> datas = [];
  List<dynamic> userData = [];

  ResponseModel? _userDetailsResponseModel;
  ResponseModel? get userDetailsResponse => _userDetailsResponseModel;
  ApiServices apiServices = ApiServices();

  set userDetailsResponse(ResponseModel? value) {
    _userDetailsResponseModel = value;
    updateUI();
  }

  Future<List<ResponseModel>> getUserDetails(
    BuildContext context,
  ) async {
    List<dynamic> userData = [];

    Response response = await apiServices.getData();

    state = ViewState.busy;
    try {
      if (response.statusCode == 200) {
        state=ViewState.idle;
        userData = response.data;
        datas = userData.map((e) {
          return ResponseModel.fromJson(e);
        }).toList();
        return datas;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode.toString().startsWith("5") == true) {
          state = ViewState.idle;
          FlutterToastUtil.showToast(e.response!.statusMessage.toString());
        }
      }
      e.response != null
          ? FlutterToastUtil.showToast(e.response!.data["message"].toString())
          : FlutterToastUtil.showToast(e.message.toString());
      state = ViewState.idle;
    } catch (e) {
      FlutterToastUtil.showToast(StringConstant.somethingWentWrong);
      state = ViewState.idle;
    }
    state = ViewState.idle;
    return datas;
  }

  deleteUserDetails(
    BuildContext context,
    int id,
  ) async {
    state = ViewState.busy;
    Response response = await apiServices.deleteData(id: id);
    try {
      if (response.statusCode == 201) {
        state = ViewState.idle;
        updateUI();
        FlutterToastUtil.showToast('Deleted');
      } else if (response.statusCode == 404) {
        FlutterToastUtil.showToast('Delete Failed');
      } else if (response.statusCode == 400) {
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
