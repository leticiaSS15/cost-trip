import 'package:flutter/material.dart';

class PesquisaSatisfacao with ChangeNotifier {
  final String idSatisfacao;
  final int boasViagens;
  final int masViagens;
  final int totalViagens;

  PesquisaSatisfacao(
      {required this.idSatisfacao,
      required this.boasViagens,
      required this.masViagens,
      required this.totalViagens});
}
