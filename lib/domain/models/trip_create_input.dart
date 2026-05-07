import 'package:viagens_mobile/domain/models/trip_purpose.dart';
import 'package:viagens_mobile/domain/models/trip_transport.dart';

class TripCreateInput {
  TripCreateInput({
    required this.destino,
    required this.dataIda,
    required this.dataVolta,
    required this.finalidade,
    required this.transporte,
    this.observacoes,
  });

  final String destino;
  final DateTime dataIda;
  final DateTime dataVolta;
  final TripPurpose finalidade;
  final TripTransport transporte;
  final String? observacoes;
}
