import 'package:flutter/material.dart';
import 'package:mvvm_demo/core/constants/color_constants.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatelessWidget {
  TextEditingController? controller;
  String name;
  final String? Function(String?)? validator;

  TextFormFieldWidget(
      {super.key, this.controller, required this.name, this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: TextFormField(
        controller: controller,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            hintStyle: TextStyle(color: ColorConstant.grey),
            filled: true,
            hintText: name,
            fillColor: ColorConstant.lightGrey,
            focusedErrorBorder:
                const OutlineInputBorder(borderSide: BorderSide.none),
            errorBorder:
                const UnderlineInputBorder(borderSide: BorderSide.none),
            focusedBorder:
                const OutlineInputBorder(borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                  color: ColorConstant.borderColorE8ECF4,
                  style: BorderStyle.solid,
                  width: 1),
            )),
      ),
    );
  }
}
