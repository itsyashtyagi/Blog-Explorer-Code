import '../base/base_exception.dart';

class NetworkException extends BaseException {
  NetworkException()
      : super(null,
            "No internet found \n check you internet connection and try again");
}
