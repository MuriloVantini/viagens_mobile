import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viagens_mobile/app/auth_gate.dart';
import 'package:viagens_mobile/app/routes.dart';
import 'package:viagens_mobile/app/theme.dart';

class ViagensApp extends StatelessWidget {
  const ViagensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        
      ],
      child: MaterialApp(
        title: 'Viagens',
        theme: buildAppTheme(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        home: const AuthGate(),
      ),
    );
  }
}
