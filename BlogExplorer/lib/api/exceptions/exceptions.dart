import '../base/base_exception.dart';

class MissRequestParamsException extends BaseException {
  MissRequestParamsException(String request, String response)
      : super(400, "Something is wrong", request: request, response: response);
}

class InvalidTokenException extends BaseException {
  InvalidTokenException() : super(401, "Access Token is Expired");
}

class NotFoundException extends BaseException {
  NotFoundException() : super(404, "Requested resource not found");
}

class LoginFailedException extends BaseException {
  LoginFailedException() : super(401, "Invalid Email and Password");
}

class TokenExpiredException extends BaseException {
  TokenExpiredException() : super(401, "Token is Expired");
}

class CustomTimeoutException extends BaseException {
  CustomTimeoutException() : super(null, "Operation Time Out");
}

class ExternalServicesFailException extends BaseException {
  ExternalServicesFailException()
      : super(421, "Cannot be done beacuse of the internal server error");
}

class ParseErrorException extends BaseException {
  String error;

  ParseErrorException(this.error) : super(null, "Server replied with an Error");
}

class ServerErrorException extends BaseException {
  String error;

  ServerErrorException(this.error)
      : super(null, "Server replied with an error");
  @override
  String toString() {
    return "Server replied with an error";
  }
}
