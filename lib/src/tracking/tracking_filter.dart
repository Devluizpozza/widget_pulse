import 'package:flutter/widgets.dart';

class TrackingFilter {
  static bool shouldTrack(Widget widget) {
    final ignoredWidgets = {
      Text,
      Icon,
      SizedBox,
      Padding,
      Center,
      Align,
      Container,
    };

    return !ignoredWidgets.contains(widget.runtimeType);
  }
}