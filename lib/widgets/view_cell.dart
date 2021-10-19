/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-08-26 19:15
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// view cell for Listview itemBuilder
// ignore: must_be_immutable
class ViewCell extends StatelessWidget {
  ViewCell({
    required this.child,
    this.hasUneventRows = false,
    this.padding,
    this.detail,
    this.onTap,
    this.showIcon,
    this.iconColor,
    this.icon,
    this.enableSelection = true,
    this.expanded = true,
  });

  final Widget child;
  EdgeInsetsGeometry? padding;
  bool? hasUneventRows;
  Widget? detail;
  IconData? icon;
  Color? iconColor;
  bool? showIcon;
  bool enableSelection;
  final bool expanded;

  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: enableSelection
            ? onTap ?? () {}
            : null, // always set onTap to activate ripple effect
        child: Ink(
          color: Colors.white,
          child: Container(
            height: (hasUneventRows ?? false) ? null : 44,
            padding: padding ?? EdgeInsets.only(left: 10, right: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                child,
                Visibility(
                  visible: !expanded,
                  child: Container(width: 5),
                ),
                Visibility(
                  visible: detail != null,
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: expanded
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        detail ?? Container(),
                        Container(
                            width: onTap != null && (showIcon ?? false) == true
                                ? 5
                                : 0),
                        Icon(
                          icon ?? CupertinoIcons.chevron_right,
                          color: iconColor ?? CupertinoColors.systemBlue,
                          size: onTap != null && (showIcon ?? false) == true
                              ? 16
                              : 0,
                        ),
                      ],
                    ),
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
