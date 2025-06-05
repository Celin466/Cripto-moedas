import 'package:flutter/material.dart';

class MoedaVirtual {
  final String name;
  final String symbol;
  final String date_added;
  final double price;

  MoedaVirtual({
    required this.name,
    required this.symbol,
    required this.date_added,
    required this.price,
  });

  static MoedaVirtual fromMap(Map<String, dynamic> MoedaMap) {
    double priceValue = 0.0;

    try {
      final quote = MoedaMap['quote'];
      if (quote != null && quote['USD'] != null && quote['USD']['price'] != null) {
        priceValue = (quote['USD']['price'] as num).toDouble();
      }
    } catch (e) {
      print('Erro ao ler o preço: $e');
    }

    return MoedaVirtual(
      name: MoedaMap['name'],
      symbol: MoedaMap['symbol'],
      date_added: MoedaMap['date_added'],
      price: priceValue,
    );
  }
}
