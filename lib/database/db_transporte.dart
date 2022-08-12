import 'dart:convert';
import 'package:cost_trip/modelo/transporte.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DbTransporte with ChangeNotifier {
  String idTransporte = '';

  Uri _baseUrl = Uri.parse(
      'https://cost-trip-app-default-rtdb.firebaseio.com/transporte.json');

  List<Transporte> _transportes = [];

  List<Transporte> get transportes => [..._transportes];

  int get itemsCount {
    return _transportes.length;
  }

  Transporte newTransporte = Transporte(
      idTransporte: '',
      custoPassagem: 0.0,
      custoBagagem: 0.0,
      seguroViagem: 0.0,
      totalGastosTransporte: 0.0);

  Future<String> addTransporte(Transporte newTransporte) async {
    final response = await http.post(_baseUrl,
        body: json.encode({
          'custo_passagem': newTransporte.custoPassagem,
          'custo_bagagem': newTransporte.custoBagagem,
          'seguro_viagem': newTransporte.seguroViagem,
          'total_gastos_transporte': newTransporte.totalGastosTransporte,
        }));
    _transportes.add(Transporte(
      idTransporte: json.decode(response.body)['name'],
      custoPassagem: newTransporte.custoPassagem,
      custoBagagem: newTransporte.custoBagagem,
      seguroViagem: newTransporte.seguroViagem,
      totalGastosTransporte: newTransporte.totalGastosTransporte,
    ));

    notifyListeners();

    return idTransporte = json.decode(response.body)['name'].toString();
  }

  Future<void> updateTransporte(Transporte transporte) async {
    if (transporte.idTransporte.isEmpty) {
      return;
    }

    final index = _transportes
        .indexWhere((trip) => trip.idTransporte == transporte.idTransporte);
    Uri _editUrl = Uri.parse(
        'https://cost-trip-app-default-rtdb.firebaseio.com/viagens/${transporte.idTransporte}.json');

    if (index >= 0) {
      await http.patch(_editUrl,
          body: json.encode({
            'custo_passagem': transporte.custoPassagem,
            'custo_bagagem': transporte.custoBagagem,
            'seguro_viagem': transporte.seguroViagem,
            'total_gastos_transporte': transporte.totalGastosTransporte,
          }));
      _transportes[index] = transporte;
      notifyListeners();
    }
  }

  Future<void> loadAllTransporte() async {
    final response = await http.get(_baseUrl);
    Map<String, dynamic> dados = json.decode(response.body);
    _transportes.clear();
    if (dados.isNotEmpty) {
      dados.forEach((viagemId, viagemData) {
        _transportes.add(Transporte(
          idTransporte: viagemId,
          custoPassagem: viagemData['custo_passagem'],
          custoBagagem: viagemData['custo_bagagem'],
          seguroViagem: viagemData['seguro_viagem'],
          totalGastosTransporte: viagemData['total_gastos_transporte'],
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> loadTransporte(String idTransporte) async {
    final response = await http.get(_baseUrl);
    Map<String, dynamic> dados = json.decode(response.body);
    _transportes.clear();

    dados.forEach((trasnId, transData) {
      if (trasnId == idTransporte) {
        newTransporte = Transporte(
            idTransporte: trasnId,
            custoPassagem: transData['custo_passagem'],
            custoBagagem: transData['custo_bagagem'],
            seguroViagem: transData['seguro_viagem'],
            totalGastosTransporte: transData['total_gastos_transporte']);
      }
    });
    notifyListeners();
    return Future.value();
  }

  Future<void> deleteTransporte(String id) async {
    print(id);

    final index = _transportes.indexWhere((trans) => trans.idTransporte == id);

    print('DELETE TRANSPORTE');

    if (index >= 0) {
      final transportes = _transportes[index];
      Uri _editUrl = Uri.parse(
          'https://cost-trip-app-default-rtdb.firebaseio.com/transporte/${transportes.idTransporte}.json');
      _transportes.remove(transportes);
      notifyListeners();

      final response = await http.delete(_editUrl);

      if (response.statusCode >= 400) {
        _transportes.insert(index, transportes);
        notifyListeners();
      }
    }
  }
}
