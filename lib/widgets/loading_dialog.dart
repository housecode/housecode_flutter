import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:housecode/widgets/circular_indicator.dart';

class Loading {
  void show(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        popContext = ctx;
        return _loading(loadingMessage: message);
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
