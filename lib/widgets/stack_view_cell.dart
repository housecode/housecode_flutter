/*
    Author: Housecode
    Email: info@housecode.net
    createTime:2021-11-24 00:16
 */

import 'package:flutter/cupertino.dart';
import 'package:housecode/widgets/view_cell.dart';

/// view cell for stack items
class StackViewCell extends StatelessWidget {
  final List<Widget> children;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final bool showIcon;

  StackViewCell({
    required this.children,
    this.showIcon = false,
    this.padding,
    this.onTap,
    this.isAsync = false,
  });

  final bool isAsync;

  @override
  Widget build(BuildContext context) {
    return ViewCell(
      onTap: onTap ?? () {},
      showIcon: showIcon,
      hasUneventRows: true,
      isAsync: isAsync,
      padding: padding ?? EdgeInsets.fromLTRB(12, 5, 5, 5),
      detail: showIcon ? Text("") : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
