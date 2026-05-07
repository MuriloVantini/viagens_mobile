import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viagens_mobile/core/date_formatters.dart';
import 'package:viagens_mobile/core/load_state.dart';
import 'package:viagens_mobile/domain/models/trip_create_input.dart';
import 'package:viagens_mobile/domain/models/trip_purpose.dart';
import 'package:viagens_mobile/domain/models/trip_transport.dart';
import 'package:viagens_mobile/features/trips/state/domains_controller.dart';
import 'package:viagens_mobile/features/trips/state/trips_controller.dart';

class TripFormScreen extends StatefulWidget {
  const TripFormScreen({super.key});

  static const routeName = '/trips/new';

  @override
  State<TripFormScreen> createState() => _TripFormScreenState();
}

class _TripFormScreenState extends State<TripFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _destinoController = TextEditingController();
  final _observacoesController = TextEditingController();
  DateTime? _dataIda;
  DateTime? _dataVolta;
  TripPurpose? _finalidade;
  TripTransport? _transporte;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      context.read<DomainsController>().load();
    });
  }

  @override
  void dispose() {
    _destinoController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isIda}) async {
    final initialDate = isIda ? _dataIda ?? DateTime.now() : _dataVolta ?? _dataIda ?? DateTime.now();
    final firstDate = DateTime(2020);
    final lastDate = DateTime(2100);

    final selected = await showDatePicker(context: context, initialDate: initialDate, firstDate: firstDate, lastDate: lastDate);

    if (selected == null) {
      return;
    }

    setState(() {
      if (isIda) {
        _dataIda = selected;
        if (_dataVolta != null && _dataVolta!.isBefore(_dataIda!)) {
          _dataVolta = null;
        }
      } else {
        _dataVolta = selected;
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_dataIda == null || _dataVolta == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Informe as datas de ida e volta')));
      return;
    }
    if (_dataVolta!.isBefore(_dataIda!)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data de volta deve ser apos a ida')));
      return;
    }
    setState(() => _isSaving = true);

    final input = TripCreateInput(
      destino: _destinoController.text.trim(),
      dataIda: _dataIda!,
      dataVolta: _dataVolta!,
      finalidade: _finalidade!,
      transporte: _transporte!,
      observacoes: _observacoesController.text.trim(),
    );

    final controller = context.read<TripsController>();
    final success = await controller.createTrip(input);

    if (mounted) {
      setState(() => _isSaving = false);
      if (success) {
        Navigator.of(context).pop();
      } else {
        final message = controller.error ?? 'Falha ao criar viagem';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova viagem')),
      body: Consumer<DomainsController>(
        builder: (context, domains, _) {
          if (domains.state == LoadState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (domains.state == LoadState.error) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(domains.error ?? 'Erro ao carregar dominios'),
                    const SizedBox(height: 12),
                    OutlinedButton(onPressed: domains.load, child: const Text('Tentar novamente')),
                  ],
                ),
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _destinoController,
                      decoration: const InputDecoration(labelText: 'Destino', prefixIcon: Icon(Icons.location_on)),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o destino';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    _DateField(label: 'Data de ida', value: _dataIda, onTap: () => _pickDate(isIda: true)),
                    const SizedBox(height: 16),
                    _DateField(label: 'Data de volta', value: _dataVolta, onTap: () => _pickDate(isIda: false)),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<TripPurpose>(
                      initialValue: _finalidade,
                      items: domains.finalidades.map((item) => DropdownMenuItem(value: item, child: Text(tripPurposeLabel(item)))).toList(),
                      decoration: const InputDecoration(labelText: 'Finalidade', prefixIcon: Icon(Icons.description)),
                      onChanged: (value) => setState(() => _finalidade = value),
                      validator: (value) {
                        if (value == null) {
                          return 'Selecione a finalidade';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<TripTransport>(
                      initialValue: _transporte,
                      items: domains.transportes.map((item) => DropdownMenuItem(value: item, child: Text(tripTransportLabel(item)))).toList(),
                      decoration: InputDecoration(labelText: 'Transporte', prefixIcon: Icon(tripTransportIcon(_transporte ?? TripTransport.carroProprio))),
                      onChanged: (value) => setState(() => _transporte = value),
                      validator: (value) {
                        if (value == null) {
                          return 'Selecione o transporte';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _observacoesController,
                      decoration: const InputDecoration(labelText: 'Observacoes', prefixIcon: Icon(Icons.note)),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),
                    OutlinedButton(
                      onPressed: _isSaving ? null : _submit,
                      child: _isSaving ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Criar viagem'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({required this.label, required this.value, required this.onTap});

  final String label;
  final DateTime? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final text = value == null ? 'Selecionar' : shortDate.format(value!);
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(labelText: label, prefixIcon: Icon(Icons.calendar_today_outlined)),
        child: Text(text),
      ),
    );
  }
}
