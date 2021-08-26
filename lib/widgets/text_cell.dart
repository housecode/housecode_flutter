/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-08-26 19:15
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:housecode/widgets/view_cell.dart';

// ignore: must_be_immutable
class TextCell extends StatefulWidget {
  TextCell({
    required this.title,
    this.detail,
    this.onTap,
    this.titleColor,
    this.detailColor,
  });

  final String title;
  late String? detail;
  late ValueChanged<ValueChanged<String>>? onTap;
  Color? titleColor;
  Color? detailColor;

  @override
  State<StatefulWidget> createState() => _TextCellState();
}

class _TextCellState extends State<TextCell> {
  String _detail = "";

  @override
  void initState() {
    super.initState();
    _detail = widget.detail ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return ViewCell(
      showIcon: widget.onTap != null,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        padding: EdgeInsets.only(left: 2),
        child: Text(
          widget.title,
          style: TextStyle(color: widget.titleColor ?? Colors.black),
        ),
      ),
      onTap: widget.onTap == null
          ? null
          : () {
              if (widget.onTap != null)
                widget.onTap!((text) {
                  setState(() => _detail = text);
                });
            },
      detail: Flexible(
        child: Text(
          _detail,
          textAlign: TextAlign.right,
          style: TextStyle(color: widget.detailColor ?? Colors.black),
        ),
      ),
    );
  }
}
