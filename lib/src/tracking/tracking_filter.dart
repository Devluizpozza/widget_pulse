import 'package:flutter/material.dart';

import '../overlay/pulse_overlay.dart';

class TrackingFilter {
  static bool shouldTrack(Widget widget) {
    // StatefulWidgets must self-report via PulseStateMixin for accurate
    // rebuild tracking. External wrapping only fires on parent rebuilds,
    // making setState-driven counts permanently stuck at 1.
    if (widget is StatefulWidget) return false;

    final ignoredWidgets = {
      Text,
      Icon,
      SizedBox,
      Padding,
      Center,
      Container,
      PulseOverlay,
    };

    return !ignoredWidgets.contains(widget.runtimeType);
  }
}
