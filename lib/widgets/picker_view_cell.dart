/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-10-19 16:15
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housecode/widgets/dialogs.dart';
import 'package:housecode/widgets/view_cell.dart';

/// picker view cell for Listview itemBuilder
// ignore: must_be_immutable
class PickerViewCell extends StatefulWidget {
  final String title;
  final List<String> items;
  void Function(int index)? onSelected;
  double? pickerSize;
  int? index;

  PickerViewCell({
    required this.title,
    required this.items,
    this.onSelected,
    this.pickerSize,
    this.index,
  }) : assert(items.isNotEmpty, "items mus have at least 1 value(s)");

  @override
  State<StatefulWidget> createState() => _PickerViewCellState();
}

class _PickerViewCellState extends State<PickerViewCell> {
  @override
  void initState() {
    super.initState();
    _index = widget.index ?? 0;
    _selected = widget.items[_index];
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
      hasUneventRows: true,
      padding: EdgeInsets.only(left: 12, top: 8, right: 10, bottom: 8),
      enableSelection: false,
      detail: Material(
        child: InkWell(
          onTap: _onTap,
          child: Ink(
            color: Colors.white,
            child: Container(
              width: widget.pickerSize ?? 120,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: CupertinoColors.systemBlue),
              ),
              child: Text(_selected, textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
    );
  }

  late int _index;
  String _selected = "";

  void _onTap() {
    showPicker(
      context,
      widget.items,
      startIndex: _index,
      onDone: (index) {
        _index = index;
        setState(() {
          _selected = widget.items[index];
        });
        if (widget.onSelected != null) widget.onSelected!(index);
      },
    );
  }
}
