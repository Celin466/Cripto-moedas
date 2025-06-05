import 'package:moedasvirtuais/core/wigets/show_dialog_widget.dart';
import 'package:moedasvirtuais/data/repositories/buscar_moeda.dart' show ImoedabuscaRepository;
import 'package:moedasvirtuais/data/repositories/listar_moedas.dart';
import 'package:moedasvirtuais/domain/entities/moeda/moeda_entity.dart';
import 'package:moedasvirtuais/utils/util_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moedasvirtuais/domain/entities/core/request_state_entity.dart';

final class TelaHomeViewModel extends Cubit<IRequestState<List<MoedaVirtual>>> {
  final ImoedaRepository _repository;
  final ImoedabuscaRepository _buscarepository;

  TelaHomeViewModel(this._repository, this._buscarepository) : super(const RequestInitiationState());

  void listarMoedas() async {
    try {
      _emitter(RequestProcessingState());

      final List<MoedaVirtual> cripmoedas = await _repository.getCriptoMoeda();
      _emitter(RequestCompletedState(value: cripmoedas));
    } catch (error) {
      final String erorrDescription = _createErrorDescription(error);
      showSnackBar(erorrDescription);
      _emitter(RequestErrorState(error: error));
    }
  }

  String _createErrorDescription(Object? error) {
    return UtilText.labelmoedaTitle;
  }

  void buscarMoedaPorNome(List<String> simbolos) async {
    try {
      _emitter(RequestProcessingState());

      final List<MoedaVirtual> cripmoedas = await _buscarepository.getCriptoMoedasymbol(simbolos);

      _emitter(RequestCompletedState(value: cripmoedas));

    } catch (error) {

      final String erorDescription = _createErroDescription(error);
      showSnackBar(erorDescription);
      _emitter(RequestErrorState(error: error));
    }
  }

  String _createErroDescription(Object? error) {
    return UtilText.labelmoedabuscaTitle;
  }

  void _emitter(IRequestState<List<MoedaVirtual>> state) {
    if (isClosed) return;
    emit(state);
  }
}








