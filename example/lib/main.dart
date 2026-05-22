import 'package:flutter/material.dart';
import 'package:widget_pulse/widget_pulse.dart';

void main() {
  runApp(const PulseExampleApp());
}

class PulseExampleApp extends StatelessWidget {
  const PulseExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Pulse Example',
      theme: ThemeData.dark(),
      home: const WidgetPulse(
        child: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Pulse'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$counter',
              style: const TextStyle(
                fontSize: 48,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              child: const Text(
                'Increment',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
