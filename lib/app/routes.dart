import 'package:flutter/material.dart';
import 'package:viagens_mobile/features/trips/presentation/trip_detail_screen.dart';
import 'package:viagens_mobile/features/trips/presentation/trip_form_screen.dart';
import 'package:viagens_mobile/features/trips/presentation/trips_list_screen.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == TripsListScreen.routeName) {
      return MaterialPageRoute(builder: (_) => const TripsListScreen());
    }
    if (settings.name == TripFormScreen.routeName) {
      return MaterialPageRoute(builder: (_) => const TripFormScreen());
    }
    if (settings.name == TripDetailScreen.routeName) {
      final args = settings.arguments as TripDetailArgs?;
      if (args == null) {
        return MaterialPageRoute(builder: (_) => const TripsListScreen());
      }
      return MaterialPageRoute(
        builder: (_) => TripDetailScreen(tripId: args.tripId),
      );
    }
    return null;
  }
}

class TripDetailArgs {
  const TripDetailArgs(this.tripId);

  final int tripId;
}
