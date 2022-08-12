import 'package:cost_trip/modelo/acomodacao.dart';
import 'package:cost_trip/modelo/transporte.dart';
import 'package:cost_trip/views/roteiro_form.dart';
import 'package:cost_trip/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class RoteiroViagem extends StatefulWidget {
  final Map<String, Object> formDataViajem;
  final Transporte transporte;
  final Acomodacao acomodacao;
  final double margemGastos;

  const RoteiroViagem(
      {Key? key,
      required this.formDataViajem,
      required this.transporte,
      required this.margemGastos,
      required this.acomodacao})
      : super(key: key);

  @override
  _RoteiroViagemState createState() => _RoteiroViagemState();
}

class _RoteiroViagemState extends State<RoteiroViagem> {
  bool visualizacao = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBarViagem(
            namePage: "Definir roteiro",
            tamanhoFonte: 19,
            exibirReturn: true,
            exibirPerfil: false,
            rota: '/pagAcomodacaoViagem',
          ),
          SizedBox(height: 100),
          RoteiroForm(
              formDataViajem: widget.formDataViajem,
              transporte: widget.transporte,
              acomodacao: widget.acomodacao,
              margemGastos: widget.margemGastos),
        ],
      ),
    );
  }
}
