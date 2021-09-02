/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-08-26 19:15
 */

library housecode;

import 'package:flutter/foundation.dart';

// export internal widgets
export 'widgets/checkbox.dart';
export 'widgets/checkbox_cell.dart';
export 'widgets/circular_indicator.dart';
export 'widgets/dialogs.dart';
export 'widgets/loading_dialog.dart';
export 'widgets/selectable_view_cell.dart';
export 'widgets/separator.dart';
export 'widgets/text_cell.dart';
export 'widgets/view_cell.dart';

extension DynamicExtension on dynamic {
  /// parse dynamic to int used when parsing json
  int toInt() {
    var value = this;
    if (value == null) return 0;
    if (value is int) return value;
    return int.parse(value);
  }

  /// replace null with default value
  T coalesce<T>(T defaultValue) {
    if (this is String) {
      String? str = this;
      return (str ?? "").isEmpty ? defaultValue : this;
    }
    return this == null ? defaultValue : this;
  }

  /// parse dynamic to int used when parsing json
  double toDouble() {
    var value = this;
    if (value == null) return 0;
    if (value is double) return value;
    return double.parse(value);
  }

  /// parse dynamic to string used when parsing json
  String stringValue() {
    if (this == null) return "";
    if (this is String) return this;
    return "$this";
  }
}

extension StringExtension on String {
  /// capitalize first letter of string
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  /// remove all HTML tags from a string
  String removeAllHtmlTags() {
    var htmlText = this;
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}

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
