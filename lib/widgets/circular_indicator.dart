/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-08-26 19:15
 */

import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CircularIndicator extends StatelessWidget {
  /// android only
  Color? colorIndicator;

  /// ios only
  double? size;

  bool? useDarkTheme;
  bool? iosOnly;

  CircularIndicator({
    this.colorIndicator,
    this.useDarkTheme = false,
    this.iosOnly = false,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return (iosOnly ?? false)
        ? _cupertino(context)
        : (Platform.isIOS ? _cupertino(context) : _material(context));
  }

  Widget _cupertino(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoTheme.of(context).copyWith(
          brightness:
              (useDarkTheme ?? false) ? Brightness.dark : Brightness.light),
      child: CupertinoActivityIndicator(radius: size ?? 10.0),
    );
  }

  Widget _material(BuildContext context) {
    return CircularProgressIndicator(
      color: (useDarkTheme ?? false)
          ? Colors.white
          : (colorIndicator ?? Colors.black),
    );
  }
}
