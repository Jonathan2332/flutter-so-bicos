import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:so_bicos/ui/auth/auth_view_state.dart';
import 'package:so_bicos/ui/auth/signup/viewmodels/signup_viewmodel.dart';
import 'package:so_bicos/ui/designsystem/components/scaffold.dart';
import 'package:so_bicos/ui/designsystem/components/text_form_field.dart';
import 'package:so_bicos/ui/designsystem/localization/app_localizations.dart';

class SignupScreen extends StatelessWidget {
  final SignupViewModel viewModel;
  const SignupScreen({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final formLoginKey = GlobalKey<FormState>();
    final email = TextEditingController();
    final password = TextEditingController();
    final passwordConfirm = TextEditingController();

    return SbScaffold(
      showNavigationBar: false,
      appBar: Center(
        child: Text(
          appLocalizations.signup,
          style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Form(
          key: formLoginKey,
          child: ValueListenableBuilder(
            valueListenable: viewModel.viewState,
            builder: (_, viewState, _) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  appLocalizations.create_an_account,
                  style: TextStyle(fontSize: 26),
                ),
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
                ValueListenableBuilder(
                  valueListenable: viewModel.obscureTextPasswordConfirm,
                  builder: (_, obscureText, _) => SbTextFormField(
                    controller: passwordConfirm,
                    enabled: viewState is! AuthLoadingState,
                    label: Text(appLocalizations.repeat_password),
                    icon: Icon(Icons.lock),
                    obscureText: obscureText,
                    validator: (text) {
                      return viewModel.getPasswordConfirmValidatorMessage(
                        text,
                        password.value.text,
                      );
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        viewModel.obscureTextPasswordConfirm.value =
                            !obscureText;
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
                              viewModel.signupWithCredentials((
                                email.value.text,
                                password.value.text,
                              ));
                            }
                          },
                    label: viewState is AuthLoadingState
                        ? LinearProgressIndicator()
                        : Text(appLocalizations.signup),
                  ),
                ),

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
