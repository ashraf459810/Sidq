class AppException implements Exception {
  late String? message;
  late String? prefix;

  AppException([this.message, this.prefix]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class NoInternet extends AppException {
  NoInternet([String? message]) : super(message, "Check your Internet");
}

class InternalServerError extends AppException {
  InternalServerError([String? message])
      : super(message, "Internal Server Error");
}
