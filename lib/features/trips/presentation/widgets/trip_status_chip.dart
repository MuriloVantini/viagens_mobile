import 'package:flutter/material.dart';
import 'package:viagens_mobile/domain/models/trip_status.dart';

class TripStatusChip extends StatelessWidget {
  const TripStatusChip({super.key, required this.status});

  final TripStatus status;

  @override
  Widget build(BuildContext context) {
    final color = _colorForStatus(status, Theme.of(context).colorScheme);
    return Chip(
      label: Text(tripStatusLabel(status)),
      backgroundColor: color.withValues(alpha: 0.12),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.w600),
    );
  }

  Color _colorForStatus(TripStatus status, ColorScheme scheme) {
    switch (status) {
      case TripStatus.agendada:
        return scheme.primary;
      case TripStatus.emAndamento:
        return Colors.orange.shade700;
      case TripStatus.concluida:
        return Colors.green.shade700;
      case TripStatus.cancelada:
        return Colors.red.shade700;
    }
  }
}
