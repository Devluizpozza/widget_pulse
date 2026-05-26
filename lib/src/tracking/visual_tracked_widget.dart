import 'package:flutter/material.dart';
import 'package:widget_pulse/src/overlay/pulse_badge.dart';

import 'widget_registry.dart';

class VisualTrackedWidget extends StatefulWidget {
  final Widget child;
  final String name;

  const VisualTrackedWidget({
    super.key,
    required this.child,
    required this.name,
  });

  @override
  State<VisualTrackedWidget> createState() => _VisualTrackedWidgetState();
}

class _VisualTrackedWidgetState extends State<VisualTrackedWidget> {
  bool highlighted = false;

  void _triggerHighlight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          highlighted = true;
        });

        Future.delayed(const Duration(milliseconds: 250), () {
          if (mounted) {
            setState(() {
              highlighted = false;
            });
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _triggerHighlight();
  }

  @override
  void didUpdateWidget(VisualTrackedWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _triggerHighlight();
  }

  @override
  Widget build(BuildContext context) {
    final metrics = WidgetRegistry.instance.widgets[widget.name];

    final intensity = metrics?.intensity ?? 0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            border: Border.all(
              color: highlighted
                  ? Colors.red.withValues(alpha: 0.3 + (intensity * 0.7))
                  : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: widget.child,
        ),
        Positioned(
          top: -8,
          right: -8,
          child: PulseBadge(rebuilds: metrics?.rebuildCount ?? 0),
        ),
      ],
    );
  }
}
