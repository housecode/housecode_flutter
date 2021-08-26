/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-08-26 19:15
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'checkbox.dart';
import 'view_cell.dart';

// ignore: must_be_immutable
class CheckboxCell extends StatefulWidget {
  CheckboxCell({
    GlobalKey? key,
    this.checked = false,
    this.title,
    this.onTap,
    this.detail,
    this.titleColor,
    this.detailColor,
    required this.onChecked,
  }) : super(key: key);

  bool checked;
  String? title;
  String? detail;
  Color? titleColor;
  Color? detailColor;

  final ValueChanged<bool> onChecked;
  ValueChanged<ValueChanged<String>>? onTap;

  @override
  State<StatefulWidget> createState() => CheckboxCellState();
}

class CheckboxCellState extends State<CheckboxCell> {
  GlobalKey<CupertinoCheckBoxState> _checkboxState =
      GlobalKey<CupertinoCheckBoxState>();

  void setChecked(bool isChecked) {
    _checkboxState.currentState!.setChecked(isChecked);
  }

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
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CupertinoCheckBox(
              key: _checkboxState,
              onChecked: widget.onChecked,
              checked: widget.checked,
            ),
            Container(
              width: 10,
            ),
            Text(
              widget.title == null ? "" : widget.title!,
              style: TextStyle(color: widget.titleColor ?? Colors.black),
            ),
          ],
        ),
      ),
      // onTap works only if checked is true
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!((text) {
            if (!_checkboxState.currentState!.checked || widget.onTap == null)
              return;
            setState(() => _detail = text);
          });
        }
      },
      detail: Flexible(
        child: Text(
          _detail,
          textAlign: TextAlign.right,
          style: TextStyle(
              color: widget.detailColor ?? CupertinoColors.systemGrey),
        ),
      ),
    );
  }
}
