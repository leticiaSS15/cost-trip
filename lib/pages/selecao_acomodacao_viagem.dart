import 'package:cost_trip/modelo/transporte.dart';
import 'package:cost_trip/views/acomodacao_viagem.dart';
import 'package:cost_trip/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class AcomodacaoViagem extends StatefulWidget {
  final Map<String, Object> formDataViajem;
  final Transporte transporte;
  final double margemGastos;

  const AcomodacaoViagem(
      {Key? key,
      required this.formDataViajem,
      required this.transporte,
      required this.margemGastos})
      : super(key: key);

  @override
  _AcomodacaoViagemState createState() => _AcomodacaoViagemState();
}

class _AcomodacaoViagemState extends State<AcomodacaoViagem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBarViagem(
            namePage: "Selecione a Acomodação",
            tamanhoFonte: 16,
            exibirReturn: true,
            exibirPerfil: false,
            rota: '/pagTransporteViagem',
          ),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(top: 110.0),
            child: AcomodacaoForm(
              formDataViajem: widget.formDataViajem,
              transporte: widget.transporte,
              margemGastos: widget.margemGastos,
            ),
          )
        ],
      ),
    );
  }
}
