/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-08-26 19:15
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// checkbox widget with cupertino style
// ignore: must_be_immutable
class CupertinoCheckBox extends StatefulWidget {
  CupertinoCheckBox({
    GlobalKey? key,
    required this.onChecked,
    this.iconColor,
    this.checked = false,
  }) : super(key: key);

  bool checked;
  Color? iconColor;
  final ValueChanged<bool> onChecked;

  @override
  State<StatefulWidget> createState() => CupertinoCheckBoxState();
}

class CupertinoCheckBoxState extends State<CupertinoCheckBox> {
  void setChecked(bool isChecked) {
    setState(() {
      checked = isChecked;
      icon = checked
          ? CupertinoIcons.check_mark_circled_solid
          : CupertinoIcons.circle;
    });
  }

  late bool checked;
  late IconData icon;

  @override
  void initState() {
    super.initState();

    setState(() {
      checked = widget.checked;
      icon = checked
          ? CupertinoIcons.check_mark_circled_solid
          : CupertinoIcons.circle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          checked = !checked;
          icon = checked
              ? CupertinoIcons.check_mark_circled_solid
              : CupertinoIcons.circle;
          widget.onChecked(checked);
        });
      },
      child: Icon(
        icon,
        color: widget.iconColor ?? CupertinoColors.systemBlue,
      ),
    );
  }
}
