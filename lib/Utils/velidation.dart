import 'package:flutter/material.dart';

Pattern emailRegx =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
Pattern websiteRegx =
    r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})';
Pattern digitRegx = r'^([0-9]*[.])?[0-9]+$';
Pattern formulaFieldRegx = r"field\('([a-zA-z0-9\_\s]+)'\)";

class AppFieldValidations {
  static emptyText(value, label) {
    if (value == null || value.isEmpty) {
      return 'Please enter ${label}';
    }
    return null;
  }

  static emailValidation(text) {
    if (text.isEmpty) {
      return 'Please enter email';
    } else if (text.isNotEmpty) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(text)) {
        return "Please enter valid email address";
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static emailmobileFiledValidation(text) {
    if (text.length == 0) {
      return 'Please enter email';
    } else {
      if (text.contains(new RegExp(r'[a-zA-Z]'))) {
        return emailValidation(text);
      } else if (!text.contains(new RegExp(r'[a-zA-Z]'))) {
        if (text.length < 10 || text.length > 10) {
          return 'Please enter valid mobile number';
        } else {
          return null;
        }
      }
      return null;
    }
  }

  static loginPasswordValidation(text) {
    if (text.isEmpty) {
      return 'Please enter password';
    } else {
      return null;
    }
  }

  static passwordValidation(text) {
    if (text.isEmpty) {
      return 'Please enter password';
    } else if (text.length < 6) {
      return "Password length should be more then 6 digits";
    } else {
      return null;
    }
  }

  static phoneValidation(text) {
    if (text.isEmpty) {
      return 'Please enter phone';
    } else if (text.contains(new RegExp(r'[a-zA-Z]')) ||
        text.length < 10 ||
        text.length > 10) {
      return 'Please enter valid phone number';
    } else {
      return null;
    }
  }

  static confirmpasswordValidation(confirmpassword, password) {
    if (confirmpassword.isEmpty) {
      return 'Please enter confirmed password';
    } else if (confirmpassword.length < 6) {
      return "Confirmed password length should be more then 6 digits";
    } else if (password != confirmpassword) {
      return "Password does not matched";
    } else {
      return null;
    }
  }

  static emptyEditText(text) {
    if (text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  static dynamicWidgetTextFormFieldValidation(dynamicdata, String text) {
    if (dynamicdata['required'] == true) {
      if (text.isEmpty) {
        return 'Please enter ${dynamicdata['value']}';
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static mobileValidation(text, label) {
    if (text.isEmpty) {
      return 'Please enter ${label}';
    } else if (text.length != 10) {
      return 'Please enter valid ${label}';
    } else {
      return null;
    }
  }

  static websiteValidation(text, label) {
    if (text.isEmpty) {
      return 'Please enter ${label}';
    } else {
      RegExp regex = new RegExp(websiteRegx);
      if (!regex.hasMatch(text)) {
        return "Please enter valid ${label}";
      } else {
        return null;
      }
    }
  }

  static numberWithDecimalValidation(text, label, [extra]) {
    if (text.isEmpty) {
      return 'Please enter ${label}';
    } else {
      int decimal =
          extra != null && extra['decimal'] != null ? extra['decimal'] : null;
      if (![null].contains(decimal)) {
        var digitAfterDecimal =
            text.indexOf('.') != -1 ? text.split('.').last : '';
        if (digitAfterDecimal.length > decimal)
          return "only ${decimal} decimal are allowed";
      }
      RegExp regex = new RegExp(digitRegx);
      if (!regex.hasMatch(text)) {
        return "Please enter valid ${label}";
      } else {
        return null;
      }
    }
  }

  static numberValidation(text, label) {
    if (text.isEmpty) {
      return 'Please enter ${label}';
    } else {
      RegExp regex = new RegExp(digitRegx);
      if (!regex.hasMatch(text)) {
        return "Please enter valid ${label}";
      } else {
        return null;
      }
    }
  }

  static checkboxValidation(text, label) {
    if (text == null) {
      return 'Please select ${label}';
    }
    return null;
  }

  static emptyArrayValidation(v, label) {
    if (v == null || (v != null && v.length == 0)) {
      return 'Please select ${label}';
    }
    return null;
  }

  static emptyDateValidation(v, label) {
    if (v == null || !(v is DateTime)) {
      return 'Please select ${label}';
    }
    return null;
  }

  static emptyTimelineValidation(v, label) {
    if (v == null || !(v is DateTimeRange)) {
      return 'Please select ${label}';
    }
    return null;
  }

  static emptyTimeValidation(v, label) {
    if (v == null || !(v is TimeOfDay)) {
      return 'Please select ${label}';
    }
    return null;
  }

  static emptyChecklistValidation(v, label) {
    if (v.isEmpty ||
        (v.isNotEmpty && v.where((e) => e.completed == true).length == 0)) {
      return 'Please select ${label}';
    }
    return null;
  }

  static checkProgressbarValidation(value, label) {
    if (value == null) {
      return 'Please enter ${label}';
    } else {
      return null;
    }
  }

  static connectedBoardValidation(value, label) {
    if (value == null) {
      return 'Please select ${label}';
    } else {
      return null;
    }
  }

  static actualScoreValidation(value, totalValue) {
    RegExp digitReg = new RegExp(digitRegx);
    if (value.isEmpty) {
      return 'Please enter actual score';
    } else if (totalValue.isEmpty) {
      return "Please enter total score";
    } else if (!digitReg.hasMatch(value)) {
      return 'Please enter valid digit.';
    } else if (double.parse(value) > double.parse(totalValue)) {
      return "actual score must be less then equal to total score";
    } else {
      return null;
    }
  }

  static totalScoreValidation(value) {
    RegExp digitReg = new RegExp(digitRegx);
    if (value.isEmpty) {
      return 'Please enter actual score';
    } else if (!digitReg.hasMatch(value)) {
      return 'Please enter valid digit.';
    } else {
      return null;
    }
  }

  static validEmailValidation(text, label) {
    if (text.isEmpty) {
      return 'Please enter ${label}}';
    } else if (text.isNotEmpty) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(text)) {
        return "Please enter valid ${label}";
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
