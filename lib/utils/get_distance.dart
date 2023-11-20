import 'dart:math' as math;

double degreeToRadians( double degree) {

  double _onedegree = math.pi / 180;

  return _onedegree * degree;
}

double getDistance( double lat1 , double long1 , double lat2 , double long2) {

  double _latInDegree1 =  degreeToRadians(lat1);
  double _longInDegree1= degreeToRadians(long1);
  double _latInDegree2 = degreeToRadians(lat2);
  double _longInDegree2 = degreeToRadians(long2);
  double _latDiff = _latInDegree2 - _latInDegree1;
  double _longDiff = _longInDegree2 - _longInDegree1;

  double distance = math.pow( math.sin(_latDiff/2), 2) + math.cos(_latInDegree1) * math.cos(_latInDegree2) * math.pow( math.sin(_longDiff/2), 2);

  distance = 2 * math.asin(math.sqrt(distance)) * 6371.00;

  return distance; // return type double and in kms

}