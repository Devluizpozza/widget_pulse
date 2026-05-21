import '../tracking/widget_registry.dart';

class RebuildTracker {
  static void track(String widgetName) {
    WidgetRegistry.instance.register(widgetName);
  }
}