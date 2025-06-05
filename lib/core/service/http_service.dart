import 'dart:io';

import 'package:moedasvirtuais/configs/factory_viewmodel.dart';
import 'package:moedasvirtuais/core/library/extensions.dart';
import 'package:moedasvirtuais/domain/entities/core/http_resonse_entity.dart';
import 'package:dio/dio.dart';

abstract interface class IHttpService {
  Future<HttpResponseEntity> get(String url, {int? secondsTimeout, dynamic headers});
  Future<HttpResponseEntity> post(String url, {int? secondsTimeout, dynamic data});
  Future<HttpResponseEntity> put(String url, {int? secondsTimeout, dynamic data});
  Future<HttpResponseEntity> patch(String url, {int? secondsTimeout, dynamic data});
  Future<HttpResponseEntity> delete(String url, {int? secondsTimeout, dynamic data});
}

final class HttpService implements IHttpService {
  final Dio _dio;

  const HttpService(
      this._dio,

      );

  @override
  Future<HttpResponseEntity> get(String url, {int? secondsTimeout, dynamic headers}) async {
    try {
      await _changeDioOptionsAsync();

      final Response response = await _dio.get(
        url,
        options: Options(
          headers: headers,
        ),
      );

      return _createHttpResponseFromResponse(response);
    } catch (error) {
      throw error.convertDioToHttpException();
    }
  }

  @override
  Future<HttpResponseEntity> post(String url, {int? secondsTimeout, dynamic data}) async {
    try {
      await _changeDioOptionsAsync();
      final Response response = await _dio.post(url, data: data);
      return _createHttpResponseFromResponse(response);
    } catch (error) {
      throw error.convertDioToHttpException();
    }
  }

  @override
  Future<HttpResponseEntity> put(String url, {int? secondsTimeout, dynamic data}) async {
    try {
      await _changeDioOptionsAsync();
      final Response response = await _dio.put(url, data: data);
      return _createHttpResponseFromResponse(response);
    } catch (error) {
      throw error.convertDioToHttpException();
    }
  }

  @override
  Future<HttpResponseEntity> patch(String url, {int? secondsTimeout, dynamic data}) async {
    try {
      await _changeDioOptionsAsync();
      final Response response = await _dio.patch(url, data: data);
      return _createHttpResponseFromResponse(response);
    } catch (error) {
      throw error.convertDioToHttpException();
    }
  }

  @override
  Future<HttpResponseEntity> delete(String url, {int? secondsTimeout, dynamic data}) async {
    try {
      await _changeDioOptionsAsync();
      final Response response = await _dio.delete(url, data: data);
      return _createHttpResponseFromResponse(response);
    } catch (error) {
      throw error.convertDioToHttpException();
    }
  }

  Future<void> _changeDioOptionsAsync() async {
    _dio.options.headers.clear();

    _dio.options.headers = {
      'X-CMC_PRO_API_KEY': "b59b7ea4-10e3-4916-89b6-37ff70fec858",
    };
  }

  HttpResponseEntity _createHttpResponseFromResponse(Response response) {
    return HttpResponseEntity(
      data: response.data,
      statusCode: response.statusCode,
    );
  }
}

final class HttpServiceFactory {
  IHttpService create() {
    return HttpService(
      Dio(
        BaseOptions(
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          validateStatus: (value) => value != null,
        ),
      ),
    );
  }
}