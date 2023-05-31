class ConnectivitySingleton {
  static ConnectivitySingleton? _instance;
  ConnectivitySingleton._();
  static ConnectivitySingleton get instance => _instance ??= ConnectivitySingleton._();

  bool _isConnected = false;

  bool isConnected() {
    return _isConnected;
  }

  setConnected(bool isConnected) {
    _isConnected = isConnected;
  }
}
