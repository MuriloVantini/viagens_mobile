enum TripStatus {
  agendada,
  emAndamento,
  concluida,
  cancelada,
}

TripStatus tripStatusFromApi(String value) {
  switch (value) {
    case 'AGENDADA':
      return TripStatus.agendada;
    case 'EM_ANDAMENTO':
      return TripStatus.emAndamento;
    case 'CONCLUIDA':
      return TripStatus.concluida;
    case 'CANCELADA':
      return TripStatus.cancelada;
  }
  return TripStatus.agendada;
}

String tripStatusToApi(TripStatus status) {
  switch (status) {
    case TripStatus.agendada:
      return 'AGENDADA';
    case TripStatus.emAndamento:
      return 'EM_ANDAMENTO';
    case TripStatus.concluida:
      return 'CONCLUIDA';
    case TripStatus.cancelada:
      return 'CANCELADA';
  }
}

String tripStatusLabel(TripStatus status) {
  switch (status) {
    case TripStatus.agendada:
      return 'Agendada';
    case TripStatus.emAndamento:
      return 'Em andamento';
    case TripStatus.concluida:
      return 'Concluida';
    case TripStatus.cancelada:
      return 'Cancelada';
  }
}
