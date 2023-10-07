class BaseService {
  static String generateParams(Map<String, dynamic> params) {
    String _params = '';

    /// Calculate params
    params.keys.forEach((mapKey) {
      int _idx = params.keys.toList().indexOf(mapKey);
      _params += _idx == 0 ? "?$mapKey=${params[mapKey]}" : "&$mapKey=${params[mapKey]}";
    });

    return _params;
  }
}
