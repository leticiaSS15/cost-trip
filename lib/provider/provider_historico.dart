import 'package:cost_trip/database/db_viagens.dart';
import 'package:cost_trip/widgets/card_viagem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderHistorico extends StatelessWidget {
  final String rota;
  final bool checkIN;

  const ProviderHistorico({Key? key, required this.rota, required this.checkIN})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viagensProvider = Provider.of<DbViagens>(context);
    final viagem = viagensProvider.viagensHistorico;
    return ListView.builder(
        itemCount: viagem.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: viagem[i],
              child: CardViewViagem(rota: rota),
            ));
  }
}
