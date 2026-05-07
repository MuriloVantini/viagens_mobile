import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viagens_mobile/app/routes.dart';
import 'package:viagens_mobile/core/load_state.dart';
import 'package:viagens_mobile/domain/models/trip.dart';
import 'package:viagens_mobile/features/auth/state/auth_controller.dart';
import 'package:viagens_mobile/features/trips/presentation/trip_form_screen.dart';
import 'package:viagens_mobile/features/trips/presentation/trip_detail_screen.dart';
import 'package:viagens_mobile/features/trips/presentation/widgets/trip_list_tile.dart';
import 'package:viagens_mobile/features/trips/state/trips_controller.dart';

class TripsListScreen extends StatefulWidget {
  const TripsListScreen({super.key});

  static const routeName = '/trips';

  @override
  State<TripsListScreen> createState() => _TripsListScreenState();
}

class _TripsListScreenState extends State<TripsListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      context.read<TripsController>().loadTrips();
    });
  }

  Future<void> _refresh() async {
    await context.read<TripsController>().loadTrips();
  }

  Future<void> _logout() async {
    await context.read<AuthController>().logout();
    if (mounted) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  void _openNewTrip() {
    Navigator.of(context).pushNamed(TripFormScreen.routeName);
  }

  void _openDetail(Trip trip) {
    Navigator.of(context).pushNamed(TripDetailScreen.routeName, arguments: TripDetailArgs(trip.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Viagens'),
        actions: [IconButton(onPressed: _logout, icon: const Icon(Icons.logout), tooltip: 'Sair')],
      ),
      floatingActionButton: FloatingActionButton(onPressed: _openNewTrip, child: const Icon(Icons.add)),
      body: Consumer<TripsController>(
        builder: (context, controller, _) {
          if (controller.state == LoadState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.state == LoadState.error) {
            return _ErrorState(message: controller.error ?? 'Erro ao carregar viagens', onRetry: controller.loadTrips);
          }
          if (controller.trips.isEmpty) {
            return _EmptyState(onCreate: _openNewTrip);
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: controller.trips.length,
              itemBuilder: (context, index) {
                final trip = controller.trips[index];
                return TripListTile(trip: trip, onTap: () => _openDetail(trip));
              },
              separatorBuilder: (_, _) => const SizedBox(height: 12),
            ),
          );
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Nenhuma viagem encontrada'),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: onCreate, child: const Text('Nova viagem')),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: onRetry, child: const Text('Tentar novamente')),
          ],
        ),
      ),
    );
  }
}
