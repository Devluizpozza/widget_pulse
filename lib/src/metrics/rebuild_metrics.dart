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

  double get intensity {
    if (rebuildCount >= 100) {
      return 1.0;
    }

    return rebuildCount / 100;
  }
}
