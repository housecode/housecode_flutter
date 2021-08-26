/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-08-26 19:15
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectableViewCell extends StatelessWidget {
  SelectableViewCell({
    required this.child,
    required this.selected,
    this.selectedIcon,
    this.iconColor,
    this.onTap,
  });

  final Widget child;
  final bool selected;
  Color? iconColor;
  IconData? selectedIcon;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap ?? () {},
        child: Ink(
          color: Colors.white,
          child: Container(
            height: 44,
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                child,
                Expanded(child: Container()),
                Container(width: selected ? 5 : 0),
                Visibility(
                  visible: selected,
                  child: Icon(
                    selectedIcon ?? CupertinoIcons.check_mark,
                    color: iconColor ?? CupertinoColors.systemBlue,
                    size: selected ? 16 : 0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
