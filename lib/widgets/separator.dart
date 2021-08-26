/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-08-26 19:15
 */

import 'package:flutter/cupertino.dart';

class Separator extends StatelessWidget {
  Separator({
    this.margin,
    this.height = 0.5,
    this.color = CupertinoColors.separator,
  });

  final Color? color;
  final double? height;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin ?? EdgeInsets.only(left: 14),
      width: double.infinity,
      color: color,
    );
  }
}
