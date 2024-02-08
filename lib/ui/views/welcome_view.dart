import 'package:flutter/material.dart';
import 'package:mvvm_demo/core/constants/color_constants.dart';
import 'package:mvvm_demo/core/constants/image_constants.dart';
import 'package:mvvm_demo/core/constants/string_constants.dart';
import 'package:mvvm_demo/core/routing/routes.dart';
import 'package:mvvm_demo/ui/widgets/common_elevated_button.dart';
import 'package:mvvm_demo/ui/widgets/common_text.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return welcomeMethod(context);
  }

  Scaffold welcomeMethod(BuildContext context) {
    return Scaffold(
    body: Stack(children: [
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageConstant.backgroundImage),
                fit: BoxFit.cover)),
      ),
      Positioned(
          bottom: 250,
          left: 100,
          child: TextWidget(
            text: StringConstant.welcome,
            fontWeight: FontWeight.bold,
            size: 40,
          )),
      Positioned(
          bottom: 180,
          left: 22,
          right: 22,
          child: ElevatedBtnWidget(
              onpress: () {
                Navigator.of(context).pushNamed(Routes.loginRoute);
              },
              color: ColorConstant.black,
              name: StringConstant.login,
              textColor: ColorConstant.white)),
      Positioned(
          bottom: 94,
          left: 22,
          right: 22,
          child: ElevatedBtnWidget(
            onpress: () {
              Navigator.of(context).pushNamed(Routes.registerRoute);
            },
            color: ColorConstant.white,
            name: StringConstant.register,
            textColor: ColorConstant.black,
          )),
    ]),
  );
  }
}
