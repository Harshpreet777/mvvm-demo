class Validations {
  static String? isNameValid(String name) {
    String namePattern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = RegExp(namePattern);
    if (name.toString().isEmpty) {
      return "Cannot be Empty";
    } else if (!regExp.hasMatch(name)) {
      return "Only Characters are allowed";
    }
    return null;
  }

  static String? isEmailValid(String email) {
    String emailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(emailPattern);
    if (email.toString().isEmpty) {
      return "Cannot be Empty";
    } else if (!regExp.hasMatch(email)) {
      return "Email is Not Valid";
    }
    return null;
  }
}
