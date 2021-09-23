/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-09-23 19:15
 */

import 'package:flutter/foundation.dart';

/// notifier class property
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
