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
            width: 180,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.82),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withOpacity(0.08),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: AnimatedBuilder(
              animation: WidgetRegistry.instance,
              builder: (_, __) {
                final registry = WidgetRegistry.instance;

                final widgets = registry.widgets.values.toList()
                  ..sort(
                    (a, b) => b.rebuildCount.compareTo(
                      a.rebuildCount,
                    ),
                  );

                return DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'Widget Pulse',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      _MetricTile(
                        label: 'Tracked Widgets',
                        value: widgets.length.toString(),
                      ),
                      const SizedBox(height: 8),
                      _MetricTile(
                        label: 'Total Rebuilds',
                        value: registry.totalRebuilds.toString(),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Top Widgets',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (widgets.isEmpty)
                        Text(
                          'No tracked widgets',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 11,
                          ),
                        ),
                      ...widgets.take(5).map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 8,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.widgetName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(
                                      0.85,
                                    ),
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _heatColor(
                                    item.intensity,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    999,
                                  ),
                                ),
                                child: Text(
                                  item.rebuildCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  static Color _heatColor(double intensity) {
    if (intensity < 0.3) {
      return Colors.green;
    }

    if (intensity < 0.6) {
      return Colors.orange;
    }

    return Colors.red;
  }
}

class _MetricTile extends StatelessWidget {
  final String label;
  final String value;

  const _MetricTile({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 11,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
