import 'package:cost_trip/database/db_acomodacao.dart';
import 'package:cost_trip/database/db_satisfacao.dart';
import 'package:cost_trip/database/db_transporte.dart';
import 'package:cost_trip/database/db_viagens.dart';
import 'package:cost_trip/modelo/acomodacao.dart';
import 'package:cost_trip/modelo/transporte.dart';
import 'package:cost_trip/modelo/viagem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicoViagem with ChangeNotifier {
  DbViagens _dbViagens = DbViagens();
  DbAcomodacao _dbAcomodacao = DbAcomodacao();
  DbTransporte _dbTransporte = DbTransporte();
  DbSatisfacao _dbSatisfacao = DbSatisfacao();
  Acomodacao newAcomodacao = Acomodacao(
      idAcomodacao: '',
      custoAcomodacao: 0.0,
      custoEstacionamento: 0.0,
      seguroLocal: 0.0,
      totalGastosAcomodacao: 0.0);

  Future<void> salvarViagem(Map dados, Transporte transporte,
      Acomodacao acomodacao, String roteiro) async {
    final newAcomodacao = Acomodacao(
        idAcomodacao: '',
        custoAcomodacao: acomodacao.custoAcomodacao,
        custoEstacionamento: acomodacao.custoEstacionamento,
        seguroLocal: acomodacao.seguroLocal,
        totalGastosAcomodacao: acomodacao.totalGastosAcomodacao);

    await _dbAcomodacao.addAcomodacao(newAcomodacao);
    var idAcomodacao = _dbAcomodacao.idAcomodacao;

    final newTransporte = Transporte(
        idTransporte: '',
        custoPassagem: transporte.custoPassagem,
        custoBagagem: transporte.custoBagagem,
        seguroViagem: transporte.seguroViagem,
        totalGastosTransporte: transporte.totalGastosTransporte);

    await _dbTransporte.addTransporte(newTransporte);
    var idTransporte = _dbTransporte.idTransporte;

    if (roteiro.isEmpty) {
      roteiro = 'Nenhum roteiro cadastrado';
    }

    final newViagem = Viagem(
      idViagem: '',
      destino: dados['destino'],
      dataIda: dados['dataIda'],
      dataVolta: dados['dataVolta'],
      horarioIda: dados['horaIda'],
      horarioVolta: dados['horaVolta'],
      roteiro: roteiro,
      gastosPrevistos: dados['gastos_previstos'],
      gastosExtras: 0.0,
      idAcomodacao: idAcomodacao.toString(),
      idTransporte: idTransporte.toString(),
    );
    _dbViagens.addViagem(newViagem);
  }

  Future<void> updateViagem(Viagem viagem, Map formEdicao) async {
    final newViagem = Viagem(
      idViagem: viagem.idViagem,
      destino: formEdicao['destino'],
      dataIda: formEdicao['dataIda'],
      dataVolta: formEdicao['dataVolta'],
      horarioIda: formEdicao['horaIda'],
      horarioVolta: formEdicao['horaVolta'],
      roteiro: viagem.roteiro,
      gastosPrevistos: formEdicao['gastos_previstos'],
      gastosExtras: viagem.gastosExtras,
      idAcomodacao: viagem.idAcomodacao,
      idTransporte: viagem.idTransporte,
    );
    await _dbViagens.loadViagem();
    _dbViagens.updateViagem(newViagem);
  }

  Future<void> deletarViagem(Viagem viagem, context) async {
    Provider.of<DbViagens>(context, listen: false)
        .deleteViagem(viagem.idViagem);
    Provider.of<DbAcomodacao>(context, listen: false)
        .deleteAcomodacao(viagem.idAcomodacao);
    Provider.of<DbTransporte>(context, listen: false)
        .deleteTransporte(viagem.idTransporte);
  }

  Future<void> pesqSatisfacao(bool updateOp) async {
    String id = '-N9J4EDonKQXeWPnCAI_';

    await _dbSatisfacao.loadOpniao(id);
    var newOpniao = _dbSatisfacao.pesq;
    if (updateOp) {
      _dbSatisfacao.updateBoasViagens(newOpniao);
    } else {
      _dbSatisfacao.updateMasViagens(newOpniao);
    }
  }
}
