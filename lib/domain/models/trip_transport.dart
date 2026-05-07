import 'package:viagens_mobile/core/string_normalizer.dart';

enum TripTransport {
  carroProprio,
  carroEmpresa,
  aereo,
  onibus,
}

TripTransport tripTransportFromApi(String value) {
  final normalized = normalize(value);
  switch (normalized) {
    case 'carro_proprio':
      return TripTransport.carroProprio;
    case 'carro_da_empresa':
    case 'carro_empresa':
      return TripTransport.carroEmpresa;
    case 'aereo':
      return TripTransport.aereo;
    default:
      return TripTransport.onibus;
  }
}

String tripTransportToApi(TripTransport transport) {
  return const {
    TripTransport.carroProprio: 'CARRO_PROPRIO',
    TripTransport.carroEmpresa: 'CARRO_EMPRESA',
    TripTransport.aereo: 'AEREO',
    TripTransport.onibus: 'ONIBUS',
  }[transport]!;
}

String tripTransportLabel(TripTransport transport) {
  return const {
    TripTransport.carroProprio: 'Carro proprio',
    TripTransport.carroEmpresa: 'Carro da empresa',
    TripTransport.aereo: 'Aereo',
    TripTransport.onibus: 'Onibus',
  }[transport]!;
}
