/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-09-23 19:15
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housecode/widgets/view_cell.dart';

typedef SwitchValueChanged = void Function(bool isEnable);

class SwitchCell extends StatefulWidget {
  final bool initialValue;
  final String title;
  final SwitchValueChanged onChanged;

  SwitchCell(bool value, String title, SwitchValueChanged onChanged)
      : this.initialValue = value,
        this.onChanged = onChanged,
        this.title = title;

  @override
  State<StatefulWidget> createState() => _SwitchCellState();
}

class _SwitchCellState extends State<SwitchCell> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return ViewCell(
      child: Text(
        widget.title,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      enableSelection: false,
      detail: CupertinoSwitch(
        value: _value,
        onChanged: (value) {
          setState(() {
            _value = value;
          });
          widget.onChanged(_value);
        },
      ),
    );
  }
}
