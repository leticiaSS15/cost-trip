import 'package:cost_trip/modelo/acomodacao.dart';
import 'package:cost_trip/modelo/transporte.dart';
import 'package:cost_trip/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class EditForm extends StatefulWidget {
  final String editPage;
  final Acomodacao acomodacao;
  final Transporte transporte;
  final String rota;

  const EditForm(
      {Key? key,
      required this.editPage,
      required this.acomodacao,
      required this.transporte,
      required this.rota})
      : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  final _form = GlobalKey<FormState>();
  double custoPassagem = 0.0;
  double seguroViagem = 0.0;
  double custoBagagem = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: _form,
        child: Stack(children: <Widget>[
          AppBarViagem(
            namePage: widget.editPage,
            tamanhoFonte: 25,
            exibirReturn: true,
            exibirPerfil: false,
            rota: widget.rota,
          ),
          if (widget.editPage == 'Transporte')
            Padding(
              padding:
                  const EdgeInsets.only(top: 150.0, left: 20.0, right: 50.0),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.transporte.custoPassagem.toString(),
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onSaved: (value) => custoPassagem = double.parse(value!),
                    decoration: InputDecoration(
                        labelText: ('Custos de passagem'),
                        icon: Icon(Icons.monetization_on)),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: widget.transporte.custoBagagem.toString(),
                    enabled: false,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onSaved: (value) => custoBagagem = double.parse(value!),
                    decoration: InputDecoration(
                        labelText: ('Custos de bagagem'),
                        icon: Icon(Icons.shopping_bag_rounded)),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: widget.transporte.seguroViagem.toString(),
                    enabled: false,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.number,
                    onSaved: (value) => seguroViagem = double.parse(value!),
                    decoration: InputDecoration(
                        labelText: ('Seguro viajem'),
                        icon: Icon(Icons.local_hospital)),
                  ),
                ],
              ),
            ),
          if (widget.editPage == 'Acomodação')
            Padding(
              padding:
                  const EdgeInsets.only(top: 150.0, left: 20.0, right: 50.0),
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.acomodacao.custoAcomodacao.toString(),
                    enabled: false,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onSaved: (value) => custoPassagem = double.parse(value!),
                    decoration: InputDecoration(
                        labelText: ('Custos de acomodação'),
                        icon: Icon(Icons.monetization_on)),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue:
                        widget.acomodacao.custoEstacionamento.toString(),
                    enabled: false,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onSaved: (value) => custoBagagem = double.parse(value!),
                    decoration: InputDecoration(
                        labelText: ('Custos de estacionamento'),
                        icon: Icon(Icons.directions_car)),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: widget.acomodacao.seguroLocal.toString(),
                    enabled: false,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.number,
                    onSaved: (value) => seguroViagem = double.parse(value!),
                    decoration: InputDecoration(
                        labelText: ('Seguro local'),
                        icon: Icon(Icons.local_hospital)),
                  ),
                ],
              ),
            ),
        ]),
      ),
    );
  }
}
