import 'dart:async';

import 'package:cost_trip/database/db_satisfacao.dart';
import 'package:flutter/material.dart';

class UsuarioForm extends StatefulWidget {
  @override
  _UsuarioFormState createState() => _UsuarioFormState();
}

class _UsuarioFormState extends State<UsuarioForm> {
  DateTime now = new DateTime.now();
  DateTime date = DateTime.now();
  var controller = new TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _isLoading = true;
  DbSatisfacao _dbSatisfacao = DbSatisfacao();

  @override
  void initState() {
    const oneSecond = const Duration(seconds: 2);
    new Timer.periodic(
        oneSecond,
        (Timer t) => setState(() {
              _isLoading = false;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String id = '-Mi8NCf_tKF-zXJUGtm6';
    _dbSatisfacao.loadOpniao(id);
    var opniao = _dbSatisfacao.pesq;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Form(
                key: _form,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 30.0, top: 5.0),
                      child: TextFormField(
                        //initialValue: 'ze',
                        decoration: InputDecoration(
                            focusColor: Colors.black,
                            labelText: ('Pafuncio_15'),
                            labelStyle: TextStyle(fontSize: 20),
                            hintText: 'Ex: Pafuncio_15',
                            icon: Icon(Icons.perm_identity)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 30.0, top: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: ('pafuncio@gmail.com'),
                            labelStyle: TextStyle(fontSize: 20),
                            hintText: 'Ex: pafuncio@gmail.com',
                            icon: Icon(Icons.email)),
                      ),
                    ),
                    SizedBox(height: 50.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text('Viagens já feitas:',
                                  style: TextStyle(fontSize: 18))),
                          Expanded(
                              child: Text(
                            '${opniao.totalViagens}',
                            style: TextStyle(fontSize: 20),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(height: 50.0),
                    Text('Viagens mantidas dentro do planejamento:',
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 30.0),
                    Row(
                      children: [
                        Expanded(child: Icon(Icons.thumb_up, size: 30)),
                        Expanded(
                            child: Text(
                          '${opniao.boasViagens}',
                          style: TextStyle(fontSize: 20),
                        )),
                      ],
                    ),
                    SizedBox(height: 40.0),
                    Text(
                      'Viagens que ultrapassaram o planejamento:',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      children: [
                        Expanded(child: Icon(Icons.thumb_down, size: 30)),
                        Expanded(
                            child: Text(
                          ' ${opniao.masViagens}',
                          style: TextStyle(fontSize: 20),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
