import 'package:viagens_mobile/data/api/api_client.dart';
import 'package:viagens_mobile/data/trips/trips_models.dart';
import 'package:viagens_mobile/domain/models/trip_status.dart';

class TripsApi {
  TripsApi(this._client);

  final ApiClient _client;

  Future<List<TripDto>> fetchTrips() async {
    final json = await _client.getJson('/viagens');
    final list = json as List<dynamic>;
    return list.map((item) => TripDto.fromJson(item as Map<String, dynamic>)).toList();
  }

  Future<TripDto> createTrip(TripCreateRequest request) async {
    final json = await _client.postJson('/viagens', request.toJson());
    return TripDto.fromJson(json as Map<String, dynamic>);
  }

  Future<TripDto> updateStatus({required int id, required TripStatus status}) async {
    final json = await _client.patchJson('/viagens/$id/status', {'status': tripStatusToApi(status)});
    return TripDto.fromJson(json as Map<String, dynamic>);
  }
}
