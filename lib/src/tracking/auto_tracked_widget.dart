import 'package:flutter/material.dart';

import '../core/rebuild_tracker.dart';
import 'tracking_filter.dart';
import 'visual_tracked_widget.dart';

class AutoTrackedWidget extends StatefulWidget {
  final Widget child;

  const AutoTrackedWidget({super.key, required this.child});

  @override
  State<AutoTrackedWidget> createState() => _AutoTrackedWidgetState();
}

class _AutoTrackedWidgetState extends State<AutoTrackedWidget> {
  @override
  Widget build(BuildContext context) {
    final widgetName = widget.child.runtimeType.toString();

    if (TrackingFilter.shouldTrack(widget.child)) {
      RebuildTracker.track(widgetName);

      return VisualTrackedWidget(name: widgetName, child: widget.child);
    }

    return widget.child;
  }
}
