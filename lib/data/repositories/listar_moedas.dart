import 'package:moedasvirtuais/core/library/extensions.dart';
import 'package:moedasvirtuais/data/datasources/data_source.dart';
import 'package:moedasvirtuais/domain/entities/core/http_resonse_entity.dart';
import 'package:moedasvirtuais/domain/entities/moeda/moeda_entity.dart';

abstract interface class ImoedaRepository {

  Future<List<MoedaVirtual>> getCriptoMoeda();
}

final class Moeda implements ImoedaRepository {
  final IRemoteDataSource _remoteDataSource;

  const Moeda(this._remoteDataSource);

  @override
  Future<List<MoedaVirtual>> getCriptoMoeda() async {
    final HttpResponseEntity httpResponse = (await _remoteDataSource.get(_urlMoeda))!;

    final List<dynamic> lista = (httpResponse.data as Map<String, dynamic>)['data'];
    return lista.map((e) => MoedaVirtual.fromMap(e)).toList();
  }


  String get _urlMoeda => _remoteDataSource.environment?.urlListarMoedas ?? '';

}