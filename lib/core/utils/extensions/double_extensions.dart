import 'dart:math';

extension DoubleExtensions on double? {
  double validate({double value = 0.0}) => this ?? value;

  bool isBetween(num first, num second) {
    final lower = min(first, second);
    final upper = max(first, second);
    return validate() >= lower && validate() <= upper;
  }
}


