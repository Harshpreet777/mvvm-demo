import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_demo/core/constants/color_constants.dart';
import 'package:mvvm_demo/core/constants/string_constants.dart';
import 'package:mvvm_demo/core/models/request_model.dart';
import 'package:mvvm_demo/core/persistence/preferences.dart';
import 'package:mvvm_demo/core/routing/routes.dart';
import 'package:mvvm_demo/core/utils/validation_utils.dart';
import 'package:mvvm_demo/core/viewmodels/registration_view_model.dart';
import 'package:mvvm_demo/ui/widgets/common_textform_field.dart';

class ResgistrationView extends StatefulWidget {
  const ResgistrationView({super.key});

  @override
  State<ResgistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<ResgistrationView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool? isNameValid = true;
  bool? isEmailValid = true;
  String gender = "male";
  String status = "active";
  RegistrationViewModel registrationViewModel=RegistrationViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: registrationMethod(context),
    );
  }

  SingleChildScrollView registrationMethod(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 80, bottom: 32),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(StringConstant.registrationTitle,
                    style: TextStyle(
                        color: ColorConstant.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w700)),
              ),
            ),
            TextFormFieldWidget(
              name: StringConstant.name,
              controller: nameController,
              validator: (value) {
                return Validations.isNameValid(value!);
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormFieldWidget(
              name: StringConstant.email,
              controller: emailController,
              validator: (value) {
                return Validations.isEmailValid(value!);
              },
            ),
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
                      'Gender',
                      style: TextStyle(
                          color: ColorConstant.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Flexible(
                      flex: 1,
                      child: RadioListTile(
                        title: Text(
                          StringConstant.male,
                          style: TextStyle(color: ColorConstant.grey),
                        ),
                        value: "male",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        },
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: RadioListTile(
                        title: Text(
                          StringConstant.female,
                          style: TextStyle(color: ColorConstant.grey),
                        ),
                        value: "female",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
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
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8)))),
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xff1E232C))),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var name = nameController.text;
                        var email = emailController.text;
                        Preferences.setString('name', name);
                        Preferences.setString('email', email);

                        const snackBar =
                            SnackBar(content: Text('User Registered!'));
                        RequestModel requestModel = RequestModel(
                            name: nameController.text,
                            email: emailController.text,
                            gender: gender,
                            status: "active");
                        registrationViewModel.postRegistration(
                            context, requestModel);

                        if (context.mounted) {
                          Navigator.of(context).pushNamed(Routes.loginRoute);
                        } else {
                          const snackBar =
                              SnackBar(content: Text('User Not Registered!'));
                          log(snackBar.toString());
                        }
                        if ( context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: Text(
                      StringConstant.registration,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
