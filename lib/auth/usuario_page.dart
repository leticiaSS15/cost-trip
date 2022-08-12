import 'package:cost_trip/views/usuario_form.dart';
import 'package:cost_trip/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class UsuarioPage extends StatefulWidget {
  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AppBarViagem(
            namePage: 'Meus dados',
            tamanhoFonte: 30,
            exibirReturn: true,
            exibirPerfil: false,
            rota: '/pagHome',
          ),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: UsuarioForm(),
          )
        ],
      ),
    );
  }
}
