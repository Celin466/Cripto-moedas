import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moedasvirtuais/configs/factory_viewmodel.dart';
import 'package:moedasvirtuais/domain/entities/core/request_state_entity.dart';
import 'package:moedasvirtuais/domain/entities/moeda/moeda_entity.dart';
import 'package:moedasvirtuais/ui/pages/home/view_models/view_home_viewmodel.dart';
import 'package:moedasvirtuais/utils/util_format.dart';
import 'package:moedasvirtuais/utils/util_text.dart';

class HomeWidgets extends StatefulWidget {
  const HomeWidgets({super.key});

  @override
  State<HomeWidgets> createState() => _HomeWidgetsState();
}

class _HomeWidgetsState extends State<HomeWidgets> {
  late final TelaHomeViewModel _viewModel;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<TelaHomeViewModel>();
    _viewModel.listarMoedas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Buscar (ex: BTC, BHC, BNB)',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _buscarMoeda,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text('Buscar', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<TelaHomeViewModel, IRequestState<List<MoedaVirtual>>>(
                builder: (context, state) {
                  if (state is RequestProcessingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is RequestCompletedState) {
                    final listaMoedas = state.data;
                    return RefreshIndicator(
                      onRefresh: () async => _viewModel.listarMoedas(),
                      child: Container(
                        color: Colors.grey[100],
                        child: ListView.separated(
                          itemCount: listaMoedas.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final moeda = listaMoedas[index];
                            return GestureDetector(
                              onTap: () => _mostrarDetalhesDaMoeda(context, moeda),
                              child: MoedaCard(
                                nome: moeda.name,
                                sigla: moeda.symbol,
                                valorUSD: formatadorUSD.format(moeda.price),
                                valorBRL: formatadorBRL.format(moeda.price * 5.73),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }

                  return const Center(child: Text('Nenhuma moeda encontrada.'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _buscarMoeda() {
    final nomesAreviados = formatarSimbolos(_controller.text);
    final lista = nomesAreviados.isEmpty ? todasMoedas : nomesAreviados;
    _viewModel.buscarMoedaPorNome(lista);
  }
}

class MoedaCard extends StatelessWidget {
  final String nome;
  final String sigla;
  final String valorUSD;
  final String valorBRL;

  const MoedaCard({
    super.key,
    required this.nome,
    required this.sigla,
    required this.valorUSD,
    required this.valorBRL,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nome, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(sigla, style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(valorUSD, style: const TextStyle(fontSize: 16)),
                      Text(valorBRL, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void _mostrarDetalhesDaMoeda(BuildContext context, MoedaVirtual moeda) {
  final formatadorUSD = NumberFormat.currency(locale: 'en_US', symbol: 'US\$');
  final formatadorBRL = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.grey[100],
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(moeda.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Data adicionada: ${formatarData(moeda.date_added)}'),
          Text('Símbolo: ${moeda.symbol}'),
          const SizedBox(height: 12),
          Text('Preço atual USD: ${formatadorUSD.format(moeda.price)}'),
          Text('Preço atual BRL: ${formatadorBRL.format(moeda.price * 5.73)}'),
        ],
      ),
    ),
  );
}
