import 'package:moedasvirtuais/configs/environment_helper.dart';
import 'package:moedasvirtuais/configs/factory_viewmodel.dart';
import 'package:moedasvirtuais/data/datasources/data_source.dart';
import 'package:moedasvirtuais/data/datasources/data_sources_factory.dart';
import 'package:moedasvirtuais/data/repositories/buscar_moeda.dart';
import 'package:moedasvirtuais/data/repositories/listar_moedas.dart';
import 'package:moedasvirtuais/ui/pages/home/view_models/view_home_viewmodel.dart';
import 'package:flutter/material.dart';

final class TelaPerfilFactoryViewmodel implements IFactoryViewModel<TelaHomeViewModel> {
  @override
  TelaHomeViewModel create(BuildContext context) {
    final IRemoteDataSource remoteDataSource = RemoteFactoryDataSource().create();
    final IEnvironmentHelper environmentHelper = const EnvironmentHelper();

    final ImoedabuscaRepository buscaRepository = buscaMoeda(remoteDataSource, environmentHelper);
    final ImoedaRepository moedaRepository = Moeda(remoteDataSource);

    return TelaHomeViewModel(moedaRepository,buscaRepository);
  }

  @override
  void dispose(BuildContext context, TelaHomeViewModel viewModel) {
    viewModel.close();
  }
}