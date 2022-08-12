class Transporte {
  final String idTransporte;
  final double custoPassagem;
  final double custoBagagem;
  final double seguroViagem;
  final double totalGastosTransporte;

  Transporte(
      {required this.idTransporte,
      required this.custoPassagem,
      required this.custoBagagem,
      required this.seguroViagem,
      required this.totalGastosTransporte});
}
