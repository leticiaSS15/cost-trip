import 'dart:convert';
import 'package:cost_trip/modelo/viagem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DbViagens with ChangeNotifier {
  Uri _baseUrl = Uri.parse(
      'https://cost-trip-app-default-rtdb.firebaseio.com/viagens.json');

  List<Viagem> _viagens = [];

  List<Viagem> get viagens => [..._viagens];

  List<Viagem> get allViagens {
    return _viagens.where((trip) => !trip.checkIn && !trip.checkOut).toList();
  }

  List<Viagem> get viagensCheckIN {
    return _viagens.where((trip) => trip.checkIn && !trip.checkOut).toList();
  }

  List<Viagem> get viagensHistorico {
    return _viagens.where((trip) => trip.checkIn && trip.checkOut).toList();
  }

  int get itemsCount {
    return _viagens.length;
  }

  Future<void> addViagem(Viagem newViagem) async {
    final response = await http.post(_baseUrl,
        body: json.encode({
          'destino': newViagem.destino,
          'dataIda': newViagem.dataIda,
          'dataVolta': newViagem.dataVolta,
          'horarioIda': newViagem.horarioIda,
          'horarioVolta': newViagem.horarioVolta,
          'roteiro': newViagem.roteiro,
          'check_in': newViagem.checkIn,
          'check_out': newViagem.checkOut,
          'gastos_previstos': newViagem.gastosPrevistos,
          'gastos_extras': newViagem.gastosExtras,
          'id_transporte': newViagem.idTransporte,
          'id_acomodacao': newViagem.idAcomodacao,
        }));
    _viagens.add(Viagem(
      idViagem: json.decode(response.body)['name'],
      destino: newViagem.destino,
      dataIda: newViagem.dataIda,
      dataVolta: newViagem.dataVolta,
      horarioIda: newViagem.horarioIda,
      horarioVolta: newViagem.horarioVolta,
      roteiro: newViagem.roteiro,
      checkIn: newViagem.checkIn,
      checkOut: newViagem.checkOut,
      gastosPrevistos: newViagem.gastosPrevistos,
      gastosExtras: newViagem.gastosExtras,
      idTransporte: newViagem.idTransporte,
      idAcomodacao: newViagem.idAcomodacao,
    ));
    notifyListeners();
  }

  Future<void> updateViagem(Viagem oldViagem) async {
    print(oldViagem.idViagem);
    print(oldViagem.destino);
    print(_viagens);

    final index =
        _viagens.indexWhere((trip) => trip.idViagem == oldViagem.idViagem);
    Uri _editUrl = Uri.parse(
        'https://cost-trip-app-default-rtdb.firebaseio.com/viagens/${oldViagem.idViagem}.json');

    print(index);

    if (index >= 0) {
      await http.patch(_editUrl,
          body: json.encode({
            'destino': oldViagem.destino,
            'dataIda': oldViagem.dataIda,
            'dataVolta': oldViagem.dataVolta,
            'horarioIda': oldViagem.horarioIda,
            'horarioVolta': oldViagem.horarioVolta,
            'id_transporte': oldViagem.idTransporte,
            'id_acomodacao': oldViagem.idAcomodacao,
            'check_in': oldViagem.checkIn,
            'check_out': oldViagem.checkOut,
            'gastos_previstos': oldViagem.gastosPrevistos,
            'gastos_extras': oldViagem.gastosExtras,
          }));
      _viagens[index] = oldViagem;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> loadViagem() async {
    final response = await http.get(_baseUrl);
    //print(json.decode(response.body));
    Map<String, dynamic> dados = json.decode(response.body);
    _viagens.clear();
    //print(json.decode(response.body));
    if (dados.isNotEmpty) {
      dados.forEach((viagemId, viagemData) {
        _viagens.add(Viagem(
            idViagem: viagemId,
            destino: viagemData['destino'],
            dataIda: viagemData['dataIda'],
            dataVolta: viagemData['dataVolta'],
            horarioIda: viagemData['horarioIda'],
            horarioVolta: viagemData['horarioVolta'],
            roteiro: viagemData['roteiro'],
            checkIn: viagemData['check_in'],
            checkOut: viagemData['check_out'],
            gastosPrevistos: viagemData['gastos_previstos'],
            gastosExtras: viagemData['gastos_extras'],
            idTransporte: viagemData['id_transporte'].toString(),
            idAcomodacao: viagemData['id_acomodacao'].toString()));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> deleteViagem(String id) async {
    final index = _viagens.indexWhere((trip) => trip.idViagem == id);

    print('DELETE VIAGEM');

    if (index >= 0) {
      final viagem = _viagens[index];
      Uri _editUrl = Uri.parse(
          'https://cost-trip-app-default-rtdb.firebaseio.com/viagens/${viagem.idViagem}.json');
      _viagens.remove(viagem);
      notifyListeners();

      final response = await http.delete(_editUrl);

      if (response.statusCode >= 400) {
        _viagens.insert(index, viagem);
        notifyListeners();
      }
    }
  }

  Future<void> makeChekIn(Viagem viagemCheckIN) async {
    if (!viagemCheckIN.checkIn) {
      viagemCheckIN.makeChekIn();
    }

    Uri _baseUrl = Uri.parse(
        'https://cost-trip-app-default-rtdb.firebaseio.com/viagens/${viagemCheckIN.idViagem}.json');

    final response = await http.patch(_baseUrl,
        body: json.encode({
          'check_in': viagemCheckIN.checkIn,
        }));
    if (response.statusCode >= 400) {
      viagemCheckIN.makeChekIn();
    }
  }

  Future<void> makeChekOut(Viagem viagemCheckOUT) async {
    if (!viagemCheckOUT.checkOut) {
      viagemCheckOUT.makeChekOut();
    }

    Uri _baseUrl = Uri.parse(
        'https://cost-trip-app-default-rtdb.firebaseio.com/viagens/${viagemCheckOUT.idViagem}.json');

    final response = await http.patch(_baseUrl,
        body: json.encode({
          'check_out': viagemCheckOUT.checkOut,
        }));
    if (response.statusCode >= 400) {
      viagemCheckOUT.makeChekOut();
    }
  }

  Future<void> addGastosExtras(Viagem gastosExtras, double gastosE) async {
    Uri _baseUrl = Uri.parse(
        'https://cost-trip-app-default-rtdb.firebaseio.com/viagens/${gastosExtras.idViagem}.json');

    await http.patch(_baseUrl,
        body: json.encode({
          'gastos_extras': gastosE,
        }));
  }
}
