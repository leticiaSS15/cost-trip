import 'package:cost_trip/database/db_viagens.dart';
import 'package:cost_trip/provider/provider_historico.dart';
import 'package:cost_trip/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoricoViagens extends StatefulWidget {
  @override
  _HistoricoViagensState createState() => _HistoricoViagensState();
}

class _HistoricoViagensState extends State<HistoricoViagens> {
  bool _isLoading = true;

  Future<void> _refreshList(BuildContext context) {
    return Provider.of<DbViagens>(context, listen: false).loadViagem();
  }

  void initState() {
    super.initState();
    Provider.of<DbViagens>(context, listen: false).loadViagem().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshList(context),
      child: Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: <Widget>[
                  AppBarViagem(
                    namePage: 'Histórico de Viagens',
                    tamanhoFonte: 20.0,
                    exibirReturn: true,
                    exibirPerfil: false,
                    rota: '/pagHome',
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 200.0, left: 5, right: 5),
                    child: ProviderHistorico(rota: 'historico', checkIN: true),
                  ),
                ],
              ),
      ),
    );
  }
}
