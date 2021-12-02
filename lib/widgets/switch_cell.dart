/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-09-23 19:15
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housecode/widgets/view_cell.dart';

typedef SwitchValueChanged = void Function(bool isEnable);

// ignore: must_be_immutable
class SwitchCell extends StatefulWidget {
  bool isChecked;
  final String title;
  final SwitchValueChanged onChanged;

  SwitchCell(bool value, String title, SwitchValueChanged onChanged,
      {this.isAsync = false})
      : this.isChecked = value,
        this.onChanged = onChanged,
        this.title = title;

  final bool isAsync;

  @override
  State<StatefulWidget> createState() => _SwitchCellState();
}

class _SwitchCellState extends State<SwitchCell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewCell(
      child: Container(
        padding: EdgeInsets.only(left: 2),
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
      isAsync: widget.isAsync,
      enableSelection: false,
      detail: CupertinoSwitch(
        value: widget.isChecked,
        onChanged: (value) {
          setState(() {
            widget.isChecked = value;
          });
          widget.onChanged(widget.isChecked);
        },
      ),
    );
  }
}
