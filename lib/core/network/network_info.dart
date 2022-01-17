// ignore: import_of_legacy_library_into_null_safe

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInf {
  final String baseUrl = "http://80.208.227.48/api/api";
  Future<bool>? get isConnected;
}

class NetworkInfImpl implements NetworkInf {
  final String baseurl = "http://80.208.227.48/api/api";

  // final String url = "https://fakestoreapi.com/products?limit=";
  final InternetConnectionChecker? connectionChecker;

  NetworkInfImpl([
    this.connectionChecker,
  ]);

  @override
  Future<bool>? get isConnected => connectionChecker?.hasConnection;

  @override
  String get baseUrl => baseurl.toString();
}
