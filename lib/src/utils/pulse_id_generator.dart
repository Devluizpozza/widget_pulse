class PulseIdGenerator {
  static int _counter = 0;

  static String next(String widgetName) {
    _counter++;

    return '$widgetName#$_counter';
  }
}
