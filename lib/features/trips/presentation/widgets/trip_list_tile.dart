import 'package:flutter/material.dart';
import 'package:viagens_mobile/core/date_formatters.dart';
import 'package:viagens_mobile/domain/models/trip.dart';
import 'package:viagens_mobile/domain/models/trip_transport.dart';
import 'package:viagens_mobile/features/trips/presentation/widgets/trip_status_chip.dart';

class TripListTile extends StatelessWidget {
  final Trip trip;
  final VoidCallback onTap;
  const TripListTile({super.key, required this.trip, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(tripTransportIcon(trip.transporte)),
      onTap: onTap,
      tileColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(trip.destino),
      subtitle: Text(
        '${shortDate.format(trip.dataIda)} - '
        '${shortDate.format(trip.dataVolta)}',
      ),
      trailing: TripStatusChip(status: trip.status),
    );
  }
}
