import 'package:flutter/material.dart';

class Viagem with ChangeNotifier {
  final String idViagem;
  final String destino;
  final String dataIda;
  final String dataVolta;
  final String horarioIda;
  final String horarioVolta;
  final String idTransporte;
  final String idAcomodacao;
  final String roteiro;
  bool checkIn;
  bool checkOut;
  final double gastosPrevistos;
  final double gastosExtras;

  Viagem(
      {required this.idViagem,
      required this.destino,
      required this.dataIda,
      required this.dataVolta,
      required this.horarioIda,
      required this.horarioVolta,
      required this.roteiro,
      required this.idTransporte,
      required this.idAcomodacao,
      this.checkIn = false,
      this.checkOut = false,
      required this.gastosPrevistos,
      required this.gastosExtras});

  void makeChekIn() {
    checkIn = !checkIn;
    notifyListeners();
  }

  void makeChekOut() {
    checkOut = !checkOut;
    notifyListeners();
  }

  /*Map<String, dynamic> toMap(){
    return {
      'destino': this.destino,
      'dataIda': this.dataIda,
      'dataVolta': this.dataVolta,
      'horarioIda': this.horarioIda,
      'horarioVolta': this.horarioVolta,
      'transporte': this.transporte,
      'acomodacao': this.acomodacao,
      'gastos_previstos': this.gastos_previstos,
    };*/
  //}
}
