import 'dart:async';

import 'package:flutter/material.dart';

import 'widget_registry.dart';

class TrackedWidget extends StatefulWidget {
  final Widget child;
  final String name;

  const TrackedWidget({
    super.key,
    required this.child,
    required this.name,
  });

  @override
  State<TrackedWidget> createState() => _TrackedWidgetState();
}

class _TrackedWidgetState extends State<TrackedWidget> {
  int rebuildCount = 0;

  bool visible = false;

  Timer? hideTimer;

  @override
  Widget build(BuildContext context) {
    rebuildCount++;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      WidgetRegistry.instance.register(widget.name);

      if (!visible) {
        setState(() {
          visible = true;
        });
      }

      hideTimer?.cancel();

      hideTimer = Timer(
        const Duration(milliseconds: 350),
        () {
          if (!mounted) return;

          setState(() {
            visible = false;
          });
        },
      );
    });

    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedOpacity(
              opacity: visible ? 1 : 0,
              duration: const Duration(milliseconds: 180),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.redAccent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '$rebuildCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    hideTimer?.cancel();
    super.dispose();
  }
}
