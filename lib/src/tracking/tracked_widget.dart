import 'package:flutter/material.dart';

class TrackedWidget extends StatefulWidget {
  final Widget child;
  final String name;

  const TrackedWidget({
    super.key,
    required this.child,
    required this.name,
  });

  @override
  State<TrackedWidget> createState() => _TrackedWidgetState();
}

class _TrackedWidgetState extends State<TrackedWidget> {
  int rebuilds = 0;

  @override
  Widget build(BuildContext context) {
    rebuilds++;

    debugPrint('${widget.name} rebuilt $rebuilds times');

    return widget.child;
  }
}