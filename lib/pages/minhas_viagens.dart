import 'package:cost_trip/database/db_viagens.dart';
import 'package:cost_trip/views/viagem_chekin.dart';
import 'package:cost_trip/views/viagem_planejada.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MinhaViagem extends StatefulWidget {
  @override
  _MinhaViagemState createState() => _MinhaViagemState();
}

class _MinhaViagemState extends State<MinhaViagem> {
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

  final List<Widget> pags = [
    Container(
      child: (ViagemPlanejada()),
    ),
    Container(
      child: (ViagemCheckin()),
    )
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _refreshList(context),
      child: Scaffold(
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : pags[currentPage],
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.indigo,
              selectedItemColor: Colors.white,
              currentIndex: currentPage,
              items: [
                BottomNavigationBarItem(
                    label: "Planejadas", icon: Icon(Icons.tapas_rounded)),
                BottomNavigationBarItem(
                    label: "Check-In", icon: Icon(Icons.check_sharp)),
              ],
              onTap: (index) {
                setState(() {
                  currentPage = index;
                });
              })),
    );
  }
}
