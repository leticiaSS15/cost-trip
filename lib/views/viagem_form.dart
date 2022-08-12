import 'package:cost_trip/pages/selecao_transporte_viagem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NovaViagemForm extends StatefulWidget {
  @override
  _NovaViagemFormState createState() => _NovaViagemFormState();
}

class _NovaViagemFormState extends State<NovaViagemForm> {
  DateTime dataIda = DateTime.now();
  DateTime dataVolta = DateTime.now().add(Duration(days: 7));
  var horaIda = TimeOfDay.now();
  var horaVolta = TimeOfDay.now();
  final _form = GlobalKey<FormState>();
  final _formDataViajem = Map<String, Object>();
  int _currentStep = 0;

  _showDatePickerIda() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2050),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        dataIda = pickedDate;
        _formDataViajem['dataIda'] = DateFormat('dd/MM/y').format(dataIda);
      });
    });
  }

  _showDatePickerVolta() {
    showDatePicker(
      context: context,
      initialDate: dataIda.add(Duration(days: 7)),
      firstDate: DateTime(2021),
      lastDate: DateTime(2050),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        dataVolta = pickedDate;
        _formDataViajem['dataVolta'] = DateFormat('dd/MM/y').format(dataVolta);
      });
    });
  }

  _selectTimeIda() {
    showTimePicker(
      context: context,
      initialTime: horaIda,
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        horaIda = pickedTime;
        String _hora = horaIda.hour.toString();
        String _min = horaIda.minute.toString();
        _formDataViajem['horaIda'] = _hora + ':' + _min;
      });
    });
  }

  _selectTimeVolta() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      setState(() {
        horaVolta = pickedTime;
        String _hora = horaVolta.hour.toString();
        String _min = horaVolta.minute.toString();
        _formDataViajem['horaVolta'] = _hora + ':' + _min;
      });
    });
  }

  void dialogConfirmarSalvar() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Registro salvo com sucesso!'),
            ));
  }

  _saveForm() {
    _form.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: _form,
        child: Stepper(
          steps: _mySteps(),
          currentStep: this._currentStep,
          onStepContinue: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            setState(() {
              if (this._currentStep < this._mySteps().length - 1) {
                this._currentStep = this._currentStep + 1;
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransporteViagem(
                              formDataViajem: _formDataViajem,
                            )));
                _saveForm();
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (this._currentStep > 0) {
                this._currentStep = this._currentStep - 1;
              } else {
                this._currentStep = 0;
                Navigator.pop(context);
              }
            });
          },
        ),
      ),
    );
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        title: Text('Teto de gastos'),
        content: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 20.0),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            onSaved: (value) =>
                _formDataViajem['gastos_previstos'] = double.parse(value!),
            decoration: InputDecoration(icon: Icon(Icons.attach_money_sharp)),
          ),
        ),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text('Destino'),
        content: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 20.0),
          child: TextFormField(
            textInputAction: TextInputAction.go,
            onSaved: (value) => _formDataViajem['destino'] = value!,
            decoration: InputDecoration(icon: Icon(Icons.map_outlined)),
          ),
        ),
        isActive: _currentStep >= 2,
      ),
      Step(
        title: Text('Data de ida'),
        content: ElevatedButton(
            onPressed: _showDatePickerIda,
            child: Text(
              'Data de ida ${DateFormat('dd/MM/y').format(dataIda)}',
            )),
        isActive: _currentStep >= 3,
      ),
      Step(
        title: Text('Data de Volta'),
        content: ElevatedButton(
            onPressed: _showDatePickerVolta,
            child: Text(
              'Data de volta ${DateFormat('dd/MM/y').format(dataVolta)}',
            )),
        isActive: _currentStep >= 4,
      ),
      Step(
        title: Text('Horário de ida'),
        content: ElevatedButton(
            onPressed: _selectTimeIda,
            child: Text('Hora de saída ${horaIda.format(context)}')),
        isActive: _currentStep >= 5,
      ),
      Step(
        title: Text('Horário de volta'),
        content: ElevatedButton(
          onPressed: _selectTimeVolta,
          child: Text('Hora de volta ${horaVolta.format(context)}'),
        ),
        isActive: _currentStep >= 6,
      ),
    ];
    return _steps;
  }
}
