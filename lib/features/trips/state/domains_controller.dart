import 'package:flutter/foundation.dart';
import 'package:viagens_mobile/core/load_state.dart';
import 'package:viagens_mobile/data/api/api_exception.dart';
import 'package:viagens_mobile/domain/contracts/domains_repository.dart';

class DomainsController extends ChangeNotifier {
  DomainsController({required this.domainsRepository});

  final IDomainsRepository domainsRepository;

  LoadState _state = LoadState.idle;
  String? _error;
  List<String> _finalidades = [];
  List<String> _transportes = [];

  LoadState get state => _state;
  String? get error => _error;
  List<String> get finalidades => List.unmodifiable(_finalidades);
  List<String> get transportes => List.unmodifiable(_transportes);

  Future<void> load() async {
    if (_state == LoadState.loading || _state == LoadState.success) {
      return;
    }
    _state = LoadState.loading;
    _error = null;
    notifyListeners();
    try {
      final results = await Future.wait([
        domainsRepository.fetchFinalidades(),
        domainsRepository.fetchTransportes(),
      ]);
      _finalidades = results[0];
      _transportes = results[1];
      _state = LoadState.success;
    } catch (error) {
      _state = LoadState.error;
      if (error is ApiException) {
        _error = error.message;
      } else {
        _error = 'Falha ao carregar dominios';
      }
    } finally {
      notifyListeners();
    }
  }
}
