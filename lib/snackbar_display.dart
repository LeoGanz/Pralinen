import 'package:flutter/material.dart';

class SnackBarDisplay extends StatelessWidget {
  const SnackBarDisplay(
      {Key? key,
      required this.msg,
      this.child,
      this.duration = const Duration(seconds: 2)})
      : super(key: key);

  final String msg;
  final Widget? child;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        duration: duration,
      )),
      child: child,
    );
  }
}
