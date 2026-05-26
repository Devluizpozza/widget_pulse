import 'dart:async';

import 'package:flutter/material.dart';

import '../tracking/widget_registry.dart';

class PulseOverlay extends StatefulWidget {
  const PulseOverlay({
    super.key,
  });

  @override
  State<PulseOverlay> createState() => _PulseOverlayState();
}

class _PulseOverlayState extends State<PulseOverlay> {
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(milliseconds: 200),
      (_) {
        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widgets = WidgetRegistry.instance.widgets.values.toList();

    return IgnorePointer(
      child: SafeArea(
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: .75),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tracked Widgets: ${widgets.length}',
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Total Rebuilds: ${WidgetRegistry.instance.totalRebuilds}',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
