import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viagens_mobile/core/date_formatters.dart';
import 'package:viagens_mobile/domain/models/trip_purpose.dart';
import 'package:viagens_mobile/domain/models/trip_status.dart';
import 'package:viagens_mobile/domain/models/trip_transport.dart';
import 'package:viagens_mobile/features/trips/presentation/widgets/trip_status_chip.dart';
import 'package:viagens_mobile/features/trips/state/trips_controller.dart';

class TripDetailScreen extends StatefulWidget {
  const TripDetailScreen({super.key, required this.tripId});

  static const routeName = '/trips/detail';

  final int tripId;

  @override
  State<TripDetailScreen> createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  bool _isUpdating = false;

  Future<void> _updateStatus(TripStatus status) async {
    setState(() => _isUpdating = true);
    final controller = context.read<TripsController>();
    final updated = await controller.updateStatus(id: widget.tripId, status: status);
    if (mounted) {
      setState(() => _isUpdating = false);
      if (updated == null) {
        final message = controller.error ?? 'Falha ao atualizar status';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TripsController>(
      builder: (context, controller, _) {
        final trip = controller.findById(widget.tripId);
        if (trip == null) {
          return const Scaffold(body: Center(child: Text('Viagem nao encontrada')));
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Detalhe da viagem')),
          body: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _DetailRow(label: 'Destino', value: trip.destino),
              _DetailRow(label: 'Data ida', value: shortDate.format(trip.dataIda)),
              _DetailRow(label: 'Data volta', value: shortDate.format(trip.dataVolta)),
              _DetailRow(label: 'Finalidade', value: tripPurposeLabel(trip.finalidade)),
              _DetailRow(label: 'Transporte', value: tripTransportLabel(trip.transporte)),
              if (trip.observacoes != null && trip.observacoes!.isNotEmpty) _DetailRow(label: 'Observacoes', value: trip.observacoes!),
              _DetailRow(label: 'Status', value: tripStatusLabel(trip.status)),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: TripStatusChip(status: trip.status),
              ),
              const SizedBox(height: 24),
              _ActionButtons(status: trip.status, isUpdating: _isUpdating, onUpdate: _updateStatus),
            ],
          ),
        );
      },
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({required this.status, required this.isUpdating, required this.onUpdate});

  final TripStatus status;
  final bool isUpdating;
  final ValueChanged<TripStatus> onUpdate;

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons;
    switch (status) {
      case TripStatus.agendada:
        buttons = [
          ElevatedButton(onPressed: isUpdating ? null : () => onUpdate(TripStatus.emAndamento), child: const Text('Iniciar viagem')),
          TextButton(onPressed: isUpdating ? null : () => onUpdate(TripStatus.cancelada), child: const Text('Cancelar')),
        ];
        break;
      case TripStatus.emAndamento:
        buttons = [
          ElevatedButton(onPressed: isUpdating ? null : () => onUpdate(TripStatus.concluida), child: const Text('Concluir')),
          TextButton(onPressed: isUpdating ? null : () => onUpdate(TripStatus.cancelada), child: const Text('Cancelar')),
        ];
        break;
      case TripStatus.concluida:
      case TripStatus.cancelada:
        buttons = [];
        break;
    }

    if (buttons.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final button in buttons) ...[button, const SizedBox(height: 12)],
      ],
    );
  }
}
