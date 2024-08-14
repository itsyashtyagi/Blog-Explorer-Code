import 'package:http_interceptor/http_interceptor.dart';

class HeaderInterceptor extends InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) {
    if (!request.url.path.contains("login")) {}
    return Future.value(request);
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    return Future.value(response);
  }
}
