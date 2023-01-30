class crop {
  String? name;
  double temperature1;
  double temperature2;
  double humidity1;
  double humidity2;
  bool? tempSuitable;
  bool? humiditySuitable;
  int suitabilityCount;

  crop({
    this.name,
    required this.temperature1,
    required this.temperature2,
    required this.humidity1,
    required this.humidity2,
    this.tempSuitable,
    this.humiditySuitable,
    required this.suitabilityCount,
  });
}
