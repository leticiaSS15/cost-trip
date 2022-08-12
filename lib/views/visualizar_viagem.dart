import 'package:cost_trip/database/db_viagens.dart';
import 'package:cost_trip/modelo/acomodacao.dart';
import 'package:cost_trip/modelo/transporte.dart';
import 'package:cost_trip/modelo/viagem.dart';
import 'package:cost_trip/pages/despesas_extras.dart';
import 'package:cost_trip/servico/servico_viagens.dart';
import 'package:cost_trip/views/edit_form.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ViewViagem extends StatefulWidget {
  final String tela;
  final Viagem viagem;
  final Acomodacao acomodacao;
  final Transporte transporte;

  const ViewViagem(
      {Key? key,
      required this.tela,
      required this.viagem,
      required this.acomodacao,
      required this.transporte})
      : super(key: key);

  @override
  _ViewViagemState createState() => _ViewViagemState();
}

class _ViewViagemState extends State<ViewViagem> {
  var controller = new TextEditingController();
  final DbViagens viagens = DbViagens();
  final ServicoViagem servicoViagem = ServicoViagem();
  bool _edicao = false;
  final _form = GlobalKey<FormState>();
  final formEdicao = Map<String, Object>();
  var maskFormatterDate = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  var maskFormatterHour = new MaskTextInputFormatter(
      mask: '##:##', filter: {"#": RegExp(r'[0-9]')});
  String rota = '';

  _saveForm() {
    _form.currentState!.save();
    servicoViagem.updateViagem(widget.viagem, formEdicao);
  }

  _pesqSatisfacao() {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Sobre a sua viagem'),
              content: Text('Os gastos se mantiveram dentro planejado?'),
              actions: [
                IconButton(
                  icon: Icon(Icons.thumb_up, size: 25),
                  onPressed: () {
                    servicoViagem.pesqSatisfacao(true);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Obrigada por sua opnião!')));
                    Navigator.pushNamed(context, '/pagMinhasViagens');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.thumb_down, size: 25),
                  onPressed: () {
                    servicoViagem.pesqSatisfacao(false);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Obrigada por sua opnião!')));
                    Navigator.pushNamed(context, '/pagMinhasViagens');
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tela == 'historico') {
      rota = '/pagHistoricoViagem';
    } else if (widget.tela == 'visualizar') {
      rota = '/pagMinhasViagens';
    }

    var restanteOrcamento = widget.viagem.gastosPrevistos -
        (widget.transporte.totalGastosTransporte +
            widget.acomodacao.totalGastosAcomodacao);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 30.0, top: 5.0),
                child: TextFormField(
                  enabled: _edicao,
                  initialValue: widget.viagem.destino,
                  onSaved: (value) => formEdicao['destino'] = value!,
                  decoration: InputDecoration(
                      labelText: 'Destino',
                      focusColor: Colors.black,
                      labelStyle: TextStyle(fontSize: 20),
                      icon: Icon(Icons.location_on)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 30.0, top: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: widget.viagem.dataIda,
                        enabled: _edicao,
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskFormatterDate],
                        onSaved: (value) => formEdicao['dataIda'] = value!,
                        decoration: InputDecoration(
                            labelText: 'Data de ida',
                            labelStyle: TextStyle(fontSize: 20),
                            icon: Icon(Icons.date_range)),
                      ),
                    ),
                    SizedBox(width: 70.0),
                    Expanded(
                      child: TextFormField(
                        initialValue: widget.viagem.dataVolta,
                        enabled: _edicao,
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskFormatterDate],
                        onSaved: (value) => formEdicao['dataVolta'] = value!,
                        decoration: InputDecoration(
                            labelText: 'Data de Volta',
                            labelStyle: TextStyle(fontSize: 20),
                            icon: Icon(Icons.date_range_outlined)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 15.0, top: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: widget.viagem.horarioIda,
                        enabled: _edicao,
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskFormatterHour],
                        onSaved: (value) => formEdicao['horaIda'] = value!,
                        decoration: InputDecoration(
                            labelText: 'Hora de ida',
                            labelStyle: TextStyle(fontSize: 20),
                            icon: Icon(Icons.access_time)),
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      child: TextFormField(
                        initialValue: widget.viagem.horarioVolta,
                        enabled: _edicao,
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskFormatterHour],
                        onSaved: (value) => formEdicao['horaVolta'] = value!,
                        decoration: InputDecoration(
                            labelText: 'Horde volta',
                            labelStyle: TextStyle(fontSize: 20),
                            icon: Icon(Icons.access_time_sharp)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 15.0, top: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue:
                            widget.transporte.totalGastosTransporte.toString(),
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: 'Total gasto',
                            labelStyle: TextStyle(fontSize: 20),
                            icon: Icon(Icons.directions_car)),
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      child: ElevatedButton(
                        child: Text('Transporte'),
                        onPressed: () {
                          if (widget.tela == 'checkin' || _edicao == true) {
                            return null;
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditForm(
                                          editPage: 'Transporte',
                                          acomodacao: widget.acomodacao,
                                          transporte: widget.transporte,
                                          rota: rota,
                                        )));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 15.0, top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue:
                            widget.acomodacao.totalGastosAcomodacao.toString(),
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: 'Total gasto',
                            labelStyle: TextStyle(fontSize: 20),
                            icon: Icon(Icons.bedtime)),
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      child: ElevatedButton(
                        child: Text('Acomodação'),
                        onPressed: () {
                          if (widget.tela == 'checkin' || _edicao == true) {
                            return null;
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditForm(
                                          editPage: 'Acomodação',
                                          acomodacao: widget.acomodacao,
                                          transporte: widget.transporte,
                                          rota: rota,
                                        )));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 15.0, top: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: (widget.viagem.gastosPrevistos +
                                widget.viagem.gastosExtras)
                            .toString(),
                        enabled: _edicao,
                        keyboardType: TextInputType.number,
                        onSaved: (value) => formEdicao['gastos_previstos'] =
                            double.parse(value!),
                        decoration: InputDecoration(
                            labelText: 'Orçamento',
                            labelStyle: TextStyle(fontSize: 20),
                            icon: Icon(Icons.attach_money_rounded)),
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      child: TextFormField(
                        initialValue: (widget.transporte.totalGastosTransporte +
                                widget.acomodacao.totalGastosAcomodacao)
                            .toString(),
                        enabled: false,
                        decoration: InputDecoration(
                            labelText: 'Total gasto',
                            labelStyle: TextStyle(fontSize: 20),
                            icon: Icon(Icons.money_off_sharp)),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.tela == 'visualizar')
                Padding(
                  padding:
                      const EdgeInsets.only(left: 5.0, right: 10.0, top: 20.0),
                  child: Row(
                    children: [
                      SizedBox(width: 15),
                      if (_edicao == false)
                        Expanded(
                          child: FloatingActionButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              "Editar dados",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            backgroundColor: Colors.red,
                            onPressed: () {
                              setState(() {
                                _edicao = true;
                              });
                            },
                          ),
                        ),
                      Spacer(),
                      if (_edicao == false)
                        Expanded(
                          child: FloatingActionButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Text(
                              "Realizar check-in",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            backgroundColor: Colors.greenAccent,
                            onPressed: () {
                              viagens.makeChekIn(widget.viagem);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DespesasExtras(
                                            viagem: widget.viagem,
                                            restanteOrcamento:
                                                restanteOrcamento,
                                          )));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Check-in realizado com sucesso, Boa viagem!!')));
                            },
                          ),
                        ),
                      if (_edicao == true)
                        Expanded(
                          child: FloatingActionButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              "Salvar Edição",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            backgroundColor: Colors.greenAccent,
                            onPressed: () {
                              Navigator.pushNamed(context, '/pagMinhasViagens');
                              _saveForm();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Dados atualizados.')));
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              if (widget.tela == 'checkin')
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: 'Realizado',
                          enabled: _edicao,
                          decoration: InputDecoration(
                              labelText: ('Check-in'),
                              labelStyle: TextStyle(fontSize: 20),
                              icon: Icon(Icons.check_circle)),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Expanded(
                        child: FloatingActionButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            "Realizar check-out",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          backgroundColor: Colors.greenAccent,
                          onPressed: () {
                            _pesqSatisfacao();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Check-out realizado com sucesso!')));
                            viagens.makeChekOut(widget.viagem);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget.tela == 'historico')
                Padding(
                  padding:
                      const EdgeInsets.only(left: 25.0, right: 30.0, top: 30.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: 'Realizado',
                          enabled: _edicao,
                          decoration: InputDecoration(
                              labelText: 'Check-in',
                              labelStyle: TextStyle(fontSize: 20),
                              icon: Icon(Icons.date_range)),
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: TextFormField(
                          initialValue: 'Realizado',
                          enabled: _edicao,
                          decoration: InputDecoration(
                              labelText: 'Check-out',
                              labelStyle: TextStyle(fontSize: 20),
                              icon: Icon(Icons.date_range_outlined)),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
