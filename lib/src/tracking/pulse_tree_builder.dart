import 'package:flutter/material.dart';

import 'auto_tracked_widget.dart';

class PulseTreeBuilder extends StatelessWidget {
  final Widget child;

  const PulseTreeBuilder({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AutoTrackedWidget(
      child: child,
    );
  }
}