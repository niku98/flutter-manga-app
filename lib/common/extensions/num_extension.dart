extension NumExtensions on num {
  String toPercentageString() {
    return ((this ?? 0) * 10).toStringAsFixed(0) + '%';
  }
}
