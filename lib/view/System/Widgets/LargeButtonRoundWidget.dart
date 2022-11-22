import 'package:flutter/material.dart';

class LargeButtonRound extends StatelessWidget {
  const LargeButtonRound({
    Key? key,
    required this.title,
    required this.desc,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String desc;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 60),
          backgroundColor: Theme.of(context).focusColor,
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)))),
      onPressed: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 1),
          Text(
            desc,
            style: const TextStyle(fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}
