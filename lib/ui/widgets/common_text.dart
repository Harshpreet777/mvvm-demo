import 'package:flutter/material.dart';
import 'package:mvvm_demo/core/constants/color_constants.dart';

// ignore: must_be_immutable
class TextWidget extends StatelessWidget {
  TextWidget({super.key, this.size, this.fontWeight, required this.text});
  double? size;
  FontWeight? fontWeight;
  String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(text,
            style: TextStyle(
                color: ColorConstant.black,
                fontSize: size,
                fontWeight: fontWeight)),
      ),
    );
  }
}
