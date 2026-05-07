import 'package:viagens_mobile/domain/models/trip_purpose.dart';
import 'package:viagens_mobile/domain/models/trip_transport.dart';

abstract class IDomainsRepository {
  Future<List<TripPurpose>> fetchFinalidades();
  Future<List<TripTransport>> fetchTransportes();
}
