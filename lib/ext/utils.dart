/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-09-23 19:15
 */

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

/// class utility for value checking
class Utils {
  /// convert dynamic to string
  static String stringValue(dynamic data) {
    if (data == null) return "";
    if (data is String) return data;
    return "$data";
  }

  /// colesce string?
  static String replaceString(String? text, {String defaultValue = ""}) {
    if ((text ?? "").isEmpty) return defaultValue;
    return text!;
  }

  /// coalesce bool?
  static bool replaceBool(bool? value, {bool defaultValue = false}) {
    if (value == null) return defaultValue;
    return value;
  }

  /// coalesce int?
  static int replaceInt(int? value, {int defaultValue = 0}) {
    if (value == null) return defaultValue;
    return value;
  }

  /// coalesce double?
  static double replaceDouble(double? value, {double defaultValue = 0}) {
    if (value == null) return defaultValue;
    return value;
  }
}

extension DynamicExtension on dynamic {
  /// replace null with default value
  T coalesce<T>(T defaultValue) {
    if (this is String) {
      String? str = this;
      return (str ?? "").isEmpty ? defaultValue : this;
    }
    return this == null ? defaultValue : this;
  }

  /// parse dynamic to int used when parsing json
  int toInt() {
    if (this == null) return 0;
    if (this is int) return this;
    if (this is double) return this.round();
    if (this is String) return int.parse(this);
    return 0;
  }

  /// parse dynamic to int used when parsing json
  double toDouble() {
    if (this == null) return 0;
    if (this is int) return this;
    if (this is double) return this;
    if (this is String) return double.parse(this);
    return 0;
  }
}
