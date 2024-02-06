import 'package:flutter/material.dart';
import 'package:mvvm_demo/core/constants/color_constants.dart';
import 'package:mvvm_demo/core/constants/string_constants.dart';
import 'package:mvvm_demo/core/di/locator.dart';
import 'package:mvvm_demo/core/models/response_model.dart';
import 'package:mvvm_demo/core/services/http_delete_service.dart';
import 'package:mvvm_demo/core/services/http_get_service.dart';
import 'package:mvvm_demo/ui/views/update_view.dart';
import 'package:mvvm_demo/ui/widgets/common_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late Future<List<ResponseModel>>? futureData;

  // HttpGetApiService httpsss = HttpGetApiService();
  @override
  void initState() {
    super.initState();
    futureData = locator<HttpGetApiService>().getData();
  }

  late SharedPreferences logindata;

  @override
  Widget build(BuildContext context) {
    debugPrint('Build Call');
    return Scaffold(
      appBar: AppBar(
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
                    Navigator.pop(context);
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
          futureMethod()
        ],
      ),
    );
  }

  FutureBuilder<List<ResponseModel>> futureMethod() {
    return FutureBuilder<List<ResponseModel>>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        List<ResponseModel> userList = snapshot.data ?? [];
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: userList.length,
          itemBuilder: (context, index) {
            ResponseModel data = userList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: ColorConstant.lightGrey8391A1, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                tileColor: ColorConstant.lightGrey,
                title: Text(
                  'Name: ${data.name}',
                  style: TextStyle(color: ColorConstant.black),
                ),
                subtitle: Text(
                  data.email,
                  style: TextStyle(color: ColorConstant.black),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: InkWell(
                            onTap: () async {
                              // await locator<DeleteApi>()
                              // .deleteData(id: data.id);

                              showDialog<String>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text('User Deleted'),
                                        content: Text(
                                            'name: ${data.name},id : ${data.id},email : ${data.email} is Deleted'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              await locator<DeleteApi>()
                                                  .deleteData(id: data.id);
                                              if (context.mounted) {
                                                Navigator.pop(context, 'OK');
                                                setState(() {
                                                  futureData = locator<
                                                          HttpGetApiService>()
                                                      .getData();
                                                });
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
                                            userName: data.name,
                                            userId: data.id,
                                            userEmail: data.email,
                                            userGender: data.gender,
                                            userStatus: "active",
                                          )));
                              setState(() {
                                futureData =
                                    locator<HttpGetApiService>().getData();
                              });
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
        );
      },
    );
  }
}
