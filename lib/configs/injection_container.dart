
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:moedasvirtuais/configs/environment_helper.dart';
import 'package:moedasvirtuais/core/service/IApp_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
final GetIt getIt = GetIt.instance;

Future<void> init() async {
  /// #region EnvironmentHelper
  final IEnvironmentHelper environmentHelper = EnvironmentHelper();
  getIt.registerSingleton<IEnvironmentHelper>(environmentHelper);

  /// #region AppService
  getIt.registerSingleton<IAppService>(AppService(GlobalKey<NavigatorState>()));
}