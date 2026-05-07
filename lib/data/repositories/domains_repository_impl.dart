import 'package:viagens_mobile/data/domains/domains_api.dart';
import 'package:viagens_mobile/domain/contracts/domains_repository.dart';
import 'package:viagens_mobile/domain/models/trip_purpose.dart';
import 'package:viagens_mobile/domain/models/trip_transport.dart';

class DomainsRepositoryImpl implements IDomainsRepository {
  DomainsRepositoryImpl({required this.domainsApi});

  final DomainsApi domainsApi;

  @override
  Future<List<TripPurpose>> fetchFinalidades() async {
    return domainsApi.fetchFinalidades();
  }

  @override
  Future<List<TripTransport>> fetchTransportes() async {
    return domainsApi.fetchTransportes();
  }
}
