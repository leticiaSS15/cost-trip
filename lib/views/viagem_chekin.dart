import 'package:cost_trip/provider/provider_check_in.dart';
import 'package:cost_trip/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ViagemCheckin extends StatefulWidget {
  @override
  _ViagemCheckinState createState() => _ViagemCheckinState();
}

class _ViagemCheckinState extends State<ViagemCheckin> {
  final bool viagensCheckIN = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBarViagem(
            namePage: "Viagens com Check-In",
            tamanhoFonte: 18.0,
            exibirReturn: true,
            exibirPerfil: false,
            rota: '/pagHome',
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0, left: 5, right: 5),
            child: ProviderCheckIN(rota: 'checkin', checkIN: true),
          ),
        ],
      ),
    );
  }
}
