import 'package:cost_trip/modelo/viagem.dart';
import 'package:cost_trip/servico/servico_acomodacao_transporte.dart';
import 'package:cost_trip/servico/servico_viagens.dart';
import 'package:cost_trip/views/visualizar_roteiro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardViewViagem extends StatefulWidget {
  final String rota;

  const CardViewViagem({Key? key, required this.rota}) : super(key: key);

  @override
  _CardViewViagemState createState() => _CardViewViagemState();
}

class _CardViewViagemState extends State<CardViewViagem> {
  final ServicoViagem _servicoViagem = ServicoViagem();

  @override
  Widget build(BuildContext context) {
    final Viagem viagem = Provider.of<Viagem>(context, listen: false);
    return Dismissible(
      key: ValueKey(viagem.idViagem),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white, size: 40),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10.0),
        margin: EdgeInsets.all(5.0),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Excluir registro'),
                  content: Text('Deseja excluir o registro?'),
                  actions: [
                    ElevatedButton(
                      child: Text('Não'),
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                    ),
                    ElevatedButton(
                      child: Text('Sim'),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Viagem excluída com sucesso!')));
                        Navigator.of(ctx).pop(true);
                      },
                    )
                  ],
                ));
      },
      onDismissed: (_) {
        _servicoViagem.deletarViagem(viagem, context);
      },
      child: Card(
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                  child: Row(children: <Widget>[
                    Text('DESTINO'),
                    Spacer(),
                    Text('DATA DE IDA:'),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "${viagem.destino}",
                        style: new TextStyle(fontSize: 16.0),
                      ),
                      Spacer(),
                      Text("${viagem.dataIda}"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ServicoAcoTrans(tela: widget.rota, viagem: viagem)));
          },
          onLongPress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewRoteiro(viagem: viagem)));
          },
        ),
      ),
    );
  }
}
