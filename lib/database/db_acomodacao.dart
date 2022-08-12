import 'dart:convert';
import 'package:cost_trip/modelo/acomodacao.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DbAcomodacao with ChangeNotifier {
  String idAcomodacao = '';

  Uri _baseUrl = Uri.parse(
      'https://cost-trip-app-default-rtdb.firebaseio.com/acomodacao.json');

  List<Acomodacao> _acomodacao = [];

  List<Acomodacao> get acomodacao => [..._acomodacao];

  Acomodacao newAcomodacao = Acomodacao(
      idAcomodacao: '',
      custoAcomodacao: 0.0,
      custoEstacionamento: 0.0,
      seguroLocal: 0.0,
      totalGastosAcomodacao: 0.0);

  int get itemsCount {
    return _acomodacao.length;
  }

  Future<void> addAcomodacao(Acomodacao newAcomodacao) async {
    final response = await http.post(_baseUrl,
        body: json.encode({
          'custo_acomodacao': newAcomodacao.custoAcomodacao,
          'custo_estacionamento': newAcomodacao.custoEstacionamento,
          'seguro_local': newAcomodacao.seguroLocal,
          'total_gastos_acomodacao': newAcomodacao.totalGastosAcomodacao,
        }));
    _acomodacao.add(Acomodacao(
        idAcomodacao: json.decode(response.body)['name'],
        custoAcomodacao: newAcomodacao.custoAcomodacao,
        custoEstacionamento: newAcomodacao.custoEstacionamento,
        seguroLocal: newAcomodacao.seguroLocal,
        totalGastosAcomodacao: newAcomodacao.totalGastosAcomodacao));

    idAcomodacao = json.decode(response.body)['name'].toString();
    print(json.decode(response.body)['name'].toString());
    notifyListeners();
  }

  Future<void> updateAcomodacao(Acomodacao acomodacao) async {
    if (acomodacao.idAcomodacao.isEmpty) {
      return;
    }

    final index = _acomodacao
        .indexWhere((acomod) => acomod.idAcomodacao == acomodacao.idAcomodacao);
    Uri _editUrl = Uri.parse(
        'https://cost-trip-app-default-rtdb.firebaseio.com/viagens/${acomodacao.idAcomodacao}.json');

    if (index >= 0) {
      await http.patch(_editUrl,
          body: json.encode({
            'custo_acomodacao': acomodacao.custoAcomodacao,
            'custo_estacionamento': acomodacao.custoEstacionamento,
            'seguro_local': acomodacao.seguroLocal,
            'total_gastos_acomodacao': acomodacao.totalGastosAcomodacao,
          }));
      _acomodacao[index] = acomodacao;
      notifyListeners();
    }
  }

  Future<void> loadAcomodacao(String idAcomodacao) async {
    final response = await http.get(_baseUrl);
    Map<String, dynamic> dados = json.decode(response.body);
    _acomodacao.clear();

    dados.forEach((acomodId, acomodData) {
      if (acomodId == idAcomodacao) {
        newAcomodacao = Acomodacao(
            idAcomodacao: acomodId,
            custoAcomodacao: acomodData['custo_acomodacao'],
            custoEstacionamento: acomodData['custo_estacionamento'],
            seguroLocal: acomodData['seguro_local'],
            totalGastosAcomodacao: acomodData['total_gastos_acomodacao']);
      }
    });
    notifyListeners();
    return Future.value();
  }

  Future<void> loadAllAcomodacao() async {
    final response = await http.get(_baseUrl);
    Map<String, dynamic> dados = json.decode(response.body);
    _acomodacao.clear();
    dados.forEach((viagemId, viagemData) {
      _acomodacao.add(Acomodacao(
          idAcomodacao: viagemId,
          custoAcomodacao: viagemData['custo_acomodacao'],
          custoEstacionamento: viagemData['custo_estacionamento'],
          seguroLocal: viagemData['seguro_local'],
          totalGastosAcomodacao: viagemData['total_gastos_acomodacao']));
    });
    notifyListeners();
    return Future.value();
  }

  Future<void> deleteAcomodacao(String id) async {
    print(id);

    final index = _acomodacao.indexWhere((acomod) => acomod.idAcomodacao == id);

    print('DELETE ACOMODACAO');

    if (index >= 0) {
      final acomodacao = _acomodacao[index];
      Uri _editUrl = Uri.parse(
          'https://cost-trip-app-default-rtdb.firebaseio.com/acomodacao/${acomodacao.idAcomodacao}.json');
      _acomodacao.remove(acomodacao);
      notifyListeners();

      final response = await http.delete(_editUrl);

      if (response.statusCode >= 400) {
        _acomodacao.insert(index, acomodacao);
        notifyListeners();
      }
    }
  }
}
