
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_demo/core/constants/color_constants.dart';
import 'package:mvvm_demo/core/constants/string_constants.dart';
import 'package:mvvm_demo/core/enums/viewstate.dart';
import 'package:mvvm_demo/core/models/response_model.dart';
import 'package:mvvm_demo/core/viewmodels/user_details_view_model.dart';
import 'package:mvvm_demo/ui/views/base_view.dart';
import 'package:mvvm_demo/ui/views/update_view.dart';
import 'package:mvvm_demo/ui/widgets/common_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class DetailView extends StatelessWidget {
  DetailView({super.key});

  UserDetailsViewModel? model;
  late SharedPreferences logindata;

  @override
  Widget build(BuildContext context) {
    debugPrint('Build Call');
    return BaseView<UserDetailsViewModel>(onModelReady: (model) {
      this.model = model;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        model.getUserDetails(context);
      });
    }, builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  onPressed: () async {
                    logindata = await SharedPreferences.getInstance();
                    logindata.clear();
                    if (context.mounted) {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }
                  },
                  child: Text(
                    StringConstant.logout,
                    style: TextStyle(color: ColorConstant.white),
                  )),
            )
          ],
        ),
        body: detailMethod(),
      );
    });
  }

  SingleChildScrollView detailMethod() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextWidget(
            text: StringConstant.detailsTitle,
            fontWeight: FontWeight.w500,
            size: 35,
          ),
          model?.state == ViewState.busy
              ? const CircularProgressIndicator()
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model?.datas.length,
                  itemBuilder: (context, index) {
                    ResponseModel? data = model?.datas[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 10),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: ColorConstant.lightGrey8391A1, width: 2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        tileColor: ColorConstant.lightGrey,
                        title: Text(
                          'Name: ${data?.name ?? ""}',
                          style: TextStyle(color: ColorConstant.black),
                        ),
                        subtitle: Text(
                          data?.email ?? "",
                          style: TextStyle(color: ColorConstant.black),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                                child: InkWell(
                                    onTap: () async {
                                      showDialog<String>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title:
                                                    const Text('User Deleted'),
                                                content: Text(
                                                    'name: ${data?.name ?? ""},id : ${data?.id ?? 0},email : ${data?.email ?? ''} is Deleted'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'Cancel'),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      model?.deleteUserDetails(
                                                          context,
                                                          data?.id ?? 0);
                                                      if (context.mounted) {
                                                        Navigator.pop(
                                                            context, 'OK');
                                                        model?.getUserDetails(
                                                            context);
                                                        model?.datas.clear();
                    
                                                        model?.getUserDetails(
                                                            context);
                                                        model?.updateUI();
                                                      }
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              ));
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: ColorConstant.black,
                                    ))),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => UpdateView(
                                                    userName: data?.name ?? '',
                                                    userId: data?.id ?? 0,
                                                    userEmail:
                                                        data?.email ?? '',
                                                    userGender:
                                                        data?.gender ?? '',
                                                    userStatus: "active",
                                                  )));
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: ColorConstant.black,
                                    )))
                          ],
                        ),
                      ),
                    );
                  },
                )
        ],
      ),
    );
  }
}
