import 'package:cost_trip/modelo/acomodacao.dart';
import 'package:cost_trip/modelo/transporte.dart';
import 'package:cost_trip/pages/roteiro_viagem.dart';
import 'package:flutter/material.dart';

class AcomodacaoForm extends StatefulWidget {
  final Map<String, Object> formDataViajem;
  final Transporte transporte;
  final double margemGastos;

  const AcomodacaoForm(
      {Key? key,
      required this.formDataViajem,
      required this.transporte,
      required this.margemGastos})
      : super(key: key);

  @override
  _AcomodacaoFormState createState() => _AcomodacaoFormState();
}

class _AcomodacaoFormState extends State<AcomodacaoForm> {
  final _form = GlobalKey<FormState>();
  double custoAcomodacao = 0.0;
  double custoEstacionamento = 0.0;
  double seguroLocal = 0.0;
  double margemGastos = 0.0;
  int _currentStep = 0;
  late Acomodacao newAcomodacao;

  void _saveForm() {
    _form.currentState!.save();
    newAcomodacao = Acomodacao(
      idAcomodacao: '',
      custoAcomodacao: custoAcomodacao,
      custoEstacionamento: custoEstacionamento,
      seguroLocal: seguroLocal,
      totalGastosAcomodacao:
          (custoAcomodacao + custoEstacionamento + seguroLocal),
    );
    margemGastos =
        margemGastos - (custoAcomodacao + custoEstacionamento + seguroLocal);
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
        child: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 120.0, top: 10.0),
            child: Text("Saldo disponível ${margemGastos.toString()}",
                style: TextStyle(fontSize: 15)),
          ),
          SizedBox(width: 50),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Stepper(
              steps: _mySteps(),
              currentStep: this._currentStep,
              onStepContinue: () {
                setState(() {
                  if (this._currentStep < this._mySteps().length - 1) {
                    this._currentStep = this._currentStep + 1;
                  } else {
                    _saveForm();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RoteiroViagem(
                                formDataViajem: widget.formDataViajem,
                                transporte: widget.transporte,
                                margemGastos: margemGastos,
                                acomodacao: newAcomodacao)));
                  }
                });
              },
              onStepCancel: () {
                Navigator.pop(context, '/pagTransporteViagem');
              },
            ),
          ),
        ]),
      ),
    );
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        title: Text('Acomodação'),
        content: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onChanged: (value) => custoAcomodacao = double.parse(value),
                decoration: InputDecoration(
                    labelText: ('Custos da acomodação'),
                    icon: Icon(Icons.bedtime)),
              ),
              SizedBox(height: 10),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onChanged: (value) => custoEstacionamento = double.parse(value),
                decoration: InputDecoration(
                    labelText: ('Custos de estacionamento'),
                    icon: Icon(Icons.car_repair)),
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.go,
                onChanged: (value) => seguroLocal = double.parse(value),
                decoration: InputDecoration(
                    labelText: ('Seguro do local'),
                    icon: Icon(Icons.local_hospital)),
              ),
            ],
          ),
        ),
        isActive: _currentStep >= 1,
      ),
    ];
    return _steps;
  }
}
