// ignore_for_file: depend_on_referenced_packages, unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:async/async.dart';
import 'package:blog_explorer/api/base/header_interceptor.dart';
import 'package:blog_explorer/api/exceptions/exceptions.dart';
import 'package:blog_explorer/api/exceptions/network_exception.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:path/path.dart';
import 'logging_interceptor.dart';
import 'url_query_parameter.dart';

enum RequestType { GET, POST, PUT, DELETE, PATCH }

class BaseRepository {
  late InterceptedClient httpClient;
  BaseRepository() {
    httpClient = InterceptedClient.build(interceptors: [
      HeaderInterceptor(),
      LoggingInterceptor(),
    ], requestTimeout: Duration(seconds: 30));
  }

  Future<http.Response> requestHttps(
      RequestType type, String endpoint, dynamic request,
      {String baseURL = "",
      Map<String, String> queryParameters = const {},
      Map<String, String> headers = const {}}) async {
    String uri = baseURL + endpoint + getQueryParameters(queryParameters);
    Uri validUri = Uri.parse(uri);
    http.Response response;
    switch (type) {
      case RequestType.GET:
        response = await httpClient.get(validUri, headers: headers);
        break;
      case RequestType.POST:
        response =
            await httpClient.post(validUri, headers: headers, body: request);
        break;
      case RequestType.PUT:
        response =
            await httpClient.put(validUri, headers: headers, body: request);
        break;
      case RequestType.PATCH:
        response =
            await httpClient.patch(validUri, headers: headers, body: request);
        break;
      case RequestType.DELETE:
        response = await httpClient.delete(validUri, headers: headers);
        break;
    }
    if (response.statusCode != 200) {
      defaultHandleResponse(request, response);
      print("Failed request");
    }
    return response;
  }

  Future<http.Response> sendFile(
      String baseURL,
      String method,
      Map<String, String> queryParameters,
      Map<String, String> headers,
      File file) async {
    try {
      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();
      String uri = baseURL + method + getQueryParameters(queryParameters);
      Uri validUri = Uri.parse(uri);
      var request = new http.MultipartRequest("POST", validUri);
      var multipartFileSign = new http.MultipartFile('photo', stream, length,
          filename: basename(file.path));
      request.files.add(multipartFileSign);
      request.headers.addAll(headers);
      return await http.Response.fromStream(await request.send());
    } on SocketException {
      throw NetworkException();
    } on TimeoutException {
      throw CustomTimeoutException();
    }
  }

  defaultHandleResponse(dynamic request, http.Response response) {
    if (response.statusCode >= 500) {
      throw ServerErrorException(response.body.toString());
    }
    switch (response.statusCode) {
      case 400:
        throw MissRequestParamsException(
            getRequestJson(request), getResponseJson(response));
      case 404:
        throw NotFoundException();
      case 421:
        throw ExternalServicesFailException();
      case 401:
      case 403:
        throw TokenExpiredException();
    }
  }

  String getRequestJson(dynamic request) {
    return request != null ? json.encode(request) : "Empty";
  }

  String getResponseJson(http.Response response) {
    return response.body.toString();
  }

  String getQueryParameters(Map<String, String> queryParameters) {
    if (queryParameters != null && queryParameters.isNotEmpty) {
      URLQueryParams queryParams = new URLQueryParams();
      queryParameters.forEach((key, value) {
        queryParams.append(key, value);
      });
      return "?${queryParams.toString()}";
    }
    return "";
  }
}
