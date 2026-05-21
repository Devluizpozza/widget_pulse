class RebuildMetrics {
  final String widgetName;

  int rebuildCount;
  DateTime? lastRebuild;

  RebuildMetrics({
    required this.widgetName,
    this.rebuildCount = 0,
    this.lastRebuild,
  });

  void registerRebuild() {
    rebuildCount++;
    lastRebuild = DateTime.now();
  }
}