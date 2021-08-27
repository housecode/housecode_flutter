/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-08-26 19:15
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// show message dialog
void showMessage(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext ctx) => CupertinoAlertDialog(
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
          onPressed: () => Navigator.pop(ctx),
        )
      ],
    ),
  );
}

/// show confirm dialog
void showConfirm(BuildContext context, String message, Function onAccept,
    {Function? onCancel}) async {
  await showConfirmation(context, message, onAccept, onCancel: onCancel);
}

Future<T?> showConfirmation<T>(
    BuildContext context, String message, Function onAccept,
    {Function? onCancel}) async {
  var result = await showDialog<T>(
    context: context,
    builder: (BuildContext ctx) => CupertinoAlertDialog(
      content: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Text(message),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          child: Text("Yes"),
          onPressed: () => onAccept(),
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
    ),
  );
  print("Confirm: $result");
  return result;
}

typedef PickerItemSelected = void Function(int index);

/// show picker dialog with List of string items
void showPicker(
  BuildContext context,
  List<String> items, {
  PickerItemSelected? itemSelected,
  PickerItemSelected? onDone,
}) {
  var selected = 0;
  var controller = FixedExtentScrollController();
  var views = items.map((item) => Center(child: Text(item))).toList();

  showModalBottomSheet(
    context: context,
    clipBehavior: Clip.hardEdge,
    builder: (BuildContext ctx) {
      return Container(
        height: (MediaQuery.of(context).size.height / 3) + 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(right: 5, top: 5),
              color: Colors.white,
              width: double.infinity,
              child: Align(
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
            ),
            Expanded(
              child: CupertinoPicker(
                scrollController: controller,
                backgroundColor: CupertinoColors.systemGrey6,
                onSelectedItemChanged: (index) {
                  selected = index;
                  if (itemSelected != null) itemSelected(selected);
                },
                magnification: 1.2,
                looping: false,
                itemExtent: 40.0,
                children: views,
              ),
            ),
          ],
        ),
      );
    },
  );
}
