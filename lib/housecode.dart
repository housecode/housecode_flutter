/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-08-26 19:15
 */

library housecode;

import 'package:flutter/foundation.dart';

String toString(dynamic value) {
  if (value == null) return "";
  if (value is String) return value;
  return "$value";
}

int toInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  return int.parse(value);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  String removeAllHtmlTags() {
    var htmlText = this;
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}

class Notifier<T> extends ChangeNotifier implements ValueListenable<T> {
  Notifier(this._value);
  T _value;

  @override
  T get value => _value;

  set value(T newValue) {
    if (_value == newValue) return;
    _value = newValue;
    notifyListeners();
  }

  void setValueWithNoNotify(T newValue) {
    if (_value == newValue) return;
    _value = newValue;
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';
}
