import 'package:cost_trip/modelo/viagem.dart';
import 'package:cost_trip/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ViewRoteiro extends StatefulWidget {
  final Viagem viagem;

  const ViewRoteiro({Key? key, required this.viagem}) : super(key: key);
  @override
  _ViewRoteiroState createState() => _ViewRoteiroState();
}

class _ViewRoteiroState extends State<ViewRoteiro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          AppBarViagem(
            namePage: "Roteiro da viagem para ${widget.viagem.destino}",
            tamanhoFonte: 19,
            exibirReturn: true,
            exibirPerfil: false,
            rota: '/pagMinhasViagens',
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250.0, right: 35.0, left: 35.0),
            child: TextFormField(
              enabled: false,
              initialValue: widget.viagem.roteiro,
              maxLines: 5,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
