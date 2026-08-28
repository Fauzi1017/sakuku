import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/domain.dart';
import '../../features/admin/admin_home_screen.dart';
import '../../features/auth/auth_provider.dart';
import '../../features/auth/login_screen.dart';
import '../../features/pembina/pembina_home_screen.dart';
import '../../features/peserta/home/peserta_home_screen.dart';
import '../../features/shared/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: _AuthRefreshListenable(ref),
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      final loggingIn = state.matchedLocation == '/login';

      if (auth is AuthLoading) return null;

      if (auth is AuthUnauthenticated) {
        return loggingIn ? null : '/login';
      }

      if (auth is AuthAuthenticated) {
        if (loggingIn || state.matchedLocation == '/') {
          return switch (auth.role) {
            RoleType.pesertaDidik => '/peserta',
            RoleType.pembina || RoleType.pelatihSkk => '/pembina',
            RoleType.adminGudep || RoleType.kwartir => '/admin',
          };
        }
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/peserta',
        builder: (context, state) => const PesertaHomeScreen(),
      ),
      GoRoute(
        path: '/pembina',
        builder: (context, state) => const PembinaHomeScreen(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminHomeScreen(),
      ),
    ],
  );
});

class _AuthRefreshListenable extends ChangeNotifier {
  _AuthRefreshListenable(Ref ref) {
    ref.listen<AuthState>(authControllerProvider, (prev, next) {
      notifyListeners();
    });
  }
}
