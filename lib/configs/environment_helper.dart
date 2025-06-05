abstract interface class IEnvironmentHelper {
  String? get urlListarMoedas;
  String? get urlBuscarMoedasPorNomes;
}

final class EnvironmentHelper implements IEnvironmentHelper {
  const EnvironmentHelper();

  String get _urlBase => 'https://pro-api.coinmarketcap.com';

  @override
  String? get urlListarMoedas => '$_urlBase/v1/cryptocurrency/listings/latest';

  @override
  String get urlBuscarMoedasPorNomes => '$_urlBase/v1/cryptocurrency/quotes/latest?symbol=';
}