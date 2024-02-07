import 'package:fluttertoast/fluttertoast.dart';

class FlutterToastUtil {
  static showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }
}
