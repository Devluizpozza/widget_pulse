import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widget_pulse/widget_pulse.dart';

void main() {
  runApp(const PulseDemoApp());
}

class PulseDemoApp extends StatelessWidget {
  const PulseDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const WidgetPulse(
        child: PulseDemoPage(),
      ),
    );
  }
}

class PulseDemoPage extends StatefulWidget {
  const PulseDemoPage({super.key});

  @override
  State<PulseDemoPage> createState() => _PulseDemoPageState();
}

class _PulseDemoPageState extends State<PulseDemoPage> with PulseStateMixin {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TrackedWidget(
          name: 'AppBarTitle',
          child: Text('Widget Pulse Demo'),
        ),
      ),
      floatingActionButton: TrackedWidget(
        name: 'FloatingButton',
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              counter++;
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AnimatedCounterCard(counter: counter),
            const SizedBox(height: 24),
            const LiveProgressBar(),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return DemoListCard(index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedCounterCard extends StatefulWidget {
  final int counter;

  const AnimatedCounterCard({
    super.key,
    required this.counter,
  });

  @override
  State<AnimatedCounterCard> createState() => _AnimatedCounterCardState();
}

class _AnimatedCounterCardState extends State<AnimatedCounterCard>
    with PulseStateMixin {
  late Timer timer;

  final random = Random();

  Color cardColor = Colors.blue;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(milliseconds: 1100),
      (_) {
        setState(() {
          final colors = [
            Colors.blue,
            Colors.purple,
            Colors.green,
            Colors.orange,
            Colors.red,
          ];

          cardColor = colors[random.nextInt(colors.length)];
        });
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TrackedWidget(
      name: 'AnimatedCounterCard',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            'Counter: ${widget.counter}',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class LiveProgressBar extends StatefulWidget {
  const LiveProgressBar({super.key});

  @override
  State<LiveProgressBar> createState() => _LiveProgressBarState();
}

class _LiveProgressBarState extends State<LiveProgressBar>
    with PulseStateMixin {
  late Timer timer;

  final random = Random();

  double progress = 0.2;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(milliseconds: 700),
      (_) {
        setState(() {
          progress = random.nextDouble();
        });
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TrackedWidget(
      name: 'ProgressBar',
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 16,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

class DemoListCard extends StatefulWidget {
  final int index;

  const DemoListCard({
    super.key,
    required this.index,
  });

  @override
  State<DemoListCard> createState() => _DemoListCardState();
}

class _DemoListCardState extends State<DemoListCard> with PulseStateMixin {
  late Timer timer;

  bool active = false;

  double progress = 0;

  final random = Random();

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      Duration(milliseconds: 800 + (widget.index * 120)),
      (_) {
        setState(() {
          active = !active;
          progress = random.nextDouble();
        });
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TrackedWidget(
      name: 'ListItem_${widget.index}',
      child: Card(
        child: ListTile(
          leading: TrackedWidget(
            name: 'Avatar_${widget.index}',
            child: CircleAvatar(
              child: Text('${widget.index + 1}'),
            ),
          ),
          title: TrackedWidget(
            name: 'Title_${widget.index}',
            child: Text(
              'Tracked Widget #${widget.index}',
            ),
          ),
          subtitle: TrackedWidget(
            name: 'Subtitle_${widget.index}',
            child: Text(
              'Progress ${(progress * 100).toStringAsFixed(0)}%',
            ),
          ),
          trailing: TrackedWidget(
            name: 'Icon_${widget.index}',
            child: Icon(
              active ? Icons.trending_up : Icons.trending_down,
            ),
          ),
        ),
      ),
    );
  }
}
