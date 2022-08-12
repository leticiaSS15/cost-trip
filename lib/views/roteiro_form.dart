import 'package:cost_trip/modelo/acomodacao.dart';
import 'package:cost_trip/modelo/transporte.dart';
import 'package:cost_trip/servico/servico_viagens.dart';
import 'package:flutter/material.dart';

class RoteiroForm extends StatefulWidget {
  final Map<String, Object> formDataViajem;
  final Transporte transporte;
  final Acomodacao acomodacao;
  final double margemGastos;

  const RoteiroForm(
      {Key? key,
      required this.formDataViajem,
      required this.transporte,
      required this.acomodacao,
      required this.margemGastos})
      : super(key: key);

  @override
  _RoteiroFormState createState() => _RoteiroFormState();
}

class _RoteiroFormState extends State<RoteiroForm> {
  final _form = GlobalKey<FormState>();
  ServicoViagem servico = ServicoViagem();
  double margemGastos = 0.0;
  String roteiro = '';

  _saveForm() {
    _form.currentState!.save();
    servico.salvarViagem(
        widget.formDataViajem, widget.transporte, widget.acomodacao, roteiro);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.margemGastos > 0) {
      margemGastos = widget.margemGastos;
    }
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 120.0, right: 30.0),
                  child: Text("Saldo disponível ${margemGastos.toString()}",
                      style: TextStyle(fontSize: 15)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, right: 35.0, left: 35.0),
                  child: Text(
                    "Organize um roteiro de viagem, esta prática ajuda a manter um planejamento de gastos.",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, right: 35.0, left: 35.0),
                  child: TextFormField(
                    onSaved: (value) => roteiro = value!,
                    maxLines: 5,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25.0, right: 25.0, top: 100.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Text('Voltar'),
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Spacer(),
                      Expanded(
                        child: ElevatedButton(
                          child: Text('Finalizar'),
                          onPressed: () {
                            _saveForm();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Viagem cadastrada com sucesso!')));
                            Navigator.pushNamed(context, '/pagHome');
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
