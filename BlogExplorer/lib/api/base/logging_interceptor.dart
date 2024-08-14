import 'dart:developer';

import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    log("<---- Request  ${request.method}");
    log("URL: ${request.url}");
    log("Headers: ${request.headers}");
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    log("<---- Request  ${response.request?.method} ");
    log("URL: ${response.request?.url}");
    log("Status Code: ${response.statusCode}");
    log("Headers: ${response.headers}");
    log("Body: ${response.contentLength}");
    return response;
  }

  @override
  Future<bool> shouldInterceptRequest() async {
    return false;
  }

  @override
  Future<bool> shouldInterceptResponse() async {
    return false;
  }
}
