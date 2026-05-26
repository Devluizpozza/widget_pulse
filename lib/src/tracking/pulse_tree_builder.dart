import 'package:flutter/material.dart';

import 'pulse_tree_walker.dart';

class PulseTreeBuilder extends StatelessWidget {
  final Widget child;

  const PulseTreeBuilder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PulseTreeWalker.instrument(child);
  }
}
