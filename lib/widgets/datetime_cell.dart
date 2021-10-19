/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-09-23 19:15
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housecode/housecode.dart';
import 'package:housecode/widgets/dialogs.dart' as dialog;
import 'package:intl/intl.dart';

typedef DateTimeSelected = void Function(DateTime dateTime);

@Deprecated("Use DateTimePickerCell instead.")
class DateTimeCell extends DateTimePickerCell {
  DateTimeCell(
    String title,
    DateTimeSelected onSelected, {
    DateTimeCellMode mode = DateTimeCellMode.Date,
    DateTime? initialDateTime,
    String? dateTimeFormat,
  }) : super(
          title,
          onSelected,
          dateTimeFormat: dateTimeFormat,
          initialDateTime: initialDateTime,
          mode: mode,
        );
}

class DateTimePickerCell extends StatefulWidget {
  final DateTimeCellMode mode;
  final DateTime initialDateTime;
  final DateTimeSelected onSelected;
  final String? dateTimeFormat;
  final String title;

  /// [mode] default is [DateTimeCellMode.Date]
  ///
  /// [initialDateTime] if null then use [DateTime.now()]
  DateTimePickerCell(
    String title,
    DateTimeSelected onSelected, {
    this.mode = DateTimeCellMode.Date,
    DateTime? initialDateTime,
    this.dateTimeFormat,
  })  : this.title = title,
        this.onSelected = onSelected,
        this.initialDateTime = initialDateTime ?? DateTime.now();

  @override
  State<StatefulWidget> createState() => _DateTimeCellState();
}

class _DateTimeCellState extends State<DateTimePickerCell> {
  String format = "";

  @override
  void initState() {
    super.initState();
    if (widget.mode == DateTimeCellMode.Date)
      format = widget.dateTimeFormat ?? "MMM dd, yyyy";
    else if (widget.mode == DateTimeCellMode.Time)
      format = widget.dateTimeFormat ?? "HH:mm";

    _strDateTime = DateFormat(format).format(widget.initialDateTime);
    _initialDateTime = widget.initialDateTime;
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
          onTap: onTapped,
          child: Ink(
            color: Colors.white,
            child: Container(
              width: widget.mode == DateTimeCellMode.Time ? 90 : 120,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: CupertinoColors.systemBlue),
              ),
              child: Text(_strDateTime, textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
    );
  }

  String _strDateTime = "";
  DateTime? _initialDateTime;

  void onTapped() {
    if (widget.mode == DateTimeCellMode.Date)
      dialog.showDatePicker(
        context,
        initialDate: _initialDateTime,
        onDone: (dateTime) {
          _initialDateTime = dateTime;
          setState(() {
            _strDateTime = DateFormat(format).format(dateTime);
          });
          widget.onSelected(dateTime);
        },
      );
    else if (widget.mode == DateTimeCellMode.Time)
      dialog.showTimePicker(
        context,
        initialTime: _initialDateTime,
        onDone: (dateTime) {
          _initialDateTime = dateTime;
          setState(() {
            _strDateTime = DateFormat(format).format(dateTime);
          });
          widget.onSelected(dateTime);
        },
      );
    else
      dialog.showMessage(context, "Unkown mode.");
  }
}
