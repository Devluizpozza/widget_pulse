import 'package:flutter/material.dart';

import 'auto_tracked_widget.dart';
import 'tracking_filter.dart';

class PulseTreeWalker {
  static Widget instrument(Widget widget) {
    if (!TrackingFilter.shouldTrack(widget)) {
      return widget;
    }

    return AutoTrackedWidget(child: _wrapChildren(widget));
  }

  static Widget _wrapChildren(Widget widget) {
    if (widget is MultiChildRenderObjectWidget) {
      final children = widget.children.map(instrument).toList();

      if (widget is Column) {
        return Column(
          key: widget.key,
          mainAxisAlignment: widget.mainAxisAlignment,
          mainAxisSize: widget.mainAxisSize,
          crossAxisAlignment: widget.crossAxisAlignment,
          textDirection: widget.textDirection,
          verticalDirection: widget.verticalDirection,
          textBaseline: widget.textBaseline,
          children: children,
        );
      }

      if (widget is Row) {
        return Row(
          key: widget.key,
          mainAxisAlignment: widget.mainAxisAlignment,
          mainAxisSize: widget.mainAxisSize,
          crossAxisAlignment: widget.crossAxisAlignment,
          textDirection: widget.textDirection,
          verticalDirection: widget.verticalDirection,
          textBaseline: widget.textBaseline,
          children: children,
        );
      }
    }

    if (widget is SingleChildRenderObjectWidget) {
      final child = _extractChild(widget);

      if (child == null) {
        return widget;
      }

      final wrappedChild = instrument(child);

      if (widget is Center) {
        return Center(
          key: widget.key,
          widthFactor: widget.widthFactor,
          heightFactor: widget.heightFactor,
          child: wrappedChild,
        );
      }

      if (widget is Padding) {
        return Padding(
          key: widget.key,
          padding: widget.padding,
          child: wrappedChild,
        );
      }
    }

    return widget;
  }

  static Widget? _extractChild(SingleChildRenderObjectWidget widget) {
    try {
      return (widget as dynamic).child as Widget?;
    } catch (_) {
      return null;
    }
  }
}
