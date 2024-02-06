import 'package:flutter/material.dart';
import 'package:mvvm_demo/core/constants/color_constants.dart';
import 'package:mvvm_demo/core/constants/string_constants.dart';
import 'package:mvvm_demo/core/di/locator.dart';
import 'package:mvvm_demo/core/models/request_model.dart';
import 'package:mvvm_demo/core/routing/routes.dart';
import 'package:mvvm_demo/core/services/http_update_service.dart';
import 'package:mvvm_demo/ui/widgets/common_elevated_button.dart';
import 'package:mvvm_demo/ui/widgets/common_text.dart';
import 'package:mvvm_demo/ui/widgets/common_textform_field.dart';

class UpdateView extends StatefulWidget {
  const UpdateView(
      {super.key,
      this.userId,
      this.userName,
      this.userEmail,
      this.userGender,
      this.userStatus});
  final int? userId;
  final String? userName;
  final String? userEmail;
  final String? userGender;
  final String? userStatus;

  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool? isNameValid = true;
  bool? isEmailValid = true;
  String? gender;
  String status = "active";

  @override
  void initState() {
    super.initState();
    nameController.text = widget.userName ?? "";
    emailController.text = widget.userEmail ?? "";
    gender = widget.userGender ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      backgroundColor: ColorConstant.lightGrey,
      body: updateMethod(context),
    );
  }

  SingleChildScrollView updateMethod(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextWidget(
              text: StringConstant.updateTitle,
              fontWeight: FontWeight.w700,
              size: 30,
            ),
            TextFormFieldWidget(
              name: widget.userName.toString(),
              controller: nameController,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormFieldWidget(
                name: widget.userEmail.toString(),
                controller: emailController),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Container(
                decoration: BoxDecoration(
                    color: ColorConstant.lightGrey,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: ColorConstant.borderColorE8ECF4,
                        style: BorderStyle.solid,
                        width: 1)),
                child: Row(
                  children: [
                    Text(
                      StringConstant.gender,
                      style: TextStyle(
                          color: ColorConstant.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Flexible(
                      child: RadioListTile(
                        title: Text(
                          StringConstant.male,
                          style: TextStyle(color: ColorConstant.grey),
                        ),
                        value: 'male',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile(
                        title: Text(
                          StringConstant.female,
                          style: TextStyle(color: ColorConstant.grey),
                        ),
                        value: 'female',
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: ElevatedBtnWidget(
                  color: ColorConstant.black,
                  name: StringConstant.updateData,
                  textColor: ColorConstant.white,
                  onpress: () async {
                    if (_formKey.currentState!.validate()) {
                      String updatedName = nameController.text;
                      String updatedEmail = emailController.text;
                      String updatedGender = gender ?? " ";

                      if (updatedName != widget.userName ||
                          updatedEmail != widget.userEmail ||
                          updatedGender != widget.userGender) {
                        RequestModel requestModel = RequestModel(
                          name: updatedName,
                          email: updatedEmail,
                          gender: updatedGender,
                          status: "active",
                        );
                        bool isSuccess = await locator<UpdateApi>()
                            .updateData(requestModel, widget.userId ?? 0);
                        // bool isSuccess = await UpdateApi.updateData(
                        //   requestModel,
                        //   widget.userId,
                        // );
                        if (isSuccess && context.mounted) {
                          const snackBar = SnackBar(
                            content: Text("User Details updated"),
                            duration: Duration(seconds: 1),
                          );
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackBar);
                          Navigator.of(context)
                              .pushNamed(Routes.detailsRoute);
                        } else {
                          const snackBar = SnackBar(
                            content: Text("Error..."),
                            duration: Duration(seconds: 2),
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      } else {
                        const snackBar = SnackBar(
                          content: Text("Data already exists..."),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
