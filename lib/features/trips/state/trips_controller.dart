import 'package:flutter/foundation.dart';
import 'package:viagens_mobile/core/load_state.dart';
import 'package:viagens_mobile/data/api/api_exception.dart';
import 'package:viagens_mobile/domain/models/trip.dart';
import 'package:viagens_mobile/domain/models/trip_create_input.dart';
import 'package:viagens_mobile/domain/models/trip_status.dart';
import 'package:viagens_mobile/domain/contracts/trips_repository.dart';

class TripsController extends ChangeNotifier {
  TripsController({required this.tripsRepository});

  final ITripsRepository tripsRepository;

  LoadState _state = LoadState.idle;
  String? _error;
  List<Trip> _trips = [];

  LoadState get state => _state;
  String? get error => _error;
  List<Trip> get trips => List.unmodifiable(_trips);

  Future<void> loadTrips() async {
    _state = LoadState.loading;
    _error = null;
    notifyListeners();
    try {
      _trips = await tripsRepository.fetchTrips();
      _state = LoadState.success;
    } catch (error) {
      _state = LoadState.error;
      if (error is ApiException) {
        _error = error.message;
      } else {
        _error = 'Falha ao carregar viagens';
      }
    } finally {
      notifyListeners();
    }
  }

  Future<bool> createTrip(TripCreateInput input) async {
    try {
      await tripsRepository.createTrip(input);
      await loadTrips();
      return true;
    } catch (error) {
      if (error is ApiException) {
        _error = error.message;
      } else {
        _error = 'Falha ao criar viagem';
      }
      notifyListeners();
      return false;
    }
  }

  Future<Trip?> updateStatus({required int id, required TripStatus status}) async {
    try {
      final updated = await tripsRepository.updateStatus(id: id, status: status);
      final index = _trips.indexWhere((trip) => trip.id == id);
      if (index >= 0) {
        _trips[index] = updated;
      }
      notifyListeners();
      return updated;
    } catch (error) {
      if (error is ApiException) {
        _error = error.message;
      } else {
        _error = 'Falha ao atualizar status';
      }
      notifyListeners();
      return null;
    }
  }

  Trip? findById(int id) {
    for (final trip in _trips) {
      if (trip.id == id) {
        return trip;
      }
    }
    return null;
  }
}
