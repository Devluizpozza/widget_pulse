import 'package:flutter/material.dart';

import '../overlay/pulse_overlay.dart';
import '../tracking/pulse_tree_builder.dart';

class WidgetPulse extends StatelessWidget {
  final Widget child;
  final bool enabled;

  const WidgetPulse({
    super.key,
    required this.child,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }

    return Stack(
      children: [
        PulseTreeBuilder(
          child: child,
        ),
        const PulseOverlay(),
      ],
    );
  }
}
