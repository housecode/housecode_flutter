/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-08-26 19:15
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:housecode/widgets/circular_indicator.dart';

/// Loading class to show/hide loading dalog
class Loading {
  void show(BuildContext context, {String? message, bool useLight = true}) {
    var loading = _loading(loadingMessage: message);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        popContext = ctx;
        return useLight
            ? Theme(data: ThemeData.light(), child: loading)
            : loading;
      },
    );
  }

  BuildContext? popContext;

  void hide() {
    if (popContext != null) Navigator.pop(popContext!);
  }
}

Widget _loading({String? loadingMessage}) {
  return Container(
    height: double.infinity,
    width: double.infinity,
    color: Colors.transparent,
    child: Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularIndicator(colorIndicator: Colors.black),
            Visibility(
              visible: loadingMessage != null,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  loadingMessage == null ? "" : loadingMessage,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
