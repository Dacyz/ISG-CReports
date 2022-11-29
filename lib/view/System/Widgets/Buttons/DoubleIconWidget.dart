import 'package:flutter/material.dart';

import '../../ProfileConstant.dart';

class DoubleIconWidget extends StatelessWidget {
  DoubleIconWidget({
    Key? key,
    required this.title,
    required this.sign,
    required this.desc,
  }) : super(key: key);

  final String? title;
  final String? sign;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultShortPadding),
      margin: EdgeInsets.symmetric(
          horizontal: defaultMiniPadding, vertical: defaultShortPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        boxShadow: const [
          BoxShadow(
            color: Colors.orange,
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(
              0,
              0,
            ), // changes position of shadow
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$title $sign ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('$desc'),
        ],
      ),
    );
  }
}
