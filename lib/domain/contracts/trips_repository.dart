import 'package:viagens_mobile/domain/models/trip.dart';
import 'package:viagens_mobile/domain/models/trip_create_input.dart';
import 'package:viagens_mobile/domain/models/trip_status.dart';

abstract class ITripsRepository {
  Future<List<Trip>> fetchTrips();
  Future<Trip> createTrip(TripCreateInput input);
  Future<Trip> updateStatus({required int id, required TripStatus status});
}
