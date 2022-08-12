import 'package:cost_trip/database/db_viagens.dart';
import 'package:cost_trip/modelo/viagem.dart';
import 'package:flutter/material.dart';

class DespesasViagem extends StatefulWidget {
  final Viagem viagem;
  final double restanteOrcamento;

  const DespesasViagem({Key? key, required this.viagem, required this.restanteOrcamento}) : super(key: key);

  @override
  _DespesasViagemState createState() => _DespesasViagemState();
}

class _DespesasViagemState extends State<DespesasViagem> {
  final _form = GlobalKey<FormState>();
  final DbViagens viagens = DbViagens();
  double medicamentos = 0.0;
  double vestuario = 0.0;
  double acomodProvi = 0.0;
  double itensPessoais = 0.0;
  double outros = 0.0;
  double totalExtras = 0;

  _saveForm() {
    _form.currentState!.save();
    totalExtras = medicamentos + vestuario + acomodProvi + itensPessoais + outros;
    viagens.addGastosExtras(widget.viagem, totalExtras);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.only(top: 120.0, left: 10.0, right: 30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Orçamento restante ${widget.restanteOrcamento}'),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onSaved: (value) => medicamentos = double.parse(value!),
                  decoration: InputDecoration(
                      labelText: ('Gasto com medicamento'),
                      icon: Icon(Icons.local_hospital)),
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  onSaved: (value) => vestuario = double.parse(value!),
                  decoration: InputDecoration(
                      labelText: ('Gasto com vestuário'),
                      icon: Icon(Icons.checkroom_rounded)),
                ),
                SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.number,
                  onSaved: (value) => acomodProvi = double.parse(value!),
                  decoration: InputDecoration(
                      labelText: ('Gasto com acomodação provisória'),
                      icon: Icon(Icons.hourglass_bottom_sharp)),
                ),
                SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.number,
                  onSaved: (value) => itensPessoais = double.parse(value!),
                  decoration: InputDecoration(
                      labelText: ('Gasto com itens pessoais esquecidos'),
                      icon: Icon(Icons.add_shopping_cart)),
                ),
                SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.go,
                  keyboardType: TextInputType.number,
                  onSaved: (value) => outros = double.parse(value!),
                  decoration: InputDecoration(
                      labelText: ('Outros'),
                      icon: Icon(Icons.request_quote_outlined)),
                ),
                SizedBox(height: 40),
                ElevatedButton(onPressed: () {
                  _saveForm();
                  Navigator.pushNamed(context, '/pagMinhasViagens');
                }, child: Text('Salvar gastos'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
