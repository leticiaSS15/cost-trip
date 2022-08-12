import 'package:cost_trip/auth/db_auth.dart';
import 'package:cost_trip/auth/login_page.dart';
import 'package:cost_trip/database/db_acomodacao.dart';
import 'package:cost_trip/database/db_transporte.dart';
import 'package:cost_trip/modelo/acomodacao.dart';
import 'package:cost_trip/modelo/transporte.dart';
import 'package:cost_trip/modelo/viagem.dart';
import 'package:cost_trip/pages/despesas_extras.dart';
import 'package:cost_trip/pages/home_page.dart';
import 'package:cost_trip/pages/historico_viagens.dart';
import 'package:cost_trip/pages/minhas_viagens.dart';
import 'package:cost_trip/pages/nova_viagem.dart';
import 'package:cost_trip/pages/roteiro_viagem.dart';
import 'package:cost_trip/pages/selecao_acomodacao_viagem.dart';
import 'package:cost_trip/pages/selecao_transporte_viagem.dart';
import 'package:cost_trip/pages/visualizar_viagem.dart';
import 'package:cost_trip/database/db_viagens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth/usuario_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late final Transporte transporte;
  late final Viagem viajem;
  late final Acomodacao acomodacao;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DbAuth()),
        ChangeNotifierProvider(create: (_) => DbViagens()),
        ChangeNotifierProvider(create: (_) => DbAcomodacao()),
        ChangeNotifierProvider(create: (_) => DbTransporte()),
      ],
      child: MaterialApp(
        title: 'Cost Trip',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: '/',
        routes: {
          '/pagRoteiro': (context) => RoteiroViagem(
              formDataViajem: {},
              transporte: transporte,
              margemGastos: 0.0,
              acomodacao: acomodacao),
          '/login': (context) => LoginPage(),
          '/pagHome': (context) => HomePage(),
          '/pagMinhasViagens': (context) => MinhaViagem(),
          '/pagHistoricoViagem': (context) => HistoricoViagens(),
          '/pagUsuário': (context) => UsuarioPage(),
          '/pagDespesasExtras': (context) => DespesasExtras(
                viagem: viajem,
                restanteOrcamento: 0.0,
              ),
          '/pagNovaViagem': (context) => NovaViagem(),
          '/pagTransporteViagem': (context) => TransporteViagem(
                formDataViajem: {},
              ),
          '/pagAcomodacaoViagem': (context) => AcomodacaoViagem(
                formDataViajem: {},
                transporte: transporte,
                margemGastos: 0.0,
              ),
          '/pagVisualizarViagem': (context) => VisualizarViagem(
                tela: '',
                viagem: viajem,
                acomodacao: acomodacao,
                transporte: transporte,
              ),
        },
        home: HomePage(),
      ),
    );
  }
}
