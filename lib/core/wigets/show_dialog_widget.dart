import 'package:moedasvirtuais/configs/factory_viewmodel.dart';
import 'package:moedasvirtuais/core/service/IApp_service.dart';

import '../../configs/injection_container.dart';




void showSnackBar(
    String msg, {
      Color? colorBackground,
      Duration duration = const Duration(seconds: 5),
      void Function()? onListen,
    }) {
  final BuildContext context = getIt<IAppService>().context!;
  final SnackBar snackBar = SnackBar(
    duration: duration,
    backgroundColor: colorBackground,
    margin: const EdgeInsets.all(34),
    behavior: SnackBarBehavior.floating,
    content: Text(
      msg,
    ),
  );
  try {
    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((value) {
      onListen?.call();
    });
  } catch (_) {}
}