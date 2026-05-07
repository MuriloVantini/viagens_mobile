import 'package:viagens_mobile/data/api/api_client.dart';
import 'package:viagens_mobile/domain/models/trip_purpose.dart';
import 'package:viagens_mobile/domain/models/trip_transport.dart';

class DomainsApi {
  DomainsApi(this._client);

  final ApiClient _client;

  Future<List<TripPurpose>> fetchFinalidades() async {
    final json = await _client.getJson('/dominios/finalidades');
    final list = json as List<dynamic>;
    return list.map((item) => tripPurposeFromApi(item as String)).whereType<TripPurpose>().toList();
  }

  Future<List<TripTransport>> fetchTransportes() async {
    final json = await _client.getJson('/dominios/transportes');
    final list = json as List<dynamic>;
    return list.map((item) => tripTransportFromApi(item as String)).whereType<TripTransport>().toList();
  }
}
