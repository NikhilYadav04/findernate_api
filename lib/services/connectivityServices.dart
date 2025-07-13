import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

//* A ChangeNotifier that listens to network connectivity changes
//* and notifies listeners when the status updates.
class NetworkProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _subscription;

  bool _isConnected = true;

  //* Current connection status
  bool get isConnected => _isConnected;

  NetworkProvider() {
    //* Start listening to connectivity changes
    _subscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    //* Check initial status
    _initializeConnection();
  }

  Future<void> _initializeConnection() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    final wasConnected = _isConnected;
    _isConnected = result != ConnectivityResult.none;

    if (wasConnected != _isConnected) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
