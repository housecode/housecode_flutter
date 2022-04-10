/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-08-26 19:15
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// show message dialog
void showMessage(BuildContext context, String message,
    {bool useLight = true, void Function()? onOk}) {
  var dialog = (BuildContext ctx) => CupertinoAlertDialog(
        content: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Text(message),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("OK"),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(ctx);
              if (onOk != null) onOk();
            },
          )
        ],
      );

  showCupertinoDialog(
    context: context,
    builder: (BuildContext ctx) => useLight
        ? Theme(
            data: ThemeData.light(),
            child: dialog(ctx),
          )
        : dialog(ctx),
  );
}

/// show confirm dialog
void showConfirm(BuildContext context, String message, Function onAccept,
    {Function? onCancel}) async {
  await showConfirmation(context, message, onAccept, onCancel: onCancel);
}

/// show confirm dialog with result
Future<T?> showConfirmation<T>(
    BuildContext context, String message, Function onAccept,
    {Function? onCancel, bool useLight = true}) async {
  var dialog = (BuildContext ctx) => CupertinoAlertDialog(
        content: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Text(message),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("Yes"),
            onPressed: () {
              Navigator.pop(ctx);
              onAccept();
            },
          ),
          CupertinoDialogAction(
            child: Text("No"),
            isDefaultAction: true,
            onPressed: () {
              if (onCancel != null) onCancel();
              Navigator.pop(ctx);
            },
          ),
        ],
      );
  var result = await showCupertinoDialog(
    context: context,
    builder: (ctx) => useLight
        ? Theme(data: ThemeData.light(), child: dialog(ctx))
        : dialog(ctx),
  );
  return result;
}

typedef PickerItemSelected = void Function(int index);

/// show picker dialog with List of string items
void showPicker(
  BuildContext context,
  List<String> items, {
  PickerItemSelected? itemSelected,
  PickerItemSelected? onDone,
  bool useLight = true,
  Color textColor = Colors.black,
  int? startIndex,
  String? title,
}) {
  var selected = 0;
  var controller = FixedExtentScrollController(initialItem: startIndex ?? 0);
  var views = items
      .map((item) => Center(
              child: Text(
            item,
            style: TextStyle(color: textColor),
          )))
      .toList();

  var picker = () => CupertinoPicker(
        scrollController: controller,
        onSelectedItemChanged: (index) {
          selected = index;
          if (itemSelected != null) itemSelected(selected);
        },
        magnification: 1.2,
        looping: false,
        itemExtent: 40.0,
        children: views,
      );

  showModalBottomSheet(
    context: context,
    backgroundColor: CupertinoColors.systemGrey6,
    clipBehavior: Clip.hardEdge,
    builder: (BuildContext ctx) {
      return Container(
        height: (MediaQuery.of(context).size.height / 3) + 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Visibility(
                    visible: title != null,
                    child: Text(
                      title ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 35,
                      width: 60,
                      child: CupertinoButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          if (onDone != null) onDone(selected);
                        },
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "Done",
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: useLight
                  ? Theme(data: ThemeData.light(), child: picker())
                  : picker(),
            ),
          ],
        ),
      );
    },
  );
}

typedef DateTimePickerSelected = void Function(DateTime);

/// show time picket dialog with cupertino style
void showTimePicker(
  BuildContext context, {
  bool useLight = true,
  Color textColor = Colors.black,
  DateTimePickerSelected? onDone,
  DateTime? initialTime,
  String? title,
}) {
  var selected = initialTime ?? DateTime.now();

  var picker = () => CupertinoDatePicker(
        initialDateTime: initialTime ?? DateTime.now(),
        mode: CupertinoDatePickerMode.time,
        onDateTimeChanged: (date) => selected = date,
      );

  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return Container(
        height: (MediaQuery.of(context).size.height / 3) + 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Visibility(
                    visible: title != null,
                    child: Text(
                      title ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 35,
                      width: 60,
                      child: CupertinoButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          if (onDone != null) onDone(selected);
                        },
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "Done",
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: useLight
                  ? Theme(data: ThemeData.light(), child: picker())
                  : picker(),
            ),
          ],
        ),
      );
    },
  );
}

/// show date picket dialog with cupertino style
void showDatePicker(
  BuildContext context, {
  bool useLight = true,
  Color textColor = Colors.black,
  DateTimePickerSelected? onDone,
  DateTime? initialDate,
  String? title,
}) {
  var selected = initialDate ?? DateTime.now();

  var picker = () => CupertinoDatePicker(
        initialDateTime: initialDate ?? DateTime.now(),
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (date) => selected = date,
      );

  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return Container(
        height: (MediaQuery.of(context).size.height / 3) + 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Visibility(
                    visible: title != null,
                    child: Text(
                      title ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 35,
                      width: 60,
                      child: CupertinoButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          if (onDone != null) onDone(selected);
                        },
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "Done",
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: useLight
                  ? Theme(data: ThemeData.light(), child: picker())
                  : picker(),
            ),
          ],
        ),
      );
    },
  );
}

void showActionSheet(
  BuildContext context,
  List<String> items, {
  PickerItemSelected? itemSelected,
  bool useLight = true,
  Color textColor = Colors.black,
  String? title,
  String? message,
}) {
  var views = (c) => items
      .map((item) => CupertinoActionSheetAction(
            child: Center(
              child: Text(
                item,
                style: TextStyle(color: textColor),
              ),
            ),
            onPressed: () {
              if (itemSelected != null) itemSelected(items.indexOf(item));
              Navigator.pop(c);
            },
          ))
      .toList();

  var picker = (c) => CupertinoActionSheet(
        actions: views(c),
        title: title == null
            ? null
            : Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
        message: message == null
            ? null
            : Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                ),
              ),
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            "Cancel",
            style: TextStyle(color: textColor),
          ),
          onPressed: () {
            Navigator.pop(c);
          },
        ),
      );

  showCupertinoModalPopup(
    context: context,
    builder: (c) {
      return useLight
          ? Theme(data: ThemeData.light(), child: picker(c))
          : picker(c);
    },
  );
}
