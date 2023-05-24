import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_starter/env.dart';

import 'abstractions/build_config.dart';

class Api {
  late Dio dio;

  Api() {
    dio = Dio(BaseOptions(
      baseUrl: Env.getConfig.baseUrl,
      receiveTimeout: const Duration(minutes: 1),
      connectTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1),
    ));

    dio.interceptors.addAll({
      AppInterceptors(buildConfig: Env.getConfig, dio: dio),
    });
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;
  final BuildConfig buildConfig;

  AppInterceptors({required this.dio, required this.buildConfig});

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    dio.options.baseUrl = buildConfig.baseUrl;

    if (kDebugMode) {
      log(err.requestOptions.uri.toString(), name: 'URI');
      log(err.requestOptions.headers.toString(), name: 'HEADERS');
      log(jsonEncode(err.requestOptions.data), name: 'POST DATA');
      log(jsonEncode(err.response?.data),
          name: '${err.requestOptions.method} REQUEST');
      log(err.response?.statusCode.toString() ?? "NO-STATUS CODE",
          name: "STATUS CODE");
    }

    switch (err.type) {
      case DioErrorType.connectionTimeout:
        throw ConnectTimeoutException(err.requestOptions);
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.badCertificate:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(res: err.response, r: err.requestOptions);
          case 401:
            throw UnauthorizedException(
                res: err.response, r: err.requestOptions);
          case 404:
            throw NotFoundException(res: err.response, r: err.requestOptions);
          case 409:
            throw ConflictException(res: err.response, r: err.requestOptions);

          case 500:
            throw InternalServerErrorException(
                res: err.response, r: err.requestOptions);
          default:
            throw UnknownException(res: err.response, r: err.requestOptions);
        }
      case DioErrorType.cancel:
        break;
      case DioErrorType.unknown || DioErrorType.connectionError:
        throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    return handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    log(response.requestOptions.uri.toString(), name: 'URI');
    log(response.requestOptions.headers.toString(), name: 'HEADERS');
    log(jsonEncode(response.requestOptions.data),
        name: '${response.requestOptions.method} REQUEST');
    log(jsonEncode(response.data), name: 'RESPONSE DATA');
    dio.options.baseUrl = buildConfig.baseUrl;
    handler.next(response);
  }
}

class BadRequestException extends DioError {
  Response? res;
  BadRequestException({this.res, required RequestOptions r})
      : super(requestOptions: r, response: res);

  @override
  String toString() {
    return res?.data['message'] ?? 'Something went wrong.\nPlease try again.';
  }
}

class ConflictException extends DioError {
  Response? res;
  ConflictException({this.res, required RequestOptions r})
      : super(requestOptions: r, response: res);

  @override
  String toString() {
    return res?.data['message'] ?? 'Something went wrong.\nPlease try again.';
  }
}

class ConnectTimeoutException extends DioError {
  ConnectTimeoutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Connection timeout';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out.\nplease try again.';
  }
}

class InternalServerErrorException extends DioError {
  Response? res;
  InternalServerErrorException({this.res, required RequestOptions r})
      : super(requestOptions: r, response: res);

  @override
  String toString() {
    return res?.data['message'] ?? 'Something went wrong.\nPlease try again.';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection to the internet has been lost.\nPlease try again';
  }
}

class NotFoundException extends DioError {
  Response? res;
  NotFoundException({this.res, required RequestOptions r})
      : super(requestOptions: r, response: res);

  @override
  String toString() {
    return res?.data['message'] ?? 'Something went wrong.\nPlease try again.';
  }
}

class RequestEntityTooLargeException extends DioError {
  RequestEntityTooLargeException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Request too large';
  }
}

class UnauthorizedException extends DioError {
  Response? res;
  UnauthorizedException({this.res, required RequestOptions r})
      : super(requestOptions: r, response: res);

  @override
  String toString() {
    return res?.data['message'] ?? 'Something went wrong.\nPlease try again.';
  }
}

class UnknownException extends DioError {
  Response? res;

  UnknownException({this.res, required RequestOptions r})
      : super(requestOptions: r, response: res);

  @override
  String toString() {
    try {
      return res?.data['message'] ?? 'Something went wrong.\nPlease try again.';
    } catch (e) {
      return 'Something went wrong.\nPlease try again.';
    }
  }
}
