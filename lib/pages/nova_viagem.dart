import 'package:cost_trip/views/viagem_form.dart';
import 'package:cost_trip/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class NovaViagem extends StatefulWidget {
  @override
  _NovaViagemState createState() => _NovaViagemState();
}

class _NovaViagemState extends State<NovaViagem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBarViagem(
            namePage: "Planejar nova viagem",
            tamanhoFonte: 19,
            exibirReturn: true,
            exibirPerfil: false,
            rota: '/pagHome',
          ),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(top: 110.0),
            child: NovaViagemForm(),
          )
        ],
      ),
    );
  }
}
