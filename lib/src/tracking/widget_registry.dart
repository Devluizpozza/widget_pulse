import '../metrics/rebuild_metrics.dart';

class WidgetRegistry {
  static final WidgetRegistry instance = WidgetRegistry._internal();

  WidgetRegistry._internal();

  final Map<String, RebuildMetrics> _widgets = {};

  Map<String, RebuildMetrics> get widgets => _widgets;

  void register(String widgetName) {
    final metrics = _widgets.putIfAbsent(
      widgetName,
      () => RebuildMetrics(widgetName: widgetName),
    );

    metrics.registerRebuild();
  }
}