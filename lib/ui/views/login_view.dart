import 'package:flutter/material.dart';
import 'package:mvvm_demo/core/constants/color_constants.dart';
import 'package:mvvm_demo/core/constants/string_constants.dart';
import 'package:mvvm_demo/core/routing/routes.dart';
import 'package:mvvm_demo/core/utils/validation_utils.dart';
import 'package:mvvm_demo/ui/widgets/common_elevated_button.dart';
import 'package:mvvm_demo/ui/widgets/common_text.dart';
import 'package:mvvm_demo/ui/widgets/common_textform_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool? isNameValid = true;
  bool? isEmailValid = true;

  @override
  void initState() {
    super.initState();
    initialState();
  }

  late SharedPreferences pref;
  String name = '';
  String email = '';
  void initialState() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString('name') ?? '';
      email = pref.getString('email') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              size: 30,
            )),
      ),
      body: loginMethod(context),
    );
  }

  SingleChildScrollView loginMethod(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextWidget(
              text: StringConstant.loginTitle,
              fontWeight: FontWeight.w700,
              size: 30,
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedBtnWidget(
                  color: ColorConstant.black,
                  name: StringConstant.login,
                  textColor: ColorConstant.white,
                  onpress: () {
                    if (_formKey.currentState!.validate()) {
                      if (name != nameController.text ||
                          email != emailController.text) {
                        showDialog<String>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Invalid Credentials'),
                                  content: Text(StringConstant.notMatch),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                      } else {
                        Navigator.of(context).pushNamed(Routes.detailsRoute);
                        setState(() {
                          emailController.clear();
                          nameController.clear();
                          _formKey.currentState?.reset();
                        });
                      }
                    }
                  }),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
