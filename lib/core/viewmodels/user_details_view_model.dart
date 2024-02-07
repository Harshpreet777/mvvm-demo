import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_demo/core/constants/string_constants.dart';
import 'package:mvvm_demo/core/di/locator.dart';
import 'package:mvvm_demo/core/enums/viewstate.dart';
import 'package:mvvm_demo/core/models/response_model.dart';
import 'package:mvvm_demo/core/services/services.dart';
import 'package:mvvm_demo/core/utils/toast_utils.dart';

class UserDetailsViewModel {
  static dynamic state;
  ResponseModel? _userDetailsResponseModel;
  ResponseModel? get userDetailsResponse => _userDetailsResponseModel;
  ApiServices apiServices = ApiServices();

  set userDetailsResponse(ResponseModel? value) {
    _userDetailsResponseModel = value;
  }

  Future<List<ResponseModel>> getUserDetails(
    BuildContext context,
  ) async {
    List<ResponseModel> list = await apiServices.getData();

    state = ViewState.busy;
    try {
      if (list.isNotEmpty) {
        state = ViewState.idle;
        FlutterToastUtil.showToast('Data');
        if (context.mounted) {
          return list;
        }
      } else if (list.isEmpty) {
        FlutterToastUtil.showToast('No data');
      } else {
        FlutterToastUtil.showToast(StringConstant.somethingWentWrong);
        state = ViewState.idle;
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
    return list;
  }

  deleteUserDetails(
    BuildContext context,
    int id,
  ) async {
    state = ViewState.busy;
    bool isSuccess = await locator<ApiServices>().deleteData(id: id);
    try {
      if (isSuccess) {
        state = ViewState.idle;
        FlutterToastUtil.showToast('Deleted');
      } else if (!isSuccess) {
        FlutterToastUtil.showToast('Delete Failed');
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
