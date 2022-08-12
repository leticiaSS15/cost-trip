import 'package:flutter/material.dart';

class AppBarViagem extends StatefulWidget {
  final String namePage;
  final double tamanhoFonte;
  final bool exibirReturn;
  final bool exibirPerfil;
  final String rota;

  const AppBarViagem(
      {Key? key,
      required this.namePage,
      required this.tamanhoFonte,
      required this.exibirReturn,
      required this.exibirPerfil,
      required this.rota})
      : super(key: key);
  @override
  _AppBarViagemState createState() => _AppBarViagemState();
}

class _AppBarViagemState extends State<AppBarViagem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 60, 255, 0.5),
                  Color.fromRGBO(0, 188, 117, 0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          if (widget.exibirPerfil)
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/pagUsuário');
                },
                icon: Icon(Icons.account_circle),
                iconSize: 40.0,
                color: Colors.black,
              ),
            ),
          if (widget.exibirReturn)
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, widget.rota);
                },
                icon: Icon(Icons.arrow_back),
                iconSize: 30.0,
                color: Colors.black,
              ),
            ),
          Container(
            margin: EdgeInsets.only(top: 20.0, left: 20.0),
            padding: EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 90,
            ),
            child: Text(
              '${widget.namePage}',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: widget.tamanhoFonte,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
