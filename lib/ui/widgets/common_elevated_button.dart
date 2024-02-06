import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ElevatedBtnWidget extends StatelessWidget {
  Color color;
  String name;
  Color textColor;
  final VoidCallback? onpress;

  ElevatedBtnWidget(
      {super.key,
      required this.color,
      required this.name,
      required this.textColor,
      this.onpress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)))),
              backgroundColor: MaterialStatePropertyAll(color),
              side: const MaterialStatePropertyAll(BorderSide(
                  color: Colors.black, style: BorderStyle.solid, width: 2))),
          onPressed: onpress,
          child: Text(
            name,
            style: TextStyle(color: textColor, fontSize: 16),
          )),
    );
  }
}
