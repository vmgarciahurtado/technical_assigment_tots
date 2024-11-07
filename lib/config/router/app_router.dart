import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:thechnical_assignment_tots/domain/clients/model/client.dart';
import 'package:thechnical_assignment_tots/presentation/clients/register_client_screen.dart';
import 'package:thechnical_assignment_tots/presentation/clients/update_client_screen.dart';
import 'package:thechnical_assignment_tots/presentation/presentation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(initialLocation: '/', routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/clients',
      builder: (context, state) => const ClientsScreen(),
    ),
    GoRoute(
      path: '/client_register',
      builder: (context, state) => const RegisterClientScreen(),
    ),
    GoRoute(
      path: '/client_update',
      builder: (context, state) {
        final client = state.extra as Client;
        return UpdateClientScreen(client: client);
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/user_register',
      builder: (context, state) => const RegisterUserScreen(),
    ),
  ]);
}
