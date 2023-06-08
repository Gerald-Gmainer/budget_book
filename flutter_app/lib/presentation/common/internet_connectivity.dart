import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/utils.dart';

class InternetConnectivity extends StatefulWidget {
  final Widget child;

  const InternetConnectivity({required this.child});

  @override
  State<InternetConnectivity> createState() => _InternetConnectivityState();
}

class _InternetConnectivityState extends State<InternetConnectivity> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _listen();
  }

  Future<void> _listen() async {
    final result = await _connectivity.checkConnectivity();
    _onConnectivityChanged(result);
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
  }

  _onConnectivityChanged(ConnectivityResult result) {
    bool isConnected = _isConnected(result);
    ConnectivitySingleton.instance.setConnected(isConnected);
  }

  bool _isConnected(ConnectivityResult result) {
    return result == ConnectivityResult.mobile || result == ConnectivityResult.wifi;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
