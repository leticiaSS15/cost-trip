import 'dart:convert';
import 'package:cost_trip/modelo/satisfacao.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DbSatisfacao with ChangeNotifier {
  Uri _baseUrl = Uri.parse(
      'https://cost-trip-app-default-rtdb.firebaseio.com/satisfacao.json');

  List<PesquisaSatisfacao> _pesquisaSatisfacao = [];

  List<PesquisaSatisfacao> get pesquisaSatisfacao => [..._pesquisaSatisfacao];

  PesquisaSatisfacao pesq = PesquisaSatisfacao(
      idSatisfacao: '', boasViagens: 0, masViagens: 0, totalViagens: 0);

  Future<void> addOpniao(PesquisaSatisfacao satisfacao) async {
    final response = await http.post(_baseUrl,
        body: json.encode({
          'boas_viagens': satisfacao.boasViagens,
          'mas_viagens': satisfacao.masViagens,
          'total_viagens': satisfacao.totalViagens,
        }));
    _pesquisaSatisfacao.add(PesquisaSatisfacao(
      idSatisfacao: json.decode(response.body)['name'],
      boasViagens: satisfacao.boasViagens,
      masViagens: satisfacao.masViagens,
      totalViagens: satisfacao.totalViagens,
    ));
    notifyListeners();
  }

  Future<void> loadOpniao(String idOpniao) async {
    final response = await http.get(_baseUrl);
    Map<String, dynamic> dados = json.decode(response.body);
    _pesquisaSatisfacao.clear();
    //print(json.decode(response.body));
    if (dados.isNotEmpty) {
      dados.forEach((pesqId, pesqData) {
        if (pesqId == idOpniao) {
          pesq = PesquisaSatisfacao(
            idSatisfacao: pesqId,
            boasViagens: pesqData['boas_viagens'],
            masViagens: pesqData['mas_viagens'],
            totalViagens: pesqData['total_viagens'],
          );
        }
        _pesquisaSatisfacao.add(PesquisaSatisfacao(
          idSatisfacao: pesqId,
          boasViagens: pesqData['boas_viagens'],
          masViagens: pesqData['mas_viagens'],
          totalViagens: pesqData['total_viagens'],
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> updateBoasViagens(PesquisaSatisfacao satisfacao) async {
    final index = _pesquisaSatisfacao
        .indexWhere((opniao) => opniao.idSatisfacao == satisfacao.idSatisfacao);
    Uri _editUrl = Uri.parse(
        'https://cost-trip-app-default-rtdb.firebaseio.com/satisfacao/${satisfacao.idSatisfacao}.json');

    if (index >= 0) {
      await http.patch(_editUrl,
          body: json.encode({
            'boas_viagens': satisfacao.boasViagens + 1,
            'mas_viagens': satisfacao.masViagens,
            'total_viagens': satisfacao.totalViagens + 1,
          }));
      _pesquisaSatisfacao[index] = satisfacao;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> updateMasViagens(PesquisaSatisfacao satisfacao) async {
    final index = _pesquisaSatisfacao
        .indexWhere((opniao) => opniao.idSatisfacao == satisfacao.idSatisfacao);
    Uri _editUrl = Uri.parse(
        'https://cost-trip-app-default-rtdb.firebaseio.com/satisfacao/${satisfacao.idSatisfacao}.json');

    if (index >= 0) {
      await http.patch(_editUrl,
          body: json.encode({
            'boas_viagens': satisfacao.boasViagens,
            'mas_viagens': satisfacao.masViagens + 1,
            'total_viagens': satisfacao.totalViagens + 1,
          }));
      _pesquisaSatisfacao[index] = satisfacao;
      notifyListeners();
    }
    notifyListeners();
  }
}
