import 'package:flutter/material.dart';

class Acomodacao with ChangeNotifier {
  final String idAcomodacao;
  final double custoAcomodacao;
  final double custoEstacionamento;
  final double seguroLocal;
  final double totalGastosAcomodacao;

  Acomodacao(
      {required this.idAcomodacao,
      required this.custoAcomodacao,
      required this.custoEstacionamento,
      required this.seguroLocal,
      required this.totalGastosAcomodacao});
}
