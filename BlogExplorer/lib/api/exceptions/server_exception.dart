import '../base/base_exception.dart';

class ServerException extends BaseException {
  ServerException([int? code, String? message])
      : super(code, "Server error : $message");
}
