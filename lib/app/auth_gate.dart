import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viagens_mobile/features/auth/presentation/login_screen.dart';
import 'package:viagens_mobile/features/auth/state/auth_controller.dart';
import 'package:viagens_mobile/features/trips/presentation/trips_list_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      context.read<AuthController>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, auth, _) {
        if (!auth.isInitialized) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (auth.isAuthenticated) {
          return const TripsListScreen();
        }
        return const LoginScreen();
      },
    );
  }
}
