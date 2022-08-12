import 'package:flutter/material.dart';

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(100.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 120),
          SizedBox(
            width: 200.0,
            height: 60.0,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                "Nova Viajem",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              backgroundColor: Colors.greenAccent,
              onPressed: () {
                Navigator.pushNamed(context, '/pagNovaViagem');
              },
            ),
          ),
          SizedBox(height: 80),
          SizedBox(
            width: 200.0,
            height: 60.0,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                "Minhas Viagens",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              backgroundColor: Colors.greenAccent,
              onPressed: () {
                Navigator.pushNamed(context, '/pagMinhasViagens');
              },
            ),
          ),
          SizedBox(height: 80),
          SizedBox(
            width: 200.0,
            height: 60.0,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                "Histórico",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              backgroundColor: Colors.greenAccent,
              onPressed: () {
                Navigator.pushNamed(context, '/pagHistoricoViagem');
              },
            ),
          ),
        ],
      ),
    );
  }
}
