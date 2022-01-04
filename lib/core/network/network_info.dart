// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInf {
  final String baseUrl = "http://134.209.78.88:8080";
  Future<bool>? get isConnected;
}

class NetworkInfImpl implements NetworkInf {
  final String baseurl = "http://134.209.78.88:8080";

  // final String url = "https://fakestoreapi.com/products?limit=";
  final DataConnectionChecker? connectionChecker;

  NetworkInfImpl([
    this.connectionChecker,
  ]);

  @override
  Future<bool>? get isConnected => connectionChecker?.hasConnection;

  @override
  String get baseUrl => baseurl.toString();
}
