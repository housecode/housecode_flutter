/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-08-26 19:15
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:housecode/widgets/view_cell.dart';

/// view cell for text only
// ignore: must_be_immutable
class TextCell extends StatefulWidget {
  TextCell({
    required this.title,
    this.detail,
    this.onTap,
    this.titleColor,
    this.detailColor,
    this.padding,
    this.hasUneventRows = false,
    this.showIcon = true,
    this.boldTitle = false,
    this.fontSize,
  });

  bool boldTitle;
  final String title;
  late String? detail;
  bool? hasUneventRows;
  late ValueChanged<ValueChanged<String>>? onTap;
  EdgeInsetsGeometry? padding;
  Color? titleColor;
  Color? detailColor;
  bool? showIcon;
  double? fontSize;

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
      hasUneventRows: widget.hasUneventRows,
      showIcon: !(widget.showIcon ?? true) ? false : widget.onTap != null,
      padding: widget.padding ?? EdgeInsets.only(left: 10, right: 10),
      child: Container(
        padding: EdgeInsets.only(left: 2),
        child: Text(
          widget.title,
          style: TextStyle(
            color: widget.titleColor ?? Colors.black,
            fontWeight: widget.boldTitle ? FontWeight.bold : null,
            fontSize: widget.fontSize == null ? null : widget.fontSize!,
          ),
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
          style: TextStyle(
            color: widget.detailColor ?? Colors.black,
            fontSize: widget.fontSize == null ? null : widget.fontSize!,
          ),
        ),
      ),
    );
  }
}
