import 'package:moedasvirtuais/configs/environment_helper.dart';
import 'package:moedasvirtuais/configs/injection_container.dart';
import 'package:moedasvirtuais/core/service/http_service.dart';
import 'package:moedasvirtuais/data/datasources/data_source.dart';
import 'package:moedasvirtuais/data/datasources/remote_datasource.dart';

final class RemoteFactoryDataSource {
  IRemoteDataSource create() {
    final IHttpService httpService = HttpServiceFactory().create();
    final IEnvironmentHelper environmentHelper = getIt<IEnvironmentHelper>();
    return RemoteDataSource(
      httpService,
      environmentHelper,
    );
  }
}