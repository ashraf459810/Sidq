// ignore: import_of_legacy_library_into_null_safe

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInf {
  final String baseUrl = "http://80.208.227.48/api/api";
  Future<bool>? get isConnected;
}

class NetworkInfImpl implements NetworkInf {
  final String baseurl = "http://80.208.227.48/api/api";

  // final String url = "https://fakestoreapi.com/products?limit=";
  InternetConnectionChecker? connectionChecker = InternetConnectionChecker();

  NetworkInfImpl([
    this.connectionChecker,
  ]);

  @override
  Future<bool>? get isConnected async =>
      await InternetConnectionChecker().hasConnection;

  @override
  String get baseUrl => baseurl.toString();
}
