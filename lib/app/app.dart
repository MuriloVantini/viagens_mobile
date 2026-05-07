import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:viagens_mobile/app/auth_gate.dart';
import 'package:viagens_mobile/app/routes.dart';
import 'package:viagens_mobile/app/theme.dart';
import 'package:viagens_mobile/core/app_config.dart';
import 'package:viagens_mobile/data/api/api_client.dart';
import 'package:viagens_mobile/data/auth/auth_api.dart';
import 'package:viagens_mobile/data/domains/domains_api.dart';
import 'package:viagens_mobile/data/repositories/auth_repository_impl.dart';
import 'package:viagens_mobile/data/repositories/domains_repository_impl.dart';
import 'package:viagens_mobile/data/repositories/trips_repository_impl.dart';
import 'package:viagens_mobile/data/storage/token_storage.dart';
import 'package:viagens_mobile/data/trips/trips_api.dart';
import 'package:viagens_mobile/domain/contracts/auth_repository.dart';
import 'package:viagens_mobile/domain/contracts/domains_repository.dart';
import 'package:viagens_mobile/domain/contracts/trips_repository.dart';
import 'package:viagens_mobile/features/auth/state/auth_controller.dart';
import 'package:viagens_mobile/features/trips/state/domains_controller.dart';
import 'package:viagens_mobile/features/trips/state/trips_controller.dart';

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
        Provider<TripsApi>(create: (context) => TripsApi(context.read<ApiClient>())),
        Provider<DomainsApi>(
          create: (context) => DomainsApi(context.read<ApiClient>()),
        ),
        Provider<IAuthRepository>(
          create: (context) => AuthRepositoryImpl(
            authApi: context.read<AuthApi>(),
            tokenStorage: context.read<TokenStorage>(),
          ),
        ),
        Provider<ITripsRepository>(
          create: (context) => TripsRepositoryImpl(
            tripsApi: context.read<TripsApi>(),
          ),
        ),
        Provider<IDomainsRepository>(
          create: (context) => DomainsRepositoryImpl(
            domainsApi: context.read<DomainsApi>(),
          ),
        ),
        ChangeNotifierProvider<AuthController>(
          create: (context) => AuthController(
            authRepository: context.read<IAuthRepository>(),
          ),
        ),
        ChangeNotifierProvider<TripsController>(
          create: (context) => TripsController(
            tripsRepository: context.read<ITripsRepository>(),
          ),
        ),
        ChangeNotifierProvider<DomainsController>(
          create: (context) => DomainsController(
            domainsRepository: context.read<IDomainsRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Viagens',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        home: const AuthGate(),
      ),
    );
  }
}
