/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-08-26 19:15
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import 'package:housecode/widgets/circular_indicator.dart';

/// modal loading dialog
// ignore: must_be_immutable
class LoadingDialog extends StatelessWidget {
  final Widget child;
  final bool isAsync;

  double? opacity;
  String? loadingMessage;
  bool? useSafeArea;

  LoadingDialog({
    Key? key,
    required this.child,
    required this.isAsync,
    this.opacity,
    this.loadingMessage,
    this.useSafeArea = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isAsync,
      child: child,
      dismissible: false,
      opacity: opacity == null ? 0.5 : opacity!,
      progressIndicator:
          useSafeArea! ? SafeArea(child: _loading()) : _loading(),
    );
  }

  Widget _loading() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Color(0x44000000), spreadRadius: 2)],
            borderRadius: BorderRadius.circular(5),
            color: CupertinoColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularIndicator(colorIndicator: CupertinoColors.systemBlue),
              Visibility(
                visible: loadingMessage != null,
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(loadingMessage == null ? "" : loadingMessage!),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
