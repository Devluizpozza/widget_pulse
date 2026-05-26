import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widget_pulse/widget_pulse.dart';

class PulseExampleApp extends StatelessWidget {
  const PulseExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Widget Pulse Example',
      theme: ThemeData.dark(),
      home: const WidgetPulse(
        child: DashboardExamplePage(),
      ),
    );
  }
}

class DashboardExamplePage extends StatefulWidget {
  const DashboardExamplePage({super.key});

  @override
  State<DashboardExamplePage> createState() => _DashboardExamplePageState();
}

class _DashboardExamplePageState extends State<DashboardExamplePage>
    with PulseStateMixin {
  int counter = 0;
  bool notificationsEnabled = true;
  double cpuUsage = 24;
  double memoryUsage = 58;
  int selectedTab = 0;

  late Timer timer;
  final random = Random();

  final List<String> logs = [
    'User authenticated',
    'Fetching dashboard metrics',
    'Cache updated',
    'Animation rebuilt',
    'Theme changed',
  ];

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(milliseconds: 1200), (_) {
      setState(() {
        cpuUsage = 10 + random.nextInt(80).toDouble();
        memoryUsage = 20 + random.nextInt(70).toDouble();
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Pulse Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                notificationsEnabled = !notificationsEnabled;
              });
            },
            icon: Icon(
              notificationsEnabled
                  ? Icons.notifications_active
                  : Icons.notifications_off,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _MetricCard(
                  title: 'Counter',
                  value: '$counter',
                  icon: Icons.add_chart,
                  color: Colors.blue,
                ),
                _MetricCard(
                  title: 'CPU Usage',
                  value: '${cpuUsage.toStringAsFixed(0)}%',
                  icon: Icons.memory,
                  color: Colors.orange,
                ),
                _MetricCard(
                  title: 'Memory',
                  value: '${memoryUsage.toStringAsFixed(0)}%',
                  icon: Icons.storage,
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Actions',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        counter++;
                      });
                    },
                    icon: const Icon(Icons.plus_one),
                    label: const Text('Increment Counter'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        logs.insert(
                          0,
                          'New rebuild event at ${DateTime.now().second}s',
                        );
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Trigger Rebuild'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Performance Monitor',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _ProgressTile(
                    label: 'CPU',
                    value: cpuUsage / 100,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 12),
                  _ProgressTile(
                    label: 'Memory',
                    value: memoryUsage / 100,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 12),
                  _ProgressTile(
                    label: 'Rendering',
                    value: (cpuUsage + memoryUsage) / 200,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Activity Logs',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: logs.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.bolt),
                    title: Text(logs[index]),
                    subtitle: const Text('Widget rebuild detected'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        onTap: (value) {
          setState(() {
            selectedTab = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressTile extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _ProgressTile({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text('${(value * 100).toStringAsFixed(0)}%'),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: value,
          color: color,
          minHeight: 10,
          borderRadius: BorderRadius.circular(999),
        ),
      ],
    );
  }
}
