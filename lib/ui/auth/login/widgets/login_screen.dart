import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:so_bicos/routing/routes.dart';
import 'package:so_bicos/ui/auth/auth_view_state.dart';
import 'package:so_bicos/ui/auth/login/viewmodels/login_viewmodel.dart';
import 'package:so_bicos/ui/designsystem/components/text_form_field.dart';
import 'package:so_bicos/ui/designsystem/localization/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  final LoginViewModel viewModel;
  const LoginScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final formLoginKey = GlobalKey<FormState>();
    final email = TextEditingController();
    final password = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.login)),
      body: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Form(
          key: formLoginKey,
          child: ValueListenableBuilder(
            valueListenable: viewModel.viewState,
            builder: (_, viewState, _) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(appLocalizations.welcome, style: TextStyle(fontSize: 26)),
                SizedBox(height: 16),
                SbTextFormField(
                  controller: email,
                  enabled: viewState is! AuthLoadingState,
                  label: Text(appLocalizations.email),
                  icon: Icon(Icons.person),
                  hint: Text("example@email.com"),
                  validator: viewModel.getEmailValidatorMessage,
                ),
                SizedBox(height: 16),
                ValueListenableBuilder(
                  valueListenable: viewModel.obscureTextPassword,
                  builder: (_, obscureText, _) => SbTextFormField(
                    controller: password,
                    enabled: viewState is! AuthLoadingState,
                    label: Text(appLocalizations.password),
                    icon: Icon(Icons.lock),
                    obscureText: obscureText,
                    validator: viewModel.getPasswordValidatorMessage,
                    suffixIcon: IconButton(
                      onPressed: () {
                        viewModel.obscureTextPassword.value = !obscureText;
                      },
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                AnimatedSize(
                  duration: Durations.medium2,
                  child: ElevatedButton.icon(
                    onPressed: viewModel is AuthLoadingState
                        ? null
                        : () {
                            if (formLoginKey.currentState?.validate() == true) {
                              formLoginKey.currentState?.save();
                              viewModel.loginEmail((
                                email.value.text,
                                password.value.text,
                              ));
                            }
                          },
                    label: viewState is AuthLoadingState
                        ? LinearProgressIndicator()
                        : Text(appLocalizations.login),
                    icon: viewState is AuthLoadingState
                        ? null
                        : Icon(Icons.login),
                  ),
                ),

                if (viewState is! AuthLoadingState) ...[
                  SizedBox(height: 32),
                  Text(appLocalizations.dont_have_an_account),
                  TextButton(
                    onPressed: () {
                      context.go(Routes.signup);
                    },
                    child: Text(appLocalizations.create_an_account),
                  ),
                ],
                if (viewState is AuthErrorState) ...[
                  SizedBox(height: 16),
                  Text(
                    viewState.message,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
