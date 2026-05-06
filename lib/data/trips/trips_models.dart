import 'package:viagens_mobile/domain/models/trip.dart';
import 'package:viagens_mobile/domain/models/trip_create_input.dart';
import 'package:viagens_mobile/domain/models/trip_status.dart';

class TripDto {
  TripDto({
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

  factory TripDto.fromJson(Map<String, dynamic> json) {
    return TripDto(
      id: json['id'] as int,
      destino: json['destino'] as String,
      dataIda: DateTime.parse(json['dataIda'] as String),
      dataVolta: DateTime.parse(json['dataVolta'] as String),
      finalidade: json['finalidade'] as String,
      transporte: json['transporte'] as String,
      observacoes: json['observacoes'] as String?,
      status: tripStatusFromApi(json['status'] as String),
      criadoEm: DateTime.parse(json['criadoEm'] as String),
    );
  }

  Trip toDomain() {
    return Trip(
      id: id,
      destino: destino,
      dataIda: dataIda,
      dataVolta: dataVolta,
      finalidade: finalidade,
      transporte: transporte,
      observacoes: observacoes,
      status: status,
      criadoEm: criadoEm,
    );
  }
}

class TripCreateRequest {
  TripCreateRequest({
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
  final String finalidade;
  final String transporte;
  final String? observacoes;

  factory TripCreateRequest.fromInput(TripCreateInput input) {
    return TripCreateRequest(
      destino: input.destino,
      dataIda: input.dataIda,
      dataVolta: input.dataVolta,
      finalidade: input.finalidade,
      transporte: input.transporte,
      observacoes: input.observacoes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'destino': destino,
      'dataIda': _formatDate(dataIda),
      'dataVolta': _formatDate(dataVolta),
      'finalidade': finalidade,
      'transporte': transporte,
      if (observacoes != null && observacoes!.trim().isNotEmpty)
        'observacoes': observacoes,
    };
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}
