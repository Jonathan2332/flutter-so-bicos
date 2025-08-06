import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:so_bicos/core/data/repositories/auth/auth_repository.dart';
import 'package:so_bicos/routing/routes.dart';
import 'package:so_bicos/ui/auth/login/viewmodels/login_viewmodel.dart';
import 'package:so_bicos/ui/auth/login/widgets/login_screen.dart';
import 'package:so_bicos/ui/auth/signup/viewmodels/signup_viewmodel.dart';
import 'package:so_bicos/ui/auth/signup/widgets/signup_screen.dart';
import 'package:so_bicos/ui/designsystem/localization/app_localizations.dart';
import 'package:so_bicos/ui/home/viewmodels/home_viewmodel.dart';
import 'package:so_bicos/ui/home/widgets/home_screen.dart';

GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: Routes.home,
  redirect: _redirect,
  refreshListenable: authRepository,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        return LoginScreen(
        viewModel: LoginViewModel(authRepository: context.read(), appLocalizations: AppLocalizations.of(context)!),
      );
      },
    ),
     GoRoute(
      path: Routes.signup,
      builder: (context, state) {
        return SignupScreen(
        viewModel: SignupViewModel(authRepository: context.read(), appLocalizations: AppLocalizations.of(context)!),
      );
      },
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => HomeScreen(viewModel: HomeViewModel(authRepository: context.read()),),
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final authRepository = context.read<AuthRepository>();
  final loggedUser = await authRepository.getLoggedUser();
  final loggingIn = state.matchedLocation == Routes.login;
  final signUpIn = state.matchedLocation == Routes.signup;

  if(signUpIn && loggedUser.isError()) {
    return Routes.signup;
  }

  if (loggedUser.isError()) {
    return Routes.login;
  }

  if (loggingIn || signUpIn) {
    return Routes.home;
  }

  return null;
}
