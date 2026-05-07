import 'package:viagens_mobile/core/string_normalizer.dart';

enum TripPurpose {
  visitaTecnica,
  reuniao,
  treinamento,
  entrega,
  outro,
}

TripPurpose tripPurposeFromApi(String value) {
  final normalized = normalize(value);
  switch (normalized) {
    case 'visita_tecnica':
      return TripPurpose.visitaTecnica;
    case 'reuniao':
      return TripPurpose.reuniao;
    case 'treinamento':
      return TripPurpose.treinamento;
    case 'entrega':
      return TripPurpose.entrega;
    default:
      return TripPurpose.outro;
  }
}

String tripPurposeToApi(TripPurpose purpose) {
  return const {
    TripPurpose.visitaTecnica: 'VISITA_TECNICA',
    TripPurpose.reuniao: 'REUNIAO',
    TripPurpose.treinamento: 'TREINAMENTO',
    TripPurpose.entrega: 'ENTREGA',
    TripPurpose.outro: 'OUTRO',
  }[purpose]!;
}

String tripPurposeLabel(TripPurpose purpose) {
  return const {
    TripPurpose.visitaTecnica: 'Visita tecnica',
    TripPurpose.reuniao: 'Reuniao',
    TripPurpose.treinamento: 'Treinamento',
    TripPurpose.entrega: 'Entrega',
    TripPurpose.outro: 'Outro',
  }[purpose]!;
}