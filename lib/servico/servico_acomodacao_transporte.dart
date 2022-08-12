import 'dart:async';

import 'package:cost_trip/database/db_acomodacao.dart';
import 'package:cost_trip/database/db_transporte.dart';
import 'package:cost_trip/modelo/acomodacao.dart';
import 'package:cost_trip/modelo/transporte.dart';
import 'package:cost_trip/modelo/viagem.dart';
import 'package:cost_trip/pages/visualizar_viagem.dart';
import 'package:cost_trip/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ServicoAcoTrans extends StatefulWidget {
  final Viagem viagem;
  final String tela;

  const ServicoAcoTrans({Key? key, required this.viagem, required this.tela})
      : super(key: key);

  @override
  _ServicoAcoTransState createState() => _ServicoAcoTransState();
}

class _ServicoAcoTransState extends State<ServicoAcoTrans> {
  DbAcomodacao _dbAcomodacao = DbAcomodacao();
  DbTransporte _dbTransporte = DbTransporte();
  Acomodacao newAcomodacao = Acomodacao(
      idAcomodacao: '',
      custoAcomodacao: 0.0,
      custoEstacionamento: 0.0,
      seguroLocal: 0.0,
      totalGastosAcomodacao: 0.0);
  Transporte newTransporte = Transporte(
      idTransporte: '',
      custoPassagem: 0.0,
      custoBagagem: 0.0,
      seguroViagem: 0.0,
      totalGastosTransporte: 0.0);

  bool _isLoading = true;

  Acomodacao loadAco() {
    _dbAcomodacao.loadAcomodacao(widget.viagem.idAcomodacao);
    var acomodacao = _dbAcomodacao.newAcomodacao;
    return acomodacao;
  }

  Transporte loadTrasn() {
    _dbTransporte.loadTransporte(widget.viagem.idTransporte);
    var transporte = _dbTransporte.newTransporte;
    return transporte;
  }

  @override
  void initState() {
    const oneSecond = const Duration(seconds: 2);
    new Timer.periodic(oneSecond, (Timer t) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    newAcomodacao = loadAco();
    newTransporte = loadTrasn();
    if (newTransporte.idTransporte.isNotEmpty &&
        newAcomodacao.idAcomodacao.isNotEmpty) {
      setState(() {
        _isLoading = false;
      });
    }
    return Stack(children: <Widget>[
      AppBarViagem(
        namePage: "Detalhes da Viagem",
        tamanhoFonte: 19,
        exibirReturn: true,
        exibirPerfil: false,
        rota: '/pagMinhasViagens',
      ),
      _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : VisualizarViagem(
              tela: widget.tela,
              viagem: widget.viagem,
              acomodacao: newAcomodacao,
              transporte: newTransporte,
            )
    ]);
  }
}
