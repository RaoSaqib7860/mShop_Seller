import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

import '../global_widgets/Sackbars.dart';

class InternetConnectivity {
  static StreamController<bool> connectivity_stream = StreamController<bool>.broadcast();
  static bool internet_available = true;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  void check_connection_stream() {
    initConnectivity();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
    if (_connectionStatus == ConnectivityResult.mobile ||
        _connectionStatus == ConnectivityResult.wifi) {
      internet_available = true;
      connectivity_stream.add(true);
      print('Internet available');
      //snackBarSuccess('Internet connection available');
    } else if (_connectionStatus == ConnectivityResult.none) {
      internet_available = false;
      connectivity_stream.add(false);
      print('Internet not available');
      //snackBarSuccess('Internet connection not available');
    }
  }
}
