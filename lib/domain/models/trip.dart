import 'package:viagens_mobile/domain/models/trip_purpose.dart';
import 'package:viagens_mobile/domain/models/trip_status.dart';
import 'package:viagens_mobile/domain/models/trip_transport.dart';

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
  final TripPurpose finalidade;
  final TripTransport transporte;
  final String? observacoes;
  final TripStatus status;
  final DateTime criadoEm;
}
