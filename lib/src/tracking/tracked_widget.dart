import 'package:flutter/material.dart';

import '../core/rebuild_tracker.dart';

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
  @override
  Widget build(BuildContext context) {
    RebuildTracker.track(widget.name);

    return widget.child;
  }
}