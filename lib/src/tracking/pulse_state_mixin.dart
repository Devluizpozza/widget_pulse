import 'package:flutter/material.dart';

import '../core/rebuild_tracker.dart';
import '../utils/pulse_id_generator.dart';
import 'widget_registry.dart';

/// Add to your [State] class to enable accurate rebuild tracking for
/// [StatefulWidget]s. Tracks both the initial build and each [setState] call.
///
/// ```dart
/// class _MyWidgetState extends State<MyWidget> with PulseStateMixin {
///   @override
///   Widget build(BuildContext context) { ... }
/// }
/// ```
mixin PulseStateMixin<T extends StatefulWidget> on State<T> {
  late final String _pulseId;

  @override
  void initState() {
    super.initState();
    _pulseId = PulseIdGenerator.next(widget.runtimeType.toString());
    RebuildTracker.track(_pulseId);
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    RebuildTracker.track(_pulseId);
  }

  @override
  void dispose() {
    WidgetRegistry.instance.unregister(_pulseId);
    super.dispose();
  }
}
