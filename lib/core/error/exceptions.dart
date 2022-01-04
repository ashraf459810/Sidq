class ServerException implements Exception {
  final String? error;

  String get theError {
    return error ?? "error";
  }

  ServerException([this.error]);
}
