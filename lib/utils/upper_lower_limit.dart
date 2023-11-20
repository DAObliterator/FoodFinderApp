import 'dart:math';

Set<int> upperLowerLimit(String priceRange) {
  int _lowerLimit = 0;
  int _upperLimit = 0;
  int _indexOfDash = priceRange.indexOf("-");

  List<int> _lowerLimitList = priceRange
      .substring(0, _indexOfDash)
      .split("")
      .map((e) => int.parse(e))
      .toList();

  List<int> _upperLimitList = priceRange
      .substring(_indexOfDash + 1)
      .split("")
      .map((e) => int.parse(e))
      .toList();


  int _upperLength = _upperLimitList.length;
  int _lowerLength = _lowerLimitList.length;

  for ( int i = 0; i < _lowerLength ; i++) {
    _lowerLimit = _lowerLimit + _lowerLimitList[i] * pow(10, _lowerLength - 1 - i).toInt();
  }

  for (int i = 0; i < _upperLength ; i++) {
    _upperLimit = _upperLimit + _upperLimitList[i] * pow(10, _upperLength - 1 - i).toInt();
  }


  return { _lowerLimit , _upperLimit};
}


