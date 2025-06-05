import 'package:moedasvirtuais/configs/environment_helper.dart';
import 'package:moedasvirtuais/core/library/extensions.dart';
import 'package:moedasvirtuais/data/datasources/data_source.dart';
import 'package:moedasvirtuais/domain/entities/core/http_resonse_entity.dart';
import 'package:moedasvirtuais/domain/entities/moeda/moeda_entity.dart';

abstract interface class ImoedabuscaRepository {
  Future<List<MoedaVirtual>> getCriptoMoedasymbol(List<String> nomes);
}

final class buscaMoeda implements ImoedabuscaRepository {
  final IRemoteDataSource _remoteDataSource;
  final IEnvironmentHelper _environment;

  const buscaMoeda(this._remoteDataSource, this._environment);

  @override
  Future<List<MoedaVirtual>> getCriptoMoedasymbol(List<String> nomes) async {
    final url = obterUrlComNomes(nomes, _environment);
    final HttpResponseEntity httpResponse = (await _remoteDataSource.get(url))!;

    final Map<String, dynamic> dados = httpResponse.data as Map<String, dynamic>;
    final List<MoedaVirtual> moedas = [];


    dados['data'].forEach((symbol, item) {
      moedas.add(MoedaVirtual.fromMap(item));
    });

    return moedas;
  }
}

String obterUrlComNomes(List<String> simbolos, IEnvironmentHelper environment) {
  final simbolosFormatados = simbolos.map((e) => e.trim().toUpperCase()).join(',');
  return '${environment.urlBuscarMoedasPorNomes}$simbolosFormatados';
}