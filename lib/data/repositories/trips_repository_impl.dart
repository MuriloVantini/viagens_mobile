import 'package:viagens_mobile/data/trips/trips_api.dart';
import 'package:viagens_mobile/data/trips/trips_models.dart';
import 'package:viagens_mobile/domain/models/trip.dart';
import 'package:viagens_mobile/domain/models/trip_create_input.dart';
import 'package:viagens_mobile/domain/models/trip_status.dart';
import 'package:viagens_mobile/domain/contracts/trips_repository.dart';

class TripsRepositoryImpl implements ITripsRepository {
  TripsRepositoryImpl({required this.tripsApi});

  final TripsApi tripsApi;

  @override
  Future<List<Trip>> fetchTrips() async {
    final list = await tripsApi.fetchTrips();
    return list.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<Trip> createTrip(TripCreateInput input) async {
    final request = TripCreateRequest.fromInput(input);
    final dto = await tripsApi.createTrip(request);
    return dto.toDomain();
  }

  @override
  Future<Trip> updateStatus({required int id, required TripStatus status}) async {
    final dto = await tripsApi.updateStatus(id: id, status: status);
    return dto.toDomain();
  }
}
