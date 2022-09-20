// Dart imports:
import 'dart:math';

extension DoubleExt on double {
  double get roundNumber {
    num mod = pow(10.0, 2);
    // ignore: newline-before-return
    return ((this * mod).roundToDouble() / mod);
  }
}
