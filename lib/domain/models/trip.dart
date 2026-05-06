import 'package:viagens_mobile/domain/models/trip_status.dart';

class Trip {
  Trip({
    required this.id,
    required this.destino,
    required this.dataIda,
    required this.dataVolta,
    required this.finalidade,
    required this.transporte,
    required this.status,
    required this.criadoEm,
    this.observacoes,
  });

  final int id;
  final String destino;
  final DateTime dataIda;
  final DateTime dataVolta;
  final String finalidade;
  final String transporte;
  final String? observacoes;
  final TripStatus status;
  final DateTime criadoEm;
}
