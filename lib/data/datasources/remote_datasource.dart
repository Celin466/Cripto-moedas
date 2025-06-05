import 'package:moedasvirtuais/configs/environment_helper.dart';
import 'package:moedasvirtuais/core/service/http_service.dart';
import 'package:moedasvirtuais/data/datasources/data_source.dart';
import 'package:moedasvirtuais/domain/entities/core/http_resonse_entity.dart';

base class RemoteDataSource implements IRemoteDataSource {
  final IHttpService _http;
  final IEnvironmentHelper _environment;

  const RemoteDataSource(this._http, this._environment,);

  @override
  Future<HttpResponseEntity> get(String url, [String? token]) async {
    try {
      return await _http.get(url);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity?> post(String url, [String? data]) async {
    try {
      return await _http.post(url, data: data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity?> put(String url, [String? data]) async {
    try {
      return await _http.put(url, data: data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity?> patch(String url, [String? data]) async {
    try {
      return await _http.patch(url, data: data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity?> delete(String url, [String? data]) async {
    try {
      return await _http.delete(url, data: data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  IEnvironmentHelper get environment => _environment;

}

