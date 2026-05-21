import 'package:flutter/foundation.dart';

import '../metrics/rebuild_metrics.dart';

class WidgetRegistry extends ChangeNotifier {
  static final WidgetRegistry instance = WidgetRegistry._internal();

  WidgetRegistry._internal();

  final Map<String, RebuildMetrics> _widgets = {};

  Map<String, RebuildMetrics> get widgets => _widgets;

  int get totalRebuilds {
    return _widgets.values.fold(
      0,
      (sum, item) => sum + item.rebuildCount,
    );
  }

  void register(String widgetName) {
    final metrics = _widgets.putIfAbsent(
      widgetName,
      () => RebuildMetrics(widgetName: widgetName),
    );

    metrics.registerRebuild();

    notifyListeners();
  }
}