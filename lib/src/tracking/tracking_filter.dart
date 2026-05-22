import 'package:flutter/material.dart';

import '../overlay/pulse_overlay.dart';

class TrackingFilter {
  static bool shouldTrack(Widget widget) {
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
