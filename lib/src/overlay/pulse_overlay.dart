import 'package:flutter/material.dart';

import '../tracking/widget_registry.dart';

class PulseOverlay extends StatelessWidget {
  const PulseOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SafeArea(
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 260,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.85),
              borderRadius: BorderRadius.circular(12),
            ),
            child: AnimatedBuilder(
              animation: WidgetRegistry.instance,
              builder: (_, __) {
                final registry = WidgetRegistry.instance;

                final widgets = registry.widgets.values.toList()
                  ..sort(
                    (a, b) => b.rebuildCount.compareTo(a.rebuildCount),
                  );

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Widget Pulse',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Tracked Widgets: ${widgets.length}',
                      style: const TextStyle(color: Colors.white70),
                    ),

                    Text(
                      'Total Rebuilds: ${registry.totalRebuilds}',
                      style: const TextStyle(color: Colors.white70),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Top Widgets',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    ...widgets.take(5).map(
                      (item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            '${item.widgetName} (${item.rebuildCount})',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}