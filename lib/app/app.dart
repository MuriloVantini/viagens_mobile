import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viagens_mobile/app/auth_gate.dart';
import 'package:viagens_mobile/app/routes.dart';
import 'package:viagens_mobile/app/theme.dart';
import 'package:viagens_mobile/core/app_config.dart';
import 'package:viagens_mobile/data/api/api_client.dart';
import 'package:viagens_mobile/data/auth/auth_api.dart';
import 'package:viagens_mobile/data/storage/token_storage.dart';

class ViagensApp extends StatelessWidget {
  const ViagensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TokenStorage>(create: (_) => TokenStorage()),
        Provider<ApiClient>(
          create: (context) => ApiClient(
            baseUrl: AppConfig.baseUrl,
            tokenStorage: context.read<TokenStorage>(),
          ),
        ),
        Provider<AuthApi>(create: (context) => AuthApi(context.read<ApiClient>())),
        
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
