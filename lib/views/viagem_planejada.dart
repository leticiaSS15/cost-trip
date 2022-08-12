import 'package:cost_trip/provider/provider_viagens.dart';
import 'package:cost_trip/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ViagemPlanejada extends StatefulWidget {
  @override
  _ViagemPlanejadaState createState() => _ViagemPlanejadaState();
}

class _ViagemPlanejadaState extends State<ViagemPlanejada> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBarViagem(
            namePage: 'Viagens Planejadas',
            tamanhoFonte: 20.0,
            exibirReturn: true,
            exibirPerfil: false,
            rota: '/pagHome',
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0, left: 5, right: 5),
            child: ProviderViagens(rota: 'visualizar'),
          ),
        ],
      ),
    );
  }
}
